import sqlite3, sys
sys.stdout.reconfigure(encoding='utf-8')
conn = sqlite3.connect('assets/databases/noor.db')
c = conn.cursor()
c.execute("SELECT id, title, content FROM theology_articles")
for r in c.fetchall():
    greek_lines = [l for l in r[2].split('\n') if any(0x0370 <= ord(ch) <= 0x03CF for ch in l)]
    if greek_lines:
        print(f"Article ID: {r[0]} | Title: {r[1]}")
        for l in greek_lines:
            print("  ", l.strip()[:100])
