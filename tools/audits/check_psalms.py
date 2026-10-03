import sqlite3
import sys

sys.stdout.reconfigure(encoding='utf-8')

conn = sqlite3.connect('assets/databases/noor.db')
c = conn.cursor()

c.execute("PRAGMA table_info(bible_verses)")
print("bible_verses columns:", [r[1] for r in c.fetchall()])

# Check book 21 (Psalms)
c.execute("SELECT MAX(chapter), COUNT(*) FROM bible_verses WHERE book_id = 21")
print("Psalms (book 21) max chapter and total verses:", c.fetchall())

# Check Psalm 151 (book 21, chapter 151)
c.execute("SELECT book_id, chapter, verse_number, text FROM bible_verses WHERE book_id = 21 AND chapter = 151")
verses = c.fetchall()
print(f"Psalm 151 verses count: {len(verses)}")
for v in verses:
    print(f"  {v[2]}: {v[3]}")
