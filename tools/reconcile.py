#!/usr/bin/env python3
"""Compare staging exports against canonical content_src and emit diff/gap reports."""
import argparse
import csv
import difflib
import json
import os
import re
import sys
import unicodedata

def norm_text(s):
    s = unicodedata.normalize('NFC', s)
    s = ''.join(ch for ch in s if unicodedata.category(ch) != 'Mn')
    s = re.sub(r'\s+', ' ', s).strip()
    return s

SKIP = {'content_id', 'origin', 'source_id', 'source_page', 'review_status',
        'verified_by', 'verified_at', 'critical', 'content_version'}


def load_rows(path):
    if path.endswith('.jsonl'):
        rows = []
        with open(path, encoding='utf-8') as fh:
            for line in fh:
                line = line.strip()
                if line:
                    rows.append(json.loads(line))
        return rows
    with open(path, encoding='utf-8') as fh:
        payload = json.load(fh)
    if isinstance(payload, dict) and 'rows' in payload:
        return payload['rows']
    if isinstance(payload, list):
        return payload
    return []


def canon(row):
    return json.dumps({k: (norm_text(v) if isinstance(v, str) else v)
                       for k, v in sorted(row.items()) if k not in SKIP},
                      ensure_ascii=False, sort_keys=True)


def text_fields(row):
    return ' | '.join(norm_text(str(v)) for k, v in sorted(row.items())
                      if isinstance(v, str) and v.strip())


def reconcile_section(section, staging_path, src_path, out_dir):
    staged = {r.get('content_id'): r for r in load_rows(staging_path)}
    src = {r.get('content_id'): r for r in load_rows(src_path)}
    matched, diffs, extra, missing = 0, [], [], []
    for cid, srow in staged.items():
        crow = src.get(cid)
        if crow is None:
            extra.append(cid)
            continue
        s_txt = srow.get('text') or srow.get('text_ar') or text_fields(srow)
        c_txt = crow.get('text') or crow.get('text_ar') or text_fields(crow)
        if norm_text(str(s_txt)) == norm_text(str(c_txt)):
            matched += 1
        else:
            sim = difflib.SequenceMatcher(None, norm_text(str(c_txt)), norm_text(str(s_txt))).ratio()
            diffs.append((cid, round(sim, 3), text_fields(crow)[:200], text_fields(srow)[:200]))
    for cid in src:
        if cid not in staged:
            missing.append(cid)
    os.makedirs(out_dir, exist_ok=True)
    with open(os.path.join(out_dir, f'{section}_diffs.csv'), 'w', encoding='utf-8-sig', newline='') as f:
        w = csv.writer(f)
        w.writerow(['content_id', 'similarity', 'current', 'staged'])
        for d in sorted(diffs, key=lambda x: x[1]):
            w.writerow(d)
    with open(os.path.join(out_dir, f'{section}_gaps.csv'), 'w', encoding='utf-8-sig', newline='') as f:
        w = csv.writer(f)
        w.writerow(['content_id', 'kind'])
        for cid in sorted(extra):
            w.writerow([cid, 'extra_in_staging'])
        for cid in sorted(missing):
            w.writerow([cid, 'missing_in_staging'])
    return matched, len(diffs), len(extra), len(missing)


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--staging', default='staging')
    p.add_argument('--root', default='content_src')
    p.add_argument('--out', default='review')
    p.add_argument('--section', help='single section; default all found in staging')
    p.add_argument('--all', action='store_true', help='reconcile all sections (default)')
    args = p.parse_args()

    if not os.path.isdir(args.staging):
        print(f'no staging dir ({args.staging}); nothing to reconcile yet')
        return
    sections = [args.section] if args.section else sorted(os.listdir(args.staging))
    found = False
    for section in sections:
        cands = [os.path.join(args.staging, section, f'{section}.jsonl'),
                 os.path.join(args.staging, section, f'{section}.json'),
                 os.path.join(args.staging, f'{section}.jsonl'),
                 os.path.join(args.staging, f'{section}.json')]
        staging_path = next((c for c in cands if os.path.isfile(c)), None)
        src_path = os.path.join(args.root, section, f'{section}.json')
        if not staging_path or not os.path.isfile(src_path):
            continue
        found = True
        m, d, e, x = reconcile_section(section, staging_path, src_path, args.out)
        print(f'{section}: matched={m} diffs={d} extra={e} missing={x}')
    if not found:
        print('no matching staging/content_src sections found')


if __name__ == '__main__':
    main()
