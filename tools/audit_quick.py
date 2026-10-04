import sqlite3, json, unicodedata
con = sqlite3.connect(r'D:\Nour\assets\databases\noor.db')
con.row_factory = sqlite3.Row
cur = con.cursor()

def Q(sql, params=()):
    return [dict(r) for r in cur.execute(sql, params).fetchall()]

out = {}
out['tables'] = [r[0] for r in cur.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name").fetchall()]
out['bible_book_count'] = cur.execute('SELECT COUNT(*) FROM bible_books').fetchone()[0]
out['bible_verse_count'] = cur.execute('SELECT COUNT(*) FROM bible_verses').fetchone()[0]
# candidate books
for name in ['لي�?اويين','عزرا','المزامير','سيراخ','باروخ','Leviticus','Ezra','Psalms','Sirach','Baruch']:
    rows = Q('SELECT id,name_ar,name_en,testament FROM bible_books WHERE name_ar LIKE ? OR name_en LIKE ?', (f'%{name}%', f'%{name}%'))
    if rows:
        out['bookmatch_'+name] = rows
# verse counts per book for relevant ids
ids = [r['id'] for r in Q("SELECT id FROM bible_books WHERE name_ar LIKE '%اويين%' OR name_ar LIKE '%عزرا%' OR name_ar LIKE '%زامير%' OR name_ar LIKE '%سيراخ%' OR name_ar LIKE '%باروخ%'")]
for i in ids:
    cnt = cur.execute('SELECT COUNT(*) FROM bible_verses WHERE book_id=?', (i,)).fetchone()[0]
    out[f'verses_in_book_{i}'] = cnt
    chapters = Q('SELECT DISTINCT chapter FROM bible_verses WHERE book_id=? ORDER BY chapter', (i,))
    out[f'chapters_in_book_{i}'] = [c['chapter'] for c in chapters]
print(json.dumps(out, ensure_ascii=False, indent=2))
