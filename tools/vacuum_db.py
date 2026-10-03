import sqlite3
import os

db_path = os.path.join(os.path.dirname(__file__), '..', 'assets', 'databases', 'noor.db')
conn = sqlite3.connect(db_path)
c = conn.cursor()
c.execute('PRAGMA vacuum;')
c.execute('PRAGMA optimize;')
conn.close()

size_mb = os.path.getsize(db_path) / (1024 * 1024)
print(f'Database optimized and vacuumed. Size: {size_mb:.2f} MB')

conn = sqlite3.connect(db_path)
c = conn.cursor()
c.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;")
tables = [r[0] for r in c.fetchall() if not r[0].startswith('sqlite_')]
for t in tables:
    c.execute(f"SELECT COUNT(*) FROM {t}")
    cnt = c.fetchone()[0]
    print(f"  Table {t}: {cnt} rows")
conn.close()
