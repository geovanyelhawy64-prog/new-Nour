#!/usr/bin/env python3
"""Build a SQLite content DB from content_src JSON. --release keeps approved rows only."""
import argparse
import json
import os
import sqlite3
import sys

APPROVED = 'approved'


def infer_tables(root):
    for entry in sorted(os.listdir(root)):
        p = os.path.join(root, entry, f'{entry}.json')
        if os.path.isfile(p):
            yield entry, p


def build(root, out_db, release):
    con = sqlite3.connect(out_db)
    cur = con.cursor()
    total = kept = 0
    for table, path in infer_tables(root):
        with open(path, encoding='utf-8') as fh:
            rows = json.load(fh).get('rows', [])
        cols = []
        for r in rows:
            for k in r:
                if k not in cols:
                    cols.append(k)
        if not cols:
            continue
        cur.execute(f'DROP TABLE IF EXISTS "{table}"')
        col_defs = ', '.join(f'"{c}" TEXT' for c in cols)
        cur.execute(f'CREATE TABLE "{table}" ({col_defs})')
        placeholders = ','.join('?' for _ in cols)
        col_names = ','.join(f'"{c}"' for c in cols)
        for r in rows:
            total += 1
            if release and r.get('review_status') != APPROVED:
                continue
            kept += 1
            vals = []
            for c in cols:
                v = r.get(c)
                if isinstance(v, (dict, list)):
                    v = json.dumps(v, ensure_ascii=False)
                vals.append(v)
            cur.execute(f'INSERT INTO "{table}" ({col_names}) VALUES ({placeholders})', vals)
        if 'content_id' in cols:
            cur.execute(f'CREATE INDEX IF NOT EXISTS "idx_{table}_content_id" ON "{table}" (content_id)')
    con.commit()
    con.execute('ANALYZE')
    con.close()
    return total, kept


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--root', default='content_src')
    p.add_argument('--dev', dest='dev', action='store_true')
    p.add_argument('--release', dest='release', action='store_true')
    p.add_argument('--out', default='assets/databases')
    args = p.parse_args()
    if args.dev == args.release:
        print('specify exactly one of --dev or --release', file=sys.stderr)
        sys.exit(2)
    os.makedirs(args.out, exist_ok=True)
    out = os.path.join(args.out, 'content_release.db' if args.release else 'content_dev.db')
    tmp = out + '.tmp'
    if os.path.exists(tmp):
        os.remove(tmp)
    total, kept = build(args.root, tmp, args.release)
    os.replace(tmp, out)
    print(f'{out}: {kept}/{total} rows ({"release" if args.release else "dev"})')


if __name__ == '__main__':
    main()
