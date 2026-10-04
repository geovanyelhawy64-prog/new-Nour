import sqlite3
import json
import sys
import io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

db_path = "assets/databases/noor.db"
conn = sqlite3.connect(db_path)
cur = conn.cursor()

print("==================================================")
print("             DEEP GROUND-TRUTH AUDIT              ")
print("==================================================")

# 1. Today Screen Queries
# Month 1 (Tout), Day 20/21
print("\n--- 1. TODAY SCREEN DATA CHECK ---")
cur.execute("SELECT count(*) FROM katameros_readings WHERE coptic_month = 1 AND coptic_day = 20;")
k_count = cur.fetchone()[0]
print(f"Katameros readings for Tout 20: {k_count}")

cur.execute("SELECT count(*) FROM synaxarium_entries WHERE coptic_month = 1 AND coptic_day = 20;")
s_count = cur.fetchone()[0]
print(f"Synaxarium entries for Tout 20: {s_count}")

cur.execute("SELECT reference, text FROM daily_verses WHERE day_of_year = 274;")
d_verse = cur.fetchone()
print(f"Daily verse for day 274: {d_verse}")

# 2. Bible Search Query
print("\n--- 2. BIBLE SEARCH CHECK ---")
cur.execute("SELECT count(*) FROM bible_verses WHERE text LIKE '%الله%';")
v_count = cur.fetchone()[0]
print(f"Verses containing 'الله': {v_count:,}")

cur.execute("SELECT count(*) FROM bible_verses WHERE text_with_tashkeel IS NOT NULL;")
tashkeel_count = cur.fetchone()[0]
print(f"Verses with tashkeel: {tashkeel_count:,} / 35,761")

# Check Deuterocanonical Books
cur.execute("SELECT id, name_ar, chapter_count FROM bible_books WHERE category = 'deuterocanonical' OR id IN ('tobit','judith','wisdom','sirach','baruch','1maccabees','2maccabees');")
deut_books = cur.fetchall()
print(f"Deuterocanonical books found: {len(deut_books)}")
for b in deut_books:
    cur.execute(f"SELECT count(*) FROM bible_verses WHERE book_id = '{b[0]}';")
    vc = cur.fetchone()[0]
    print(f"   - {b[0]}: {b[1]} ({b[2]} chapters, {vc} verses in DB)")

# Check Psalm 151
cur.execute("SELECT count(*) FROM bible_verses WHERE book_id = 'psalms' AND chapter = 151;")
ps151 = cur.fetchone()[0]
print(f"Psalm 151 verses: {ps151}")

# 3. Agpeya Completeness Check
print("\n--- 3. AGPEYA CHECK ---")
cur.execute("SELECT id, name_ar FROM agpeya_hours ORDER BY hour_order;")
hours = cur.fetchall()
for h in hours:
    cur.execute(f"SELECT count(*), count(CASE WHEN type='psalm' THEN 1 END) FROM agpeya_sections WHERE hour_id = '{h[0]}';")
    total_sec, psalm_sec = cur.fetchone()
    print(f"   Hour {h[0]} ({h[1]}): {total_sec} sections ({psalm_sec} psalms)")

# 4. Liturgy Completeness Check
print("\n--- 4. LITURGIES CHECK ---")
cur.execute("SELECT id, name_ar FROM liturgies ORDER BY liturgy_order;")
lits = cur.fetchall()
for lit in lits:
    cur.execute(f"SELECT count(*) FROM liturgy_sections WHERE liturgy_id = '{lit[0]}';")
    sec_c = cur.fetchone()[0]
    cur.execute(f"SELECT count(*) FROM liturgy_parts p JOIN liturgy_sections s ON p.section_id = s.id WHERE s.liturgy_id = '{lit[0]}';")
    parts_c = cur.fetchone()[0]
    print(f"   Liturgy {lit[0]} ({lit[1]}): {sec_c} sections, {parts_c} parts")

# 5. Hymns and Segments Check
print("\n--- 5. HYMNS & HAZAT (SYLLABLES) CHECK ---")
cur.execute("SELECT count(*) FROM hymns;")
total_hymns = cur.fetchone()[0]
cur.execute("SELECT count(*) FROM hymn_segments;")
total_segs = cur.fetchone()[0]
cur.execute("SELECT count(*) FROM hymn_segments WHERE syllables_json IS NOT NULL AND syllables_json != '' AND syllables_json != '[]';")
syllable_segs = cur.fetchone()[0]
print(f"Total hymns: {total_hymns}")
print(f"Total hymn segments: {total_segs}")
print(f"Segments with interactive Hazat (syllables_json): {syllable_segs}")

# 6. Katameros Completeness Check
print("\n--- 6. KATAMEROS CHECK ---")
cur.execute("SELECT DISTINCT period_type, count(*) FROM katameros_readings GROUP BY period_type;")
for pt in cur.fetchall():
    print(f"   Period {pt[0]}: {pt[1]} readings")

# 7. Pascha Completeness Check
print("\n--- 7. PASCHA CHECK ---")
cur.execute("SELECT count(DISTINCT day_id), count(*) FROM pascha_readings;")
p_days, p_readings = cur.fetchone()
print(f"Pascha days: {p_days}, readings: {p_readings}")

# 8. Synaxarium Completeness Check
print("\n--- 8. SYNAXARIUM CHECK ---")
cur.execute("SELECT count(*) FROM synaxarium_entries;")
print(f"Total Synaxarium entries: {cur.fetchone()[0]}")
cur.execute("SELECT count(*) FROM synaxarium_entries WHERE text_ar IS NULL OR length(text_ar) < 20;")
empty_syn = cur.fetchone()[0]
print(f"Empty or tiny synaxarium entries: {empty_syn}")

conn.close()
