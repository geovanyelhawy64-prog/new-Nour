#!/usr/bin/env python3
"""
Restructure hymn_books into the 4 official canonical parts according to
Moallim Osama Lotfy's encyclopedia reference, remap all 63 hymns into these
4 books, and build SQLite performance indexes across the entire database.
"""
import sqlite3
import os
import sys

if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

DB_PATH = os.path.join(os.path.dirname(__file__), '..', 'assets', 'databases', 'noor.db')

BOOKS = [
    ('osama_lotfy_01', 'الجزء الأول: ألحان رفع بخور عشية وباكر', 1),
    ('osama_lotfy_02', 'الجزء الثاني: ألحان القداس الإلهي الباسيلي', 2),
    ('osama_lotfy_03', 'الجزء الثالث: ألحان المناسبات والأعياد السيدية', 3),
    ('osama_lotfy_04', 'الجزء الرابع: ألحان الصوم الكبير وأسبوع الآلام', 4),
]

INDEXES = [
    ("idx_bible_verses_lookup", "CREATE INDEX IF NOT EXISTS idx_bible_verses_lookup ON bible_verses (book_id, chapter, verse_number)"),
    ("idx_bible_verses_book_chap", "CREATE INDEX IF NOT EXISTS idx_bible_verses_book_chap ON bible_verses (book_id, chapter)"),
    ("idx_katameros_date", "CREATE INDEX IF NOT EXISTS idx_katameros_date ON katameros_readings (coptic_month, coptic_day)"),
    ("idx_synaxarium_date", "CREATE INDEX IF NOT EXISTS idx_synaxarium_date ON synaxarium_entries (coptic_month, coptic_day)"),
    ("idx_difnar_date", "CREATE INDEX IF NOT EXISTS idx_difnar_date ON difnar_entries (coptic_month, coptic_day)"),
    ("idx_agpeya_sections", "CREATE INDEX IF NOT EXISTS idx_agpeya_sections ON agpeya_sections (hour_id, section_order)"),
    ("idx_liturgy_parts", "CREATE INDEX IF NOT EXISTS idx_liturgy_parts ON liturgy_parts (section_id, part_order)"),
    ("idx_hymns_book", "CREATE INDEX IF NOT EXISTS idx_hymns_book ON hymns (book_id, hymn_order)"),
    ("idx_hymn_segments", "CREATE INDEX IF NOT EXISTS idx_hymn_segments ON hymn_segments (hymn_id, segment_order)"),
    ("idx_pascha_readings", "CREATE INDEX IF NOT EXISTS idx_pascha_readings ON pascha_readings (day_id, hour_number, reading_order)"),
    ("idx_psali_sections", "CREATE INDEX IF NOT EXISTS idx_psali_sections ON psali_sections (psali_id, section_order)"),
    ("idx_rite_sections", "CREATE INDEX IF NOT EXISTS idx_rite_sections ON rite_sections (rite_id, sort_order)"),
    ("idx_holy_places_type", "CREATE INDEX IF NOT EXISTS idx_holy_places_type ON holy_places (type)"),
    ("idx_holy_places_gov", "CREATE INDEX IF NOT EXISTS idx_holy_places_gov ON holy_places (governorate)"),
    ("idx_emotion_prayers_cat", "CREATE INDEX IF NOT EXISTS idx_emotion_prayers_cat ON emotion_prayers (category)"),
]

def main():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    print("--- 1. Restructuring hymn_books table into 4 books ---")
    c.execute("SELECT id, name_ar, book_id FROM hymns")
    existing_hymns = c.fetchall()
    print(f"Current hymns count: {len(existing_hymns)}")

    # Clear old hymn_books and insert 4 books
    c.execute("DELETE FROM hymn_books")
    c.executemany("INSERT INTO hymn_books (id, name_ar, book_order) VALUES (?, ?, ?)", BOOKS)

    # Remap hymns into the 4 official volumes
    for hymn_id, name_ar, old_book_id in existing_hymns:
        if old_book_id in ['osama_lotfy_01', '1']:
            new_book_id = 'osama_lotfy_01'
        elif old_book_id in ['osama_lotfy_02', '2']:
            new_book_id = 'osama_lotfy_02'
        elif old_book_id in ['osama_lotfy_03', 'osama_lotfy_04', 'osama_lotfy_09', 'osama_lotfy_10', 'osama_lotfy_11', '3']:
            new_book_id = 'osama_lotfy_03'
        else:
            new_book_id = 'osama_lotfy_04'

        c.execute("UPDATE hymns SET book_id = ? WHERE id = ?", (new_book_id, hymn_id))

    c.execute("SELECT book_id, COUNT(*) FROM hymns GROUP BY book_id ORDER BY book_id")
    for b_id, count in c.fetchall():
        print(f"  Book {b_id}: {count} hymns")

    print("\n--- 2. Creating Database Performance Indexes ---")
    for idx_name, sql in INDEXES:
        c.execute(sql)
        print(f"  ✅ Index created: {idx_name}")

    conn.commit()

    # Verification
    c.execute("SELECT COUNT(*) FROM hymn_books")
    books_count = c.fetchone()[0]
    c.execute("SELECT COUNT(*) FROM hymns")
    hymns_count = c.fetchone()[0]
    c.execute("SELECT COUNT(*) FROM sqlite_master WHERE type='index'")
    indexes_count = c.fetchone()[0]

    print("\n--- Summary Verification ---")
    print(f"Hymn books: {books_count} (Expected: 4)")
    print(f"Total hymns: {hymns_count} (Expected: 63)")
    print(f"Total SQLite indexes: {indexes_count}")

    conn.close()
    print("\n🎉 Optimization complete: 4 hymn books & 15 indexes successfully saved in noor.db!")

if __name__ == '__main__':
    main()
