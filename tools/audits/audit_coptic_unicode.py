import sqlite3
import sys

sys.stdout.reconfigure(encoding='utf-8')

conn = sqlite3.connect('assets/databases/noor.db')
c = conn.cursor()

# Search across all tables and columns for characters in range 0x0370..0x03FF (Greek and old Coptic block)
c.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name")
tables = [r[0] for r in c.fetchall() if not r[0].startswith('sqlite_')]

print("=== DEEP COPTIC UNICODE AUDIT ACROSS ALL TABLES ===")

coptic_legacy_counts = {}

for table in tables:
    c.execute(f"PRAGMA table_info({table})")
    cols = [r[1] for r in c.fetchall() if 'text' in r[2].lower() or 'varchar' in r[2].lower() or 'char' in r[2].lower()]
    for col in cols:
        try:
            c.execute(f"SELECT rowid, {col} FROM {table} WHERE {col} IS NOT NULL AND {col} != ''")
            for rowid, val in c.fetchall():
                legacy_chars = []
                for ch in str(val):
                    code = ord(ch)
                    # Check Greek/Coptic block (0x0370..0x03FF) where old Coptic letters reside (0x03E2..0x03EF)
                    if 0x0370 <= code <= 0x03FF:
                        legacy_chars.append((ch, hex(code)))
                if legacy_chars:
                    key = f"{table}.{col}"
                    if key not in coptic_legacy_counts:
                        coptic_legacy_counts[key] = []
                    coptic_legacy_counts[key].append((rowid, legacy_chars))
        except Exception as e:
            pass

print(f"Tables/Columns with Greek/Legacy Coptic characters (U+0370..U+03FF): {len(coptic_legacy_counts)}")
for key, occurrences in coptic_legacy_counts.items():
    print(f"\n--- {key} ({len(occurrences)} occurrences) ---")
    sample_chars = set()
    for rowid, chars in occurrences[:10]:
        for ch, hx in chars:
            sample_chars.add((ch, hx))
    print(f"Sample characters: {sample_chars}")
    print(f"Sample rowid: {occurrences[0][0]}")
