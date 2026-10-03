import sqlite3, sys
sys.stdout.reconfigure(encoding='utf-8')
conn = sqlite3.connect('assets/databases/noor.db')
c = conn.cursor()

tables_cols = [
    ('hymn_segments', 'coptic'),
    ('liturgy_parts', 'text_coptic'),
    ('agpeya_sections', 'text_coptic'),
    ('pascha_readings', 'text'),
    ('difnar_entries', 'text_coptic'),
    ('bible_books', 'name_coptic'),
    ('hymns', 'name_coptic'),
]

print("=== CHECKING FOR GREEK/LATIN REPLACING COPTIC ===")
greek_replacements = {}
for table, col in tables_cols:
    c.execute(f"SELECT rowid, {col} FROM {table} WHERE {col} IS NOT NULL AND {col} != ''")
    for rowid, val in c.fetchall():
        found = []
        for ch in val:
            code = ord(ch)
            # Greek letters: 0x0370 to 0x03E1 (excluding Demotic 0x03E2-0x03EF)
            if 0x0370 <= code <= 0x03E1:
                found.append((ch, hex(code)))
            # Latin letters: 'a'..'z', 'A'..'Z' inside coptic text
            elif (0x0041 <= code <= 0x005A) or (0x0061 <= code <= 0x007A):
                # only count if surrounding text is Coptic
                found.append((ch, hex(code)))
        if found:
            key = f"{table}.{col}"
            if key not in greek_replacements:
                greek_replacements[key] = []
            greek_replacements[key].append((rowid, found))

print(f"Columns with potential Greek/Latin substitutions: {len(greek_replacements)}")
for k, v in greek_replacements.items():
    print(f"\n{k}: {len(v)} rows")
    chars = set()
    for rowid, items in v:
        for ch, code in items:
            chars.add((ch, code))
    print(f"  Chars found: {chars}")
    # show first sample row
    c.execute(f"SELECT rowid, {k.split('.')[1]} FROM {k.split('.')[0]} WHERE rowid = {v[0][0]}")
    sample = c.fetchone()
    print(f"  Sample row {sample[0]}: {str(sample[1])[:100]}")
