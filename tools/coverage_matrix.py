#!/usr/bin/env python3
"""Build content-coverage matrices and gap reports under review/."""
import argparse
import csv
import json
import os
import sys
from collections import Counter, defaultdict


def load_rows(root, table):
    p = os.path.join(root, table, f'{table}.json')
    with open(p, encoding='utf-8') as fh:
        return json.load(fh).get('rows', [])


def as_int(v):
    try:
        return int(str(v).strip())
    except (ValueError, TypeError):
        return None


def expected_cells():
    cells = []
    for m in range(1, 13):
        for d in range(1, 31):
            cells.append((m, d))
    for d in range(1, 7):
        cells.append((13, d))
    return cells


def day_counter(rows):
    c = Counter()
    for r in rows:
        m, d = as_int(r.get('coptic_month')), as_int(r.get('coptic_day'))
        if m is not None and d is not None:
            c[(m, d)] += 1
    return c


def write_csv(path, header, rows):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='') as fh:
        w = csv.writer(fh, lineterminator='\n')
        w.writerow(header)
        w.writerows(rows)


def gaps_for(present):
    return [(m, d) for m, d in expected_cells() if (m, d) not in present]


def report_daily(rows, out, name):
    counts = day_counter(rows)
    write_csv(os.path.join(out, f'coverage_{name}.csv'),
              ['coptic_month', 'coptic_day', 'count'],
              [[m, d, counts[(m, d)]] for (m, d) in sorted(counts)])
    gaps = gaps_for(counts)
    write_csv(os.path.join(out, f'coverage_{name}_gaps.csv'),
              ['coptic_month', 'coptic_day', 'empty_reason'],
              [[m, d, ''] for m, d in gaps])
    return len(counts), len(gaps)


def report_katameros(rows, out):
    counts = Counter()
    for r in rows:
        m, d = as_int(r.get('coptic_month')), as_int(r.get('coptic_day'))
        if m is None or d is None:
            continue
        counts[(m, d, str(r.get('service_type', '')), str(r.get('reading_type', '')))] += 1
    write_csv(os.path.join(out, 'coverage_katameros.csv'),
              ['coptic_month', 'coptic_day', 'service_type', 'reading_type', 'count'],
              [[m, d, s, t, counts[(m, d, s, t)]] for (m, d, s, t) in sorted(counts)])
    present = {(m, d) for (m, d, _, _) in counts}
    gaps = gaps_for(present)
    write_csv(os.path.join(out, 'coverage_katameros_gaps.csv'),
              ['coptic_month', 'coptic_day', 'empty_reason'],
              [[m, d, ''] for m, d in gaps])
    return len(counts), len(gaps)


def report_agpeya(rows, out):
    seen = {}
    for r in rows:
        ho = str(r.get('hour_order', '')).strip()
        if ho and ho not in seen:
            seen[ho] = str(r.get('name_ar', ''))
    def key(ho):
        n = as_int(ho)
        return (n is None, n if n is not None else ho)
    write_csv(os.path.join(out, 'coverage_agpeya.csv'),
              ['hour_order', 'name_ar', 'present'],
              [[ho, seen[ho], 'yes'] for ho in sorted(seen, key=key)])
    return len(seen)


def report_bible(books, verses, out):
    book_ids = {str(b.get('id', '')).strip() for b in books}
    chapters = defaultdict(set)
    vcount = Counter()
    for v in verses:
        bid = str(v.get('book_id', '')).strip()
        vcount[bid] += 1
        ch = as_int(v.get('chapter'))
        chapters[bid].add(ch if ch is not None else str(v.get('chapter', '')))
    all_ids = sorted(book_ids | set(vcount), key=lambda b: (as_int(b) is None, as_int(b) if as_int(b) is not None else b))
    write_csv(os.path.join(out, 'coverage_bible.csv'),
              ['book_id', 'present', 'chapters', 'verses'],
              [[bid, 'yes' if bid in book_ids else 'no', len(chapters.get(bid, ())), vcount.get(bid, 0)] for bid in all_ids])
    return len(all_ids)


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--root', default='content_src')
    p.add_argument('--out', default='review')
    p.add_argument('--strict', action='store_true')
    args = p.parse_args()

    gap_total = 0
    k_cells, k_gaps = report_katameros(load_rows(args.root, 'katameros_readings'), args.out)
    gap_total += k_gaps
    s_cells, s_gaps = report_daily(load_rows(args.root, 'synaxarium_entries'), args.out, 'synaxarium')
    gap_total += s_gaps
    d_cells, d_gaps = report_daily(load_rows(args.root, 'difnar_entries'), args.out, 'difnar')
    gap_total += d_gaps
    a = report_agpeya(load_rows(args.root, 'agpeya_hours'), args.out)
    b = report_bible(load_rows(args.root, 'bible_books'), load_rows(args.root, 'bible_verses'), args.out)

    print(f'katameros_readings: {k_cells} observed cells, {k_gaps} gap cells')
    print(f'synaxarium_entries: {s_cells} observed days, {s_gaps} gap cells')
    print(f'difnar_entries: {d_cells} observed days, {d_gaps} gap cells')
    print(f'agpeya_hours: {a} distinct hours present')
    print(f'bible: {b} book ids')
    print(f'total gap cells: {gap_total}')
    if args.strict and gap_total:
        sys.exit(1)


if __name__ == '__main__':
    main()
