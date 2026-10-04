#!/usr/bin/env python3
"""Build a SQLite content DB from content_src JSON/CSV. --release keeps approved rows only."""
import argparse
import csv
import json
import os
import sqlite3
import sys

APPROVED = 'approved'

# Tables where authored/unknown content should be hidden from release
PRIVATE_TABLES = {
    'daily_verses',
    'emotion_prayers',
    'theology_articles',
    'coptic_dictionary',
    'occasional_prayers',
    'kids_stories',
    'monasteries',
}

# Tables with clergy-only content (role=priest AND is_secret=1)
CLERGY_ONLY_TABLES = {
    'liturgy_parts',
}

# P0 tables that get auto-stamped with canonical sources
P0_SOURCES = {
    'bible_books': ('src_bible_vandyke', 'approved'),
    'bible_verses': ('src_bible_vandyke', 'approved'),
    'agpeya_hours': ('src_agpeya_standard', 'approved'),
    'agpeya_sections': ('src_agpeya_standard', 'approved'),
}


def infer_tables(root):
    for entry in sorted(os.listdir(root)):
        p = os.path.join(root, entry, f'{entry}.json')
        if os.path.isfile(p):
            yield entry, p
    # Also check reference directory
    ref_dir = os.path.join(root, 'reference')
    if os.path.isdir(ref_dir):
        for entry in sorted(os.listdir(ref_dir)):
            p = os.path.join(ref_dir, entry)
            if os.path.isfile(p) and p.endswith('.json'):
                table = entry.replace('.json', '')
                yield table, p


def load_sources(root):
    """Load canonical sources from sources.csv."""
    sources_path = os.path.join(root, 'sources.csv')
    if not os.path.isfile(sources_path):
        return []
    with open(sources_path, encoding='utf-8') as f:
        reader = csv.DictReader(f)
        return list(reader)


def compute_visibility(table, row):
    """Compute visibility for a row based on table and content."""
    origin = row.get('origin', 'unknown')
    review_status = row.get('review_status', 'draft')

    # authored/unknown/or draft content is private by default in release
    if origin in ('authored', 'unknown') or review_status == 'draft':
        return 'private'

    # clergy-only for secret priest parts in liturgy
    if table in CLERGY_ONLY_TABLES:
        if row.get('role') == 'priest' and row.get('is_secret') == 1:
            return 'clergy_only'

    # private tables (authored content domains)
    if table in PRIVATE_TABLES:
        return 'private'

    return 'public'


def build(root, out_db, release):
    con = sqlite3.connect(out_db)
    cur = con.cursor()
    total = kept = 0

    # Load and create sources table
    sources = load_sources(root)
    if sources:
        cur.execute('DROP TABLE IF EXISTS "sources"')
        cols = list(sources[0].keys())
        col_defs = ', '.join(f'"{c}" TEXT' for c in cols)
        cur.execute(f'CREATE TABLE "sources" ({col_defs})')
        placeholders = ','.join('?' for _ in cols)
        col_names = ','.join(f'"{c}"' for c in cols)
        for s in sources:
            vals = [s.get(c) for c in cols]
            cur.execute(f'INSERT INTO "sources" ({col_names}) VALUES ({placeholders})', vals)
        print(f'sources: {len(sources)} rows')

    for table, path in infer_tables(root):
        with open(path, encoding='utf-8') as fh:
            data = json.load(fh)
            rows = data.get('rows', [])
        cols = []
        for r in rows:
            for k in r:
                if k not in cols:
                    cols.append(k)
        # Add visibility column if not present
        if 'visibility' not in cols:
            cols.append('visibility')
        if not cols:
            continue
        cur.execute(f'DROP TABLE IF EXISTS "{table}"')
        col_defs = ', '.join(f'"{c}" TEXT' for c in cols)
        cur.execute(f'CREATE TABLE "{table}" ({col_defs})')
        placeholders = ','.join('?' for _ in cols)
        col_names = ','.join(f'"{c}"' for c in cols)
        for r in rows:
            total += 1
            # Auto-stamp P0 tables with canonical source
            if table in P0_SOURCES:
                source_id, review_status = P0_SOURCES[table]
                r['source_id'] = source_id
                r['origin'] = 'printed'
                r['review_status'] = review_status
            vis = compute_visibility(table, r)
            if release:
                # Release build: only approved AND public content
                if r.get('review_status') != APPROVED:
                    continue
                if vis != 'public':
                    continue
            kept += 1
            vals = []
            for c in cols:
                v = r.get(c)
                if c == 'visibility':
                    v = vis
                if isinstance(v, (dict, list)):
                    v = json.dumps(v, ensure_ascii=False)
                vals.append(v)
            cur.execute(f'INSERT INTO "{table}" ({col_names}) VALUES ({placeholders})', vals)
        if 'content_id' in cols:
            cur.execute(f'CREATE INDEX IF NOT EXISTS "idx_{table}_content_id" ON "{table}" (content_id)')
        if 'visibility' in cols:
            cur.execute(f'CREATE INDEX IF NOT EXISTS "idx_{table}_visibility" ON "{table}" (visibility)')
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