import csv
import sqlite3
import tempfile
import unittest
from pathlib import Path

from tools.content_audit import audit


class ContentAuditTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        self.database = self.root / "content.db"
        db = sqlite3.connect(self.database)
        db.executescript(
            """
            CREATE TABLE bible_books (
              id INTEGER PRIMARY KEY, name_ar TEXT, book_order INTEGER
            );
            CREATE TABLE bible_verses (
              id INTEGER PRIMARY KEY, book_id INTEGER, chapter INTEGER,
              verse_number INTEGER, text TEXT
            );
            CREATE TABLE bible_cross_references (
              id INTEGER PRIMARY KEY, source_book_id INTEGER, source_chapter INTEGER,
              source_verse INTEGER, target_book_id INTEGER, target_chapter INTEGER,
              target_verse INTEGER
            );
            CREATE TABLE hymns (
              id TEXT PRIMARY KEY, name_ar TEXT, book_id TEXT, hymn_order INTEGER
            );
            CREATE TABLE hymn_segments (id INTEGER PRIMARY KEY, hymn_id TEXT);
            INSERT INTO bible_books VALUES (1, 'التكوين', 1);
            INSERT INTO bible_verses VALUES (1, 1, 1, 1, 'أمين');
            INSERT INTO bible_verses VALUES (2, 1, 1, 3, 'نص سليم');
            INSERT INTO bible_cross_references VALUES (1, 1, 1, 1, 1, 1, 2);
            INSERT INTO hymns VALUES ('h1', 'لحن بلا أرباع', 'book', 1);
            """
        )
        db.commit()
        db.close()

    def tearDown(self):
        self.temp.cleanup()

    def test_generates_reviewer_sheets_without_modifying_content(self):
        before = self.database.read_bytes()
        output = self.root / "review"
        summary = audit(self.database, output)

        self.assertEqual(before, self.database.read_bytes())
        self.assertEqual(summary["verse_numbering_anomalies"], 1)
        self.assertEqual(summary["non_nfc_verse_texts"], 1)
        self.assertEqual(summary["missing_cross_references"], 1)
        self.assertEqual(summary["hymns_without_segments"], 1)
        self.assertTrue((output / "chapter_verse_counts.csv").exists())

    def test_compares_counts_only_when_reference_is_supplied(self):
        reference = self.root / "reference.csv"
        with reference.open("w", encoding="utf-8", newline="") as stream:
            writer = csv.writer(stream)
            writer.writerow(["book_id", "book_name", "chapter", "expected_count"])
            writer.writerow([1, "التكوين", 1, 3])
        summary = audit(self.database, self.root / "review", reference)
        self.assertEqual(summary["reference_count_mismatches"], 1)
        self.assertTrue(summary["reference_counts_supplied"])


if __name__ == "__main__":
    unittest.main()
