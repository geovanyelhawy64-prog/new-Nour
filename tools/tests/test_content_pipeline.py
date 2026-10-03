import argparse
import hashlib
import sqlite3
import tempfile
import unittest
from pathlib import Path

from tools.content_pipeline import build, normalize_search


class ContentPipelineTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        self.source = self.root / "source.db"
        db = sqlite3.connect(self.source)
        db.executescript(
            """
            CREATE TABLE bible_verses (
              id INTEGER PRIMARY KEY,
              book_id INTEGER NOT NULL,
              chapter INTEGER NOT NULL,
              verse_number INTEGER NOT NULL,
              text TEXT NOT NULL
            );
            CREATE TABLE articles (id TEXT PRIMARY KEY, body TEXT NOT NULL);
            CREATE TABLE bookmarks (
              id INTEGER PRIMARY KEY, content_type TEXT, content_id TEXT,
              display_title TEXT, note TEXT, created_at INTEGER
            );
            CREATE TABLE verse_highlights (
              id TEXT PRIMARY KEY, book_id INTEGER, chapter INTEGER,
              verse_number INTEGER, color TEXT, created_at TEXT
            );
            INSERT INTO bible_verses VALUES (1, 1, 1, 1, 'فِي الْبَدْءِ');
            INSERT INTO articles VALUES ('one', 'أمين');
            INSERT INTO bookmarks VALUES (1, 'bible', '1/1', 'قديم', NULL, 1);
            INSERT INTO verse_highlights VALUES ('1:1:1', 1, 1, 1, 'gold', 'now');
            """
        )
        db.commit()
        db.close()
        self.source_hash = hashlib.sha256(self.source.read_bytes()).hexdigest()

    def tearDown(self):
        self.temp.cleanup()

    def args(self, release=False):
        return argparse.Namespace(
            source=self.source,
            output=self.root / "content.db",
            user_output=self.root / "user.db",
            manifest=self.root / "manifest.json",
            sources=None,
            release=release,
        )

    def test_build_normalizes_indexes_and_keeps_source_untouched(self):
        manifest = build(self.args())
        self.assertEqual(hashlib.sha256(self.source.read_bytes()).hexdigest(), self.source_hash)
        self.assertEqual(manifest["content_db"]["fts_rows"], 1)

        db = sqlite3.connect(self.root / "content.db")
        self.assertEqual(db.execute("PRAGMA integrity_check").fetchone()[0], "ok")
        self.assertEqual(db.execute("SELECT COUNT(*) FROM bookmarks").fetchone()[0], 0)
        self.assertEqual(db.execute("SELECT body FROM articles").fetchone()[0], "أمين")
        self.assertEqual(
            db.execute(
                "SELECT COUNT(*) FROM bible_verses_fts WHERE bible_verses_fts MATCH ?",
                (normalize_search("في البدء"),),
            ).fetchone()[0],
            1,
        )
        db.close()

        user = sqlite3.connect(self.root / "user.db")
        self.assertEqual(user.execute("SELECT COUNT(*) FROM bookmarks").fetchone()[0], 0)
        self.assertEqual(user.execute("SELECT COUNT(*) FROM verse_highlights").fetchone()[0], 0)
        user.close()

    def test_per_record_provenance_is_written_to_content_database(self):
        sources = self.root / "record-sources.json"
        sources.write_text(
            '{"sources": [{"id": "bible.test", "category": "bible"}], '
            '"records": {"bible_verses": [{"id": 1, '
            '"source_id": "bible.test", "source_ref": "edition page 1", '
            '"review_status": "approved", "verified_by": "Reviewer", '
            '"verified_at": "2026-10-03"}]}}',
            encoding="utf-8",
        )
        args = self.args()
        args.sources = sources
        manifest = build(args)
        self.assertIsNotNone(manifest["content_db"]["sha256"])
        self.assertIsNotNone(manifest["content_db"]["source_registry_sha256"])

        db = sqlite3.connect(self.root / "content.db")
        row = db.execute(
            "SELECT source_id, source_ref, review_status, verified_by "
            "FROM bible_verses WHERE id = 1"
        ).fetchone()
        db.close()
        self.assertEqual(row, ("bible.test", "edition page 1", "approved", "Reviewer"))

    def test_release_fails_closed_for_unapproved_content(self):
        with self.assertRaisesRegex(RuntimeError, "Release blocked"):
            build(self.args(release=True))
        self.assertFalse((self.root / "content.db").exists())

    def test_categorized_source_id_is_validated(self):
        sources = self.root / "sources.json"
        sources.write_text(
            '{"schema_version": 1, '
            '"sources": [{"id": "bible.test", "category": "bible"}], '
            '"table_metadata": {"bible_verses": {'
            '"source_id": "bible.test", "review_status": "draft"}}}',
            encoding="utf-8",
        )
        args = self.args()
        args.sources = sources
        build(args)

        invalid = self.root / "invalid-sources.json"
        invalid.write_text(
            '{"sources": [{"id": "bible.test"}], '
            '"table_metadata": {"bible_verses": {'
            '"source_id": "missing", "review_status": "draft"}}}',
            encoding="utf-8",
        )
        args.sources = invalid
        with self.assertRaisesRegex(ValueError, "Unknown source_id"):
            build(args)


if __name__ == "__main__":
    unittest.main()
