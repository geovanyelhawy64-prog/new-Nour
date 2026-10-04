import sqlite3

con = sqlite3.connect(r'D:/Nour/assets/databases/noor.db')
cur = con.cursor()
rows = cur.execute('SELECT id,source_book_id,source_chapter,source_verse,target_book_id,target_chapter,target_verse FROM bible_cross_references').fetchall()
bad = []
for r in rows:
    src = cur.execute('SELECT 1 FROM bible_verses WHERE book_id=? AND chapter=? AND verse_number=?', (r[1], r[2], r[3])).fetchone()
    tgt = cur.execute('SELECT 1 FROM bible_verses WHERE book_id=? AND chapter=? AND verse_number=?', (r[4], r[5], r[6])).fetchone()
    if not src or not tgt:
        bad.append(r)
print(len(bad), bad[:5])
