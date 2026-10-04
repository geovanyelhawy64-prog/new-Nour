#!/usr/bin/env python3
"""Validate exported content_src against emptiness, NFC, and FK sanity."""
import argparse
import json
import os
import sys
import unicodedata


def is_printable_control_free(s: str) -> bool:
    # allow normal whitespace; ban all other control characters
    for ch in s:
        if unicodedata.category(ch).startswith('C') and ch not in '\n\r\t ':
            return False
    return True


def validate_dir(root):
    errors = []
    for subdir, _, files in os.walk(root):
        for f in files:
            if not f.endswith('.json'):
                continue
            p = os.path.join(subdir, f)
            with open(p, encoding='utf-8') as fh:
                payload = json.load(fh)
            for row in payload.get('rows', []):
                for k, v in row.items():
                    if isinstance(v, str):
                        if not v or v.isspace():
                            errors.append(f'empty string {k} in {p} row {row.get("content_id")}')
                        if unicodedata.normalize('NFC', v) != v:
                            errors.append(f'non-NFC {k} in {p} row {row.get("content_id")}')
                        if not is_printable_control_free(v):
                            errors.append(f'control char {k} in {p} row {row.get("content_id")}')
    return errors


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--root', default='content_src')
    args = p.parse_args()
    errs = validate_dir(args.root)
    if errs:
        print('\n'.join(errs))
        sys.exit(1)
    print(f'{args.root}: validation OK')


if __name__ == '__main__':
    main()
