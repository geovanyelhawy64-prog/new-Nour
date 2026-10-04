#!/usr/bin/env python3
"""Parse eBible Arabic Van Dyck USFM into staging/bible_verses JSONL."""
import argparse
import json
import os
import re
import sys
import unicodedata

CODES = {
    'GEN': 'Genesis', 'EXO': 'Exodus', 'LEV': 'Leviticus', 'NUM': 'Numbers',
    'DEU': 'Deuteronomy', 'JOS': 'Joshua', 'JDG': 'Judges', 'RUT': 'Ruth',
    '1SA': '1 Samuel', '2SA': '2 Samuel', '1KI': '1 Kings', '2KI': '2 Kings',
    '1CH': '1 Chronicles', '2CH': '2 Chronicles', 'EZR': 'Ezra', 'NEH': 'Nehemiah',
    'TOB': 'Tobit', 'JDT': 'Judith', 'EST': 'Esther', 'JOB': 'Job',
    'PSA': 'Psalms', 'PRO': 'Proverbs', 'ECC': 'Ecclesiastes',
    'SNG': 'Song of Solomon', 'WIS': 'Wisdom of Solomon', 'SIR': 'Sirach',
    'ISA': 'Isaiah', 'JER': 'Jeremiah', 'LAM': 'Lamentations', 'BAR': 'Baruch',
    'EZK': 'Ezekiel', 'DAN': 'Daniel', 'HOS': 'Hosea', 'JOL': 'Joel',
    'AMO': 'Amos', 'OBA': 'Obadiah', 'JON': 'Jonah', 'MIC': 'Micah',
    'NAM': 'Nahum', 'HAB': 'Habakkuk', 'ZEP': 'Zephaniah', 'HAG': 'Haggai',
    'ZEC': 'Zechariah', 'MAL': 'Malachi', '1MA': '1 Maccabees', '2MA': '2 Maccabees',
    '1JN': '1 John', '2JN': '2 John', '3JN': '3 John',
    'MAT': 'Matthew', 'MRK': 'Mark', 'LUK': 'Luke', 'JHN': 'John', 'ACT': 'Acts',
    'ROM': 'Romans', '1CO': '1 Corinthians', '2CO': '2 Corinthians', 'GAL': 'Galatians',
    'EPH': 'Ephesians', 'PHP': 'Philippians', 'COL': 'Colossians',
    '1TH': '1 Thessalonians', '2TH': '2 Thessalonians', '1TI': '1 Timothy',
    '2TI': '2 Timothy', 'TIT': 'Titus', 'PHM': 'Philemon', 'HEB': 'Hebrews',
    'JAS': 'James', '1PE': '1 Peter', '2PE': '2 Peter',
    'JUD': 'Jude', 'REV': 'Revelation',
}

USFM_TAG = re.compile(r'\\[a-z0-9]+\**(\*)?')


def strip_usfm(text):
    text = USFM_TAG.sub('', text)
    text = unicodedata.normalize('NFC', text)
    return re.sub(r'\s+', ' ', text).strip()


def parse_file(path, book_id):
    chapter = None
    verse = None
    buf = []
    rows = []

    def flush():
        if chapter is not None and verse is not None and buf:
            text = strip_usfm(' '.join(buf))
            if text:
                rows.append({
                    'content_id': f'bible:book{book_id}:{chapter}:{verse}',
                    'book_id': book_id, 'chapter': chapter, 'verse_number': verse,
                    'text': text, 'origin': 'reference',
                    'translation_id': 'van_dyke_1865',
                })

    with open(path, encoding='utf-8') as fh:
        for line in fh:
            m = re.match(r'\\c (\d+)', line)
            if m:
                flush(); chapter = int(m.group(1)); verse = None; buf = []
                continue
            m = re.match(r'\\v (\d+)(?:-\d+)?\s*(.*)', line)
            if m:
                flush(); verse = int(m.group(1)); buf = [m.group(2)]
                continue
            if verse is not None and line.startswith('\\'):
                continue
            if verse is not None:
                buf.append(line)
        flush()
    return rows


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--usfm', default='raw/arb-vd')
    p.add_argument('--books', default='content_src/bible_books/bible_books.json')
    p.add_argument('--out', default='staging/bible_verses/bible_verses.jsonl')
    args = p.parse_args()

    books = {}
    with open(args.books, encoding='utf-8') as fh:
        for b in json.load(fh)['rows']:
            books[b['name_en']] = b['id']

    os.makedirs(os.path.dirname(args.out), exist_ok=True)
    total = 0
    with open(args.out, 'w', encoding='utf-8', newline='') as out:
        for fname in sorted(os.listdir(args.usfm)):
            m = re.match(r'\d+-([A-Z0-9]+)arb-vd\.usfm$', fname)
            if not m:
                continue
            name_en = CODES.get(m.group(1))
            if name_en not in books:
                print('SKIP no book id for', fname, file=sys.stderr)
                continue
            rows = parse_file(os.path.join(args.usfm, fname), books[name_en])
            for r in rows:
                out.write(json.dumps(r, ensure_ascii=False) + '\n')
            total += len(rows)
    print(f'wrote {total} rows -> {args.out}')


if __name__ == '__main__':
    main()
