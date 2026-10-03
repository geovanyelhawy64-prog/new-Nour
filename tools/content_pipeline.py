#!/usr/bin/env python3
"""Build reproducible Noor content and user databases.

The source database is never modified. A release build fails closed when any
content row is not approved; it never silently ships drafts.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import shutil
import sqlite3
import sys
import unicodedata
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

USER_TABLES = {"bookmarks", "verse_highlights"}
REVIEW_STATES = {"draft", "reviewed", "approved"}
# Arabic and Quranic annotation marks; must stay identical to the Dart query normalizer.
ARABIC_MARKS = re.compile(r"[\u0610-\u061a\u064b-\u065f\u0670\u06d6-\u06ed]")
SPACES = re.compile(r"\s+")
SEARCH_TRANSLATION = str.maketrans(
    {"أ": "ا", "إ": "ا", "آ": "ا", "ٱ": "ا", "ء": "", "ؤ": "و", "ئ": "ي", "ة": "ه", "ى": "ي"}
)


def quote_identifier(value: str) -> str:
    return '"' + value.replace('"', '""') + '"'


def normalize_search(value: str) -> str:
    value = ARABIC_MARKS.sub("", value.strip()).replace("ـ", "")
    value = value.translate(SEARCH_TRANSLATION)
    return SPACES.sub(" ", value).lower()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def regular_tables(db: sqlite3.Connection) -> list[str]:
    return [
        row[0]
        for row in db.execute(
            """SELECT name FROM sqlite_master
               WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
               ORDER BY name"""
        )
        if not row[0].startswith("bible_verses_fts")
    ]


def table_columns(db: sqlite3.Connection, table: str) -> list[sqlite3.Row]:
    return list(db.execute(f"PRAGMA table_info({quote_identifier(table)})"))


def add_review_columns(db: sqlite3.Connection, tables: list[str]) -> None:
    for table in tables:
        if table in USER_TABLES:
            continue
        existing = {row[1] for row in table_columns(db, table)}
        additions = {
            "source_id": "TEXT",
            "source_ref": "TEXT",
            "review_status": (
                "TEXT NOT NULL DEFAULT 'draft' "
                "CHECK (review_status IN ('draft','reviewed','approved'))"
            ),
            "verified_by": "TEXT",
            "verified_at": "TEXT",
        }
        for column, declaration in additions.items():
            if column not in existing:
                db.execute(
                    f"ALTER TABLE {quote_identifier(table)} "
                    f"ADD COLUMN {quote_identifier(column)} {declaration}"
                )


def apply_source_metadata(db: sqlite3.Connection, metadata_path: Path | None) -> None:
    if metadata_path is None:
        return
    payload = json.loads(metadata_path.read_text(encoding="utf-8"))
    sources = payload.get("sources", [])
    if not isinstance(sources, list):
        raise ValueError("sources must be a list")
    source_ids = set()
    for source in sources:
        if not isinstance(source, dict) or not source.get("id"):
            raise ValueError("Every source must have a non-empty id")
        source_id = source["id"]
        if source_id in source_ids:
            raise ValueError(f"Duplicate source id: {source_id}")
        source_ids.add(source_id)

    # table_metadata is the new name; tables remains supported for compatibility.
    table_metadata = payload.get("table_metadata", payload.get("tables", {}))
    known = set(regular_tables(db)) - USER_TABLES
    unknown = set(table_metadata) - known
    if unknown:
        raise ValueError(f"Unknown tables in source metadata: {sorted(unknown)}")

    for table, values in table_metadata.items():
        state = values.get("review_status", "draft")
        if state not in REVIEW_STATES:
            raise ValueError(f"Invalid review_status for {table}: {state}")
        source_id = values.get("source_id")
        if source_id is not None and source_id not in source_ids:
            raise ValueError(f"Unknown source_id for {table}: {source_id}")
        source_ref = values.get("source_ref") or source_id
        verified_by = values.get("verified_by")
        verified_at = values.get("verified_at")
        if state == "approved" and (not source_ref or not verified_by or not verified_at):
            raise ValueError(
                f"Approved table {table} requires source_ref, verified_by and verified_at"
            )
        db.execute(
            f"""UPDATE {quote_identifier(table)}
                SET source_id = ?, source_ref = ?, review_status = ?,
                    verified_by = ?, verified_at = ?""",
            (source_id, source_ref, state, verified_by, verified_at),
        )

    for table, rows in payload.get("records", {}).items():
        if table not in known:
            raise ValueError(f"Unknown table in record metadata: {table}")
        if not isinstance(rows, list):
            raise ValueError(f"Record metadata for {table} must be a list")
        columns = {row[1] for row in table_columns(db, table)}
        if "id" not in columns:
            raise ValueError(f"Per-record metadata requires an id column: {table}")
        for values in rows:
            if not isinstance(values, dict) or not values.get("id"):
                raise ValueError(f"Every {table} metadata row requires id")
            source_id = values.get("source_id")
            if source_id not in source_ids:
                raise ValueError(f"Unknown source_id for {table} record: {source_id}")
            state = values.get("review_status", "draft")
            source_ref = values.get("source_ref") or source_id
            verified_by = values.get("verified_by")
            verified_at = values.get("verified_at")
            if state not in REVIEW_STATES:
                raise ValueError(f"Invalid review_status for {table}: {state}")
            if state == "approved" and (not source_ref or not verified_by or not verified_at):
                raise ValueError(f"Approved record in {table} requires source and reviewer")
            cursor = db.execute(
                f"""UPDATE {quote_identifier(table)}
                    SET source_id = ?, source_ref = ?, review_status = ?,
                        verified_by = ?, verified_at = ?
                    WHERE id = ?""",
                (source_id, source_ref, state, verified_by, verified_at, values["id"]),
            )
            if cursor.rowcount == 0:
                raise ValueError(f"Unknown record id in {table}: {values['id']}")


def normalize_all_text_to_nfc(db: sqlite3.Connection, tables: list[str]) -> int:
    changed = 0
    for table in tables:
        text_columns = [
            row[1] for row in table_columns(db, table) if "TEXT" in (row[2] or "").upper()
        ]
        if not text_columns:
            continue
        selected = ", ".join(["rowid"] + [quote_identifier(c) for c in text_columns])
        rows = list(db.execute(f"SELECT {selected} FROM {quote_identifier(table)}"))
        for row in rows:
            updates: dict[str, str] = {}
            for index, column in enumerate(text_columns, start=1):
                value = row[index]
                if value is None:
                    continue
                normalized = unicodedata.normalize("NFC", value)
                if normalized != value:
                    updates[column] = normalized
            if updates:
                assignments = ", ".join(f"{quote_identifier(c)} = ?" for c in updates)
                db.execute(
                    f"UPDATE {quote_identifier(table)} SET {assignments} WHERE rowid = ?",
                    (*updates.values(), row[0]),
                )
                changed += len(updates)
    return changed


def clear_user_data(db: sqlite3.Connection) -> None:
    for table in USER_TABLES.intersection(regular_tables(db)):
        db.execute(f"DELETE FROM {quote_identifier(table)}")


def build_bible_fts(db: sqlite3.Connection) -> int:
    try:
        db.execute("CREATE VIRTUAL TABLE temp.fts5_probe USING fts5(value)")
        db.execute("DROP TABLE temp.fts5_probe")
    except sqlite3.OperationalError as error:
        raise RuntimeError("This SQLite build does not support FTS5") from error

    db.execute("DROP TABLE IF EXISTS bible_verses_fts")
    db.execute(
        """CREATE VIRTUAL TABLE bible_verses_fts USING fts5(
               verse_id UNINDEXED,
               normalized_text,
               tokenize = 'unicode61'
           )"""
    )
    rows = db.execute("SELECT id, text FROM bible_verses ORDER BY id")
    count = 0
    for verse_id, text in rows:
        db.execute(
            "INSERT INTO bible_verses_fts(rowid, verse_id, normalized_text) VALUES (?, ?, ?)",
            (verse_id, verse_id, normalize_search(text)),
        )
        count += 1
    return count


def assert_release_ready(db: sqlite3.Connection, tables: list[str]) -> None:
    failures: list[str] = []
    for table in tables:
        if table in USER_TABLES:
            continue
        row = db.execute(
            f"""SELECT COUNT(*) FROM {quote_identifier(table)}
                WHERE review_status <> 'approved'
                   OR source_id IS NULL OR trim(source_id) = ''
                   OR source_ref IS NULL OR trim(source_ref) = ''
                   OR verified_by IS NULL OR trim(verified_by) = ''
                   OR verified_at IS NULL OR trim(verified_at) = ''"""
        ).fetchone()
        if row and row[0]:
            failures.append(f"{table}: {row[0]} unapproved/undocumented rows")
    if failures:
        raise RuntimeError("Release blocked:\n  " + "\n  ".join(failures))


def verify_database(db: sqlite3.Connection, tables: list[str]) -> None:
    integrity = db.execute("PRAGMA integrity_check").fetchone()[0]
    if integrity != "ok":
        raise RuntimeError(f"integrity_check failed: {integrity}")
    foreign_keys = list(db.execute("PRAGMA foreign_key_check"))
    if foreign_keys:
        raise RuntimeError(f"foreign_key_check found {len(foreign_keys)} errors")
    for table in tables:
        for column in table_columns(db, table):
            if "TEXT" not in (column[2] or "").upper():
                continue
            name = column[1]
            for (value,) in db.execute(
                f"SELECT {quote_identifier(name)} FROM {quote_identifier(table)} "
                f"WHERE {quote_identifier(name)} IS NOT NULL"
            ):
                if not unicodedata.is_normalized("NFC", value):
                    raise RuntimeError(f"Non-NFC value remains in {table}.{name}")


def create_user_database(path: Path) -> None:
    if path.exists():
        path.unlink()
    db = sqlite3.connect(path)
    try:
        db.executescript(
            """
            PRAGMA user_version = 1;
            CREATE TABLE migration_metadata (
              migration_key TEXT PRIMARY KEY NOT NULL,
              completed_at TEXT NOT NULL
            );
            CREATE TABLE bookmarks (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              content_type TEXT NOT NULL,
              content_id TEXT NOT NULL,
              display_title TEXT NOT NULL,
              note TEXT,
              created_at INTEGER NOT NULL,
              UNIQUE(content_type, content_id)
            );
            CREATE TABLE verse_highlights (
              id TEXT PRIMARY KEY NOT NULL,
              book_id INTEGER NOT NULL,
              chapter INTEGER NOT NULL,
              verse_number INTEGER NOT NULL,
              color TEXT NOT NULL,
              created_at TEXT NOT NULL,
              UNIQUE(book_id, chapter, verse_number)
            );
            """
        )
        db.commit()
    finally:
        db.close()


def table_counts(db: sqlite3.Connection, tables: list[str]) -> dict[str, int]:
    return {
        table: db.execute(f"SELECT COUNT(*) FROM {quote_identifier(table)}").fetchone()[0]
        for table in tables
    }


def source_registry_snapshot(metadata_path: Path | None) -> list[dict[str, Any]]:
    if metadata_path is None:
        return []
    payload = json.loads(metadata_path.read_text(encoding="utf-8"))
    return [
        {
            "id": source["id"],
            "category": source.get("category"),
            "title": source.get("title"),
            "authority_level": source.get("authority_level"),
            "rights_status": source.get("rights_status"),
            "permission_reference": source.get("permission_reference"),
        }
        for source in payload.get("sources", [])
    ]


def provenance_summary(db: sqlite3.Connection, tables: list[str]) -> dict[str, dict[str, int]]:
    summary: dict[str, dict[str, int]] = {}
    for table in tables:
        columns = {row[1] for row in table_columns(db, table)}
        if not {'source_id', 'review_status'}.issubset(columns):
            continue
        rows = db.execute(
            f"""SELECT COALESCE(source_id, '<missing>'), review_status, COUNT(*)
                FROM {quote_identifier(table)}
                GROUP BY source_id, review_status
                ORDER BY source_id, review_status"""
        )
        summary[table] = {
            f"{source_id}:{status}": count
            for source_id, status, count in rows
        }
    return summary


def build(args: argparse.Namespace) -> dict[str, Any]:
    source = args.source.resolve()
    output = args.output.resolve()
    user_output = args.user_output.resolve()
    if not source.is_file():
        raise FileNotFoundError(source)
    if source == output:
        raise ValueError("Output must differ from source; source is never modified")

    output.parent.mkdir(parents=True, exist_ok=True)
    user_output.parent.mkdir(parents=True, exist_ok=True)
    temporary = output.with_suffix(output.suffix + ".building")
    temporary.unlink(missing_ok=True)
    shutil.copy2(source, temporary)

    db = sqlite3.connect(temporary)
    try:
        db.execute("PRAGMA foreign_keys = ON")
        tables = regular_tables(db)
        db.execute("BEGIN IMMEDIATE")
        add_review_columns(db, tables)
        apply_source_metadata(db, args.sources)
        clear_user_data(db)
        normalized_values = normalize_all_text_to_nfc(db, tables)
        fts_rows = build_bible_fts(db)
        if args.release:
            assert_release_ready(db, tables)
        db.commit()
        verify_database(db, regular_tables(db))
        counts = table_counts(db, tables)
        provenance = provenance_summary(db, tables)
        db.execute("VACUUM")
    except Exception:
        db.rollback()
        db.close()
        temporary.unlink(missing_ok=True)
        raise
    else:
        db.close()

    output.unlink(missing_ok=True)
    temporary.replace(output)
    create_user_database(user_output)
    manifest = {
        "schema": 1,
        "built_at_utc": datetime.now(timezone.utc).isoformat(),
        "release": bool(args.release),
        "source_file": source.name,
        "content_db": {
            "file": output.name,
            "sha256": sha256_file(output),
            "bytes": output.stat().st_size,
            "table_counts": counts,
            "provenance": provenance,
            "source_registry": source_registry_snapshot(args.sources),
            "source_registry_sha256": (
                sha256_file(args.sources) if args.sources is not None else None
            ),
            "fts_rows": fts_rows,
            "nfc_values_changed": normalized_values,
        },
        "user_db": {
            "file": user_output.name,
            "sha256": sha256_file(user_output),
            "bytes": user_output.stat().st_size,
        },
    }
    args.manifest.parent.mkdir(parents=True, exist_ok=True)
    args.manifest.write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    return manifest


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=Path("assets/databases/noor.db"))
    parser.add_argument("--output", type=Path, default=Path("build/content.db"))
    parser.add_argument("--user-output", type=Path, default=Path("build/user.db"))
    parser.add_argument("--manifest", type=Path, default=Path("build/content_manifest.json"))
    parser.add_argument("--sources", type=Path, help="JSON review/source metadata")
    parser.add_argument(
        "--release",
        action="store_true",
        help="Fail unless every content record is approved and documented",
    )
    return parser.parse_args()


def main() -> int:
    try:
        manifest = build(parse_args())
    except Exception as error:
        print(f"content pipeline failed: {error}", file=sys.stderr)
        return 1
    print(json.dumps(manifest, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
