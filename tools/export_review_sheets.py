#!/usr/bin/env python3
"""Export review sheet CSVs from content_src table JSON files."""
import argparse
import csv
import json
import os
import sys

COLUMNS = ['content_id', 'origin', 'source_id', 'source_page',
           'review_status', 'critical', 'decision', 'notes', 'key_fields']

KEY_FIELD_CANDIDATES = ['text', 'text_ar', 'title', 'name_ar', 'short_text',
                        'full_text', 'reference', 'name_coptic', 'description']


def pick_key_fields(row) -> str:
    for name in KEY_FIELD_CANDIDATES:
        v = row.get(name)
        if isinstance(v, str) and v.strip():
            text = v.strip()
            return text[:119] + '…' if len(text) > 120 else text
    return ''


def export_table(json_path, out_dir):
    with open(json_path, encoding='utf-8') as fh:
        payload = json.load(fh)
    table = payload.get('table') or os.path.basename(os.path.dirname(json_path))
    rows = sorted(payload.get('rows', []), key=lambda r: str(r.get('content_id', '')))
    os.makedirs(out_dir, exist_ok=True)
    out_path = os.path.join(out_dir, f'{table}_review.csv')
    with open(out_path, 'w', encoding='utf-8-sig', newline='') as fh:
        w = csv.DictWriter(fh, fieldnames=COLUMNS, extrasaction='ignore')
        w.writeheader()
        for row in rows:
            w.writerow({
                'content_id': row.get('content_id', ''),
                'origin': row.get('origin', ''),
                'source_id': row.get('source_id', ''),
                'source_page': row.get('source_page', ''),
                'review_status': row.get('review_status', ''),
                'critical': row.get('critical', ''),
                'decision': '',
                'notes': '',
                'key_fields': pick_key_fields(row),
            })
    return table, len(rows)


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--root', default='content_src')
    p.add_argument('--out', default='review')
    args = p.parse_args()
    for subdir, _, files in sorted(os.walk(args.root)):
        for f in sorted(files):
            if not f.endswith('.json'):
                continue
            table, n = export_table(os.path.join(subdir, f), args.out)
            print(f'{table}: {n} rows')
    sys.exit(0)


if __name__ == '__main__':
    main()
