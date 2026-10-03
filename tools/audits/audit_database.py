import sqlite3

conn = sqlite3.connect('assets/databases/noor.db')
c = conn.cursor()
c.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name")
tables = [r[0] for r in c.fetchall() if not r[0].startswith('sqlite_')]

print("=== NOOR DATABASE AUDIT REPORT ===")
total_rows = 0
for t in tables:
    c.execute(f"SELECT COUNT(*) FROM {t}")
    cnt = c.fetchone()[0]
    total_rows += cnt
    print(f"- {t}: {cnt} rows")

print(f"Total Tables: {len(tables)}, Total Rows: {total_rows}")

# Bible audit
c.execute("SELECT COUNT(*) FROM bible_books")
print("Bible books count:", c.fetchone()[0])
c.execute("SELECT testament, COUNT(*) FROM bible_books GROUP BY testament")
print("Bible testaments:", c.fetchall())
c.execute("SELECT COUNT(*) FROM bible_verses")
print("Bible verses count:", c.fetchone()[0])
c.execute("SELECT COUNT(*) FROM bible_verses WHERE book_id = 19 AND chapter = 151")
print("Psalm 151 verses count:", c.fetchone()[0])

# Coptic text character check
print("\n=== COPTIC UNICODE AUDIT ===")
c.execute("SELECT coptic FROM hymn_segments WHERE coptic IS NOT NULL AND coptic != ''")
hymn_coptics = c.fetchall()
non_coptic_chars = set()
for (txt,) in hymn_coptics:
    for ch in txt:
        code = ord(ch)
        # Check if in standard Coptic range U+2C80..U+2CFF or combining marks or punctuation/whitespace
        if (0x2C80 <= code <= 0x2CFF) or code in [0x0300, 0x0301, 0x0307, 0x0308, 0x2CFD, 0x2CFE, 0x2CFF, 0x0020, 0x000A, 0x003A, 0x002E, 0x002C, 0x002D, 0x0028, 0x0029, 0x00BB, 0x00AB]:
            continue
        elif 0x0600 <= code <= 0x06FF: # Arabic
            continue
        else:
            non_coptic_chars.add((ch, hex(code)))

print("Non-coptic chars in hymn_segments coptic:", non_coptic_chars)
