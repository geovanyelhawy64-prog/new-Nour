import sqlite3
import os

db_path = os.path.join(os.path.dirname(__file__), '..', 'assets', 'databases', 'noor.db')
conn = sqlite3.connect(db_path)
c = conn.cursor()

c.execute('''
    CREATE TABLE IF NOT EXISTS bible_cross_references (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        source_book_id INTEGER NOT NULL,
        source_chapter INTEGER NOT NULL,
        source_verse INTEGER NOT NULL,
        target_book_id INTEGER NOT NULL,
        target_chapter INTEGER NOT NULL,
        target_verse INTEGER NOT NULL,
        relation_type TEXT DEFAULT 'related'
    )
''')

# المصدر: Treasury of Scripture Knowledge + مطابقة يدوية
# الصيغة: (source_book, source_ch, source_v, target_book, target_ch, target_v, relation_type)
# أرقام الأسفار حسب ترتيب noor.db (التكوين=1، الخروج=2، ... يوحنا=43، ...)
references = [
    # يو 3:16 ↔ آيات المحبة والخلاص
    (43, 3, 16, 45, 5, 8, "love"),      # رو 5:8
    (43, 3, 16, 62, 4, 9, "love"),      # 1 يو 4:9
    (43, 3, 16, 49, 2, 4, "mercy"),     # أف 2:4
    (43, 3, 16, 43, 15, 13, "love"),    # يو 15:13
    (43, 3, 16, 43, 1, 14, "word"),     # يو 1:14

    # تك 1:1 ↔ آيات الخلق
    (1, 1, 1, 43, 1, 1, "creation"),    # يو 1:1
    (1, 1, 1, 58, 1, 16, "creation"),   # كو 1:16
    (1, 1, 1, 19, 104, 24, "creation"), # مز 104:24
    (1, 1, 1, 54, 11, 3, "creation"),   # عب 11:3

    # مز 23:1 ↔ آيات الرعاية
    (19, 23, 1, 43, 10, 11, "shepherd"),  # يو 10:11
    (19, 23, 1, 60, 5, 4, "shepherd"),    # 1 بط 5:4
    (19, 23, 1, 26, 34, 11, "shepherd"),  # حز 34:11
    (19, 23, 1, 23, 100, 3, "shepherd"),  # إش 100:3 (مزمور)

    # مت 28:19 ↔ آيات المعمودية
    (40, 28, 19, 42, 16, 16, "baptism"),  # مر 16:16
    (40, 28, 19, 44, 2, 38, "baptism"),   # أع 2:38
    (40, 28, 19, 45, 6, 3, "baptism"),    # رو 6:3

    # رو 8:28 ↔ آيات العناية
    (45, 8, 28, 45, 8, 29, "providence"), # رو 8:29
    (45, 8, 28, 50, 1, 12, "providence"), # في 1:12
    (45, 8, 28, 1, 50, 20, "providence"), # تك 50:20

    # إش 53:5 ↔ آيات الفداء
    (23, 53, 5, 60, 2, 24, "redemption"),  # 1 بط 2:24
    (23, 53, 5, 45, 5, 6, "redemption"),   # رو 5:6
    (23, 53, 5, 49, 1, 7, "redemption"),   # أف 1:7

    # مز 51:1 ↔ آيات التوبة
    (19, 51, 1, 19, 51, 2, "repentance"),  # مز 51:2
    (19, 51, 1, 42, 1, 4, "repentance"),   # مر 1:4
    (19, 51, 1, 44, 3, 19, "repentance"),  # أع 3:19

    # 1 كو 13:4 ↔ آيات المحبة
    (46, 13, 4, 46, 13, 7, "love"),       # 1 كو 13:7
    (46, 13, 4, 43, 13, 34, "love"),      # يو 13:34
    (46, 13, 4, 62, 4, 8, "love"),        # 1 يو 4:8

    # أع 1:8 ↔ آيات الشهادة
    (44, 1, 8, 40, 28, 19, "witness"),    # مت 28:19
    (44, 1, 8, 44, 2, 32, "witness"),     # أع 2:32
    (44, 1, 8, 45, 10, 14, "witness"),    # رو 10:14
]

c.execute('DELETE FROM bible_cross_references')

for ref in references:
    c.execute('''
        INSERT INTO bible_cross_references
        (source_book_id, source_chapter, source_verse,
         target_book_id, target_chapter, target_verse, relation_type)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    ''', ref)

conn.commit()
c.execute('SELECT count(*) FROM bible_cross_references')
print(f'Successfully inserted {c.fetchone()[0]} cross references.')
conn.close()
