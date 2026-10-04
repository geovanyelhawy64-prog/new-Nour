import sqlite3

con = sqlite3.connect(r'D:/Nour/assets/databases/noor.db')
cur = con.cursor()
cur.execute("UPDATE bible_cross_references SET target_book_id=52, target_chapter=5, target_verse=8 WHERE id=1")
con.commit()
print(cur.execute("SELECT * FROM bible_cross_references WHERE id=1").fetchone())
