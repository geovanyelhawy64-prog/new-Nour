#!/usr/bin/env python3
"""Read-only export of content DB into structured JSON per section."""
import argparse
import json
import os
import sqlite3
import unicodedata

SKIP_TABLES = {'bookmarks', 'verse_highlights', 'sqlite_sequence', 'sqlite_stat1'}

# Legacy Arabic name spellings have been preserved in the source; this map
# can be enriched later with editorial corrections.
SECTION_IDS = {
    'bible_books': lambda r: f"bible:book:{r['id']}",
    'bible_verses': lambda r: f"bible:book{r['book_id']}:{r['chapter']}:{r['verse_number']}",
    'agpeya_hours': lambda r: f"agpeya:hour:{r['id']}",
    'agpeya_sections': lambda r: f"agpeya:section:{r['id']}",
    'hymn_books': lambda r: f"hymns:book:{r['id']}",
    'hymns': lambda r: f"hymns:hymn:{r['id']}",
    'hymn_segments': lambda r: f"hymns:segment:{r['id']}",
    'liturgies': lambda r: f"liturgy:{r['id']}",
    'liturgy_sections': lambda r: f"liturgy:section:{r['id']}",
    'liturgy_parts': lambda r: f"liturgy:part:{r['id']}",
    'synaxarium_entries': lambda r: f"synaxarium:{r['id']}",
    'katameros_readings': lambda r: f"katameros:{r['id']}",
    'difnar_entries': lambda r: f"difnar:{r['id']}",
    'pascha_readings': lambda r: f"pascha:{r['id']}",
    'feasts_and_fasts': lambda r: f"feasts:{r['id']}",
    'occasional_prayers': lambda r: f"prayers:{r['id']}",
    'theology_articles': lambda r: f"theology:{r['id']}",
    'daily_verses': lambda r: f"daily_verse:{r['id']}",
    'sacraments': lambda r: f"sacrament:{r['id']}",
    'sacrament_sections': lambda r: f"sacrament:section:{r['id']}",
    'monasteries': lambda r: f"monastery:{r['id']}",
    'bible_commentaries': lambda r: f"commentary:{r['id']}",
    'coptic_dictionary': lambda r: f"dictionary:{r['id']}",
    'bible_cross_references': lambda r: f"xref:{r['id']}",
    'psalis': lambda r: f"psali:{r['id']}",
    'psali_sections': lambda r: f"psali:section:{r['id']}",
    'rites': lambda r: f"rite:{r['id']}",
    'rite_sections': lambda r: f"rite:section:{r['id']}",
    'holy_places': lambda r: f"holy_place:{r['id']}",
    'emotion_prayers': lambda r: f"emotion:{r['id']}",
}


def normalize_row(row):
    return {k: (unicodedata.normalize('NFC', v) if isinstance(v, str) else v) for k, v in row.items()}


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--db', default='assets/databases/noor.db')
    p.add_argument('--out', default='content_src')
    args = p.parse_args()

    os.makedirs(args.out, exist_ok=True)
    # open read-only by uri
    uri = f'file:{os.path.abspath(args.db)}?mode=ro'
    con = sqlite3.connect(uri, uri=True)
    con.row_factory = sqlite3.Row
    cur = con.cursor()
    tables = [r[0] for r in cur.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name").fetchall()]
    skipped = set()
    for t in tables:
        if t in SKIP_TABLES:
            skipped.add(t)
            continue
        rows = []
        for row in cur.execute(f'SELECT * FROM {t}'):
            d = normalize_row(dict(row))
            d['content_id'] = SECTION_IDS.get(t, lambda r: f'{t}:{r.get("id")}')(d)
            rows.append(d)
        out_dir = os.path.join(args.out, t)
        os.makedirs(out_dir, exist_ok=True)
        out_path = os.path.join(out_dir, f'{t}.json')
        with open(out_path, 'w', encoding='utf-8', newline='') as f:
            json.dump({'table': t, 'rows': rows}, f, ensure_ascii=False, indent=2)
        print(f'exported {len(rows)} rows -> {out_path}')
    print('skipped:', ', '.join(sorted(skipped)))


if __name__ == '__main__':
    main()
