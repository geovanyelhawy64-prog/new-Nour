import sqlite3

conn = sqlite3.connect('assets/databases/noor.db')
c = conn.cursor()

c.execute("SELECT id, text_coptic FROM difnar_entries WHERE text_coptic LIKE '%&nbsp;%'")
rows = c.fetchall()
print(f"Found {len(rows)} rows with &nbsp; in difnar_entries")

for rid, txt in rows:
    cleaned = txt.replace('&nbsp;', ' ')
    c.execute("UPDATE difnar_entries SET text_coptic = ? WHERE id = ?", (cleaned, rid))

conn.commit()
print("Cleaned &nbsp; in difnar_entries!")
conn.close()
