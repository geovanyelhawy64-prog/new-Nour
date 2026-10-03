#!/usr/bin/env python3
"""Read-only content audit and reviewer-sheet generator for Noor."""

from __future__ import annotations

import argparse
import csv
import json
import re
import sqlite3
import sys
import unicodedata
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable

HTML = re.compile(r"<\s*/?\s*[a-zA-Z][^>]*>")
CONTROL = re.compile(r"[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]")


def write_csv(path: Path, headers: list[str], rows: Iterable[Iterable[object]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8-sig", newline="") as stream:
        writer = csv.writer(stream)
        writer.writerow(headers)
        writer.writerows(rows)


def chapter_rows(db: sqlite3.Connection) -> list[tuple]:
    return list(
        db.execute(
            """SELECT b.id, b.name_ar, v.chapter, COUNT(*),
                      MIN(v.verse_number), MAX(v.verse_number)
               FROM bible_verses v
               JOIN bible_books b ON b.id = v.book_id
               GROUP BY b.id, b.name_ar, v.chapter
               ORDER BY b.book_order, v.chapter"""
        )
    )


def numbering_anomalies(db: sqlite3.Connection) -> list[tuple]:
    anomalies = []
    for book_id, name, chapter, count, minimum, maximum in chapter_rows(db):
        numbers = [
            row[0]
            for row in db.execute(
                """SELECT verse_number FROM bible_verses
                   WHERE book_id = ? AND chapter = ? ORDER BY verse_number""",
                (book_id, chapter),
            )
        ]
        counter = Counter(numbers)
        duplicates = sorted(number for number, amount in counter.items() if amount > 1)
        expected_start = 1
        missing = sorted(set(range(expected_start, maximum + 1)) - set(numbers))
        unexpected = sorted(number for number in numbers if number < expected_start)
        if missing or duplicates or unexpected:
            anomalies.append(
                (
                    book_id,
                    name,
                    chapter,
                    count,
                    minimum,
                    maximum,
                    " ".join(map(str, missing)),
                    " ".join(map(str, duplicates)),
                    " ".join(map(str, unexpected)),
                )
            )
    return anomalies


def missing_cross_references(db: sqlite3.Connection) -> list[tuple]:
    return list(
        db.execute(
            """SELECT x.id,
                      x.source_book_id, x.source_chapter, x.source_verse,
                      x.target_book_id, x.target_chapter, x.target_verse,
                      CASE WHEN source.id IS NULL THEN 1 ELSE 0 END,
                      CASE WHEN target.id IS NULL THEN 1 ELSE 0 END
               FROM bible_cross_references x
               LEFT JOIN bible_verses source
                 ON source.book_id = x.source_book_id
                AND source.chapter = x.source_chapter
                AND source.verse_number = x.source_verse
               LEFT JOIN bible_verses target
                 ON target.book_id = x.target_book_id
                AND target.chapter = x.target_chapter
                AND target.verse_number = x.target_verse
               WHERE source.id IS NULL OR target.id IS NULL
               ORDER BY x.id"""
        )
    )


def text_issues(db: sqlite3.Connection) -> tuple[list[tuple], int]:
    issues: list[tuple] = []
    nfc_count = 0
    rows = db.execute(
        """SELECT v.id, b.name_ar, v.chapter, v.verse_number, v.text
           FROM bible_verses v JOIN bible_books b ON b.id = v.book_id
           ORDER BY v.id"""
    )
    for verse_id, book, chapter, verse, text in rows:
        kinds = []
        if not text or not text.strip():
            kinds.append("empty")
        if text and HTML.search(text):
            kinds.append("html")
        if text and CONTROL.search(text):
            kinds.append("control")
        if text and not unicodedata.is_normalized("NFC", text):
            nfc_count += 1
        if kinds:
            issues.append((verse_id, book, chapter, verse, " ".join(kinds)))
    return issues, nfc_count


def hymns_without_segments(db: sqlite3.Connection) -> list[tuple]:
    return list(
        db.execute(
            """SELECT h.id, h.name_ar, h.book_id
               FROM hymns h LEFT JOIN hymn_segments s ON s.hymn_id = h.id
               GROUP BY h.id, h.name_ar, h.book_id
               HAVING COUNT(s.id) = 0
               ORDER BY h.book_id, h.hymn_order"""
        )
    )


def compare_reference_counts(
    actual: list[tuple], reference_path: Path | None
) -> list[tuple]:
    if reference_path is None:
        return []
    actual_map = {(row[0], row[2]): row[3] for row in actual}
    mismatches = []
    with reference_path.open(encoding="utf-8-sig", newline="") as stream:
        for row in csv.DictReader(stream):
            book_id = int(row["book_id"])
            chapter = int(row["chapter"])
            expected = int(row["expected_count"])
            found = actual_map.get((book_id, chapter))
            if found != expected:
                mismatches.append(
                    (book_id, row.get("book_name", ""), chapter, expected, found or 0)
                )
    return mismatches


def audit(database: Path, output: Path, reference: Path | None = None) -> dict:
    uri = f"file:{database.resolve().as_posix()}?mode=ro"
    db = sqlite3.connect(uri, uri=True)
    try:
        integrity = db.execute("PRAGMA integrity_check").fetchone()[0]
        chapters = chapter_rows(db)
        numbering = numbering_anomalies(db)
        references = missing_cross_references(db)
        verses, non_nfc = text_issues(db)
        empty_hymns = hymns_without_segments(db)
        count_mismatches = compare_reference_counts(chapters, reference)
        total_verses = db.execute("SELECT COUNT(*) FROM bible_verses").fetchone()[0]
    finally:
        db.close()

    output.mkdir(parents=True, exist_ok=True)
    write_csv(
        output / "chapter_verse_counts.csv",
        ["book_id", "book_name", "chapter", "actual_count", "min_verse", "max_verse"],
        chapters,
    )
    write_csv(
        output / "verse_numbering_anomalies.csv",
        [
            "book_id", "book_name", "chapter", "actual_count", "min_verse",
            "max_verse", "missing", "duplicates", "unexpected_below_1",
        ],
        numbering,
    )
    write_csv(
        output / "missing_cross_references.csv",
        [
            "id", "source_book", "source_chapter", "source_verse", "target_book",
            "target_chapter", "target_verse", "source_missing", "target_missing",
        ],
        references,
    )
    write_csv(
        output / "verse_text_issues.csv",
        ["verse_id", "book_name", "chapter", "verse", "issues"],
        verses,
    )
    write_csv(
        output / "hymns_without_segments.csv",
        ["hymn_id", "hymn_name", "book_id"],
        empty_hymns,
    )
    write_csv(
        output / "reference_count_mismatches.csv",
        ["book_id", "book_name", "chapter", "expected_count", "actual_count"],
        count_mismatches,
    )
    summary = {
        "generated_at_utc": datetime.now(timezone.utc).isoformat(),
        "database": database.name,
        "integrity_check": integrity,
        "total_verses": total_verses,
        "chapters": len(chapters),
        "verse_numbering_anomalies": len(numbering),
        "verse_text_issues": len(verses),
        "non_nfc_verse_texts": non_nfc,
        "missing_cross_references": len(references),
        "hymns_without_segments": len(empty_hymns),
        "reference_count_mismatches": len(count_mismatches),
        "reference_counts_supplied": reference is not None,
        "note": "An anomaly is a review target, not an automatic textual correction.",
    }
    (output / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    return summary


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--database", type=Path, default=Path("assets/databases/noor.db"))
    parser.add_argument("--output", type=Path, default=Path("review_sheets/generated"))
    parser.add_argument(
        "--reference-counts",
        type=Path,
        help="Signed edition CSV: book_id,book_name,chapter,expected_count",
    )
    parser.add_argument("--strict", action="store_true", help="Exit 1 when issues exist")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        summary = audit(args.database, args.output, args.reference_counts)
    except Exception as error:
        print(f"content audit failed: {error}", file=sys.stderr)
        return 2
    print(json.dumps(summary, ensure_ascii=False, indent=2))
    blocking = any(
        summary[key]
        for key in (
            "verse_numbering_anomalies",
            "verse_text_issues",
            "missing_cross_references",
            "hymns_without_segments",
            "reference_count_mismatches",
        )
    )
    return 1 if args.strict and blocking else 0


if __name__ == "__main__":
    raise SystemExit(main())
