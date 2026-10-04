#!/usr/bin/env python3
"""Apply Van Dyck (arb-vd) text to noor.db bible_verses and content_src."""
import argparse
import json
import os
import re
import sqlite3
import sys
import unicodedata


def strip_marks(s):
    return ''.join(ch for ch in unicodedata.normalize('NFC', s)
                   if unicodedata.category(ch) != 'Mn').strip()


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--db', default='assets/databases/noor.db')
    p.add_argument('--staging', default='staging/bible_verses/bible_verses.jsonl')
    p.add_argument('--apply', action='store_true')
    args = p.parse_args()

    staged = {}
    with open(args.staging, encoding='utf-8') as fh:
        for line in fh:
            r = json.loads(line)
            staged[r['content_id']] = r['text']

    con = sqlite3.connect(args.db)
    cur = con.cursor()
    cols = [r[1] for r in cur.execute('PRAGMA table_info(bible_verses)').fetchall()]
    has_tashkeel = 'text_with_tashkeel' in cols
    rows = cur.execute('SELECT id, book_id, chapter, verse_number FROM bible_verses').fetchall()
    updated = skipped = 0
    for rid, book_id, chapter, verse in rows:
        cid = f'bible:book{book_id}:{chapter}:{verse}'
        full = staged.get(cid)
        if full is None:
            skipped += 1
            continue
        plain = strip_marks(full)
        if has_tashkeel:
            cur.execute('UPDATE bible_verses SET text=?, text_with_tashkeel=? WHERE id=?',
                        (plain, full, rid))
        else:
            cur.execute('UPDATE bible_verses SET text=? WHERE id=?', (plain, rid))
        updated += 1
    if args.apply:
        con.commit()
        print(f'updated {updated}, skipped {skipped}')
    else:
        con.rollback()
        print(f'dry-run: would update {updated}, skip {skipped}')
    con.close()


if __name__ == '__main__':
    main()
