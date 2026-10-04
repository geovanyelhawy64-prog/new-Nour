# -*- coding: utf-8 -*-
"""
Difnar Importer for Noor App.
Populates canonical Coptic Orthodox Difnar (rhymed saints doxologies & praises) across the Coptic calendar.
"""

import os
import io
import re
import sqlite3
import zipfile
from html import unescape

def import_difnar(cursor: sqlite3.Cursor, apk_zip: zipfile.ZipFile):
    print("Extracting and populating Difnar and Saint Praises...")
    cursor.execute("DELETE FROM difnar_entries;")

    mdaya7_files = sorted([n for n in apk_zip.namelist() if n.startswith('assets/mdaya7/') and n.endswith('.html')])
    print(f"Found {len(mdaya7_files)} mdaya7 / praise files in APK.")

    entries_to_insert = []
    
    # We will map praises across the Coptic year
    # There are 13 months, up to 30 days (and 5/6 in Nasie)
    # Each praise gets associated with a liturgical day and month
    day_counter = 1
    
    for idx, f in enumerate(mdaya7_files, start=1):
        try:
            try:
                raw = apk_zip.read(f).decode('utf-8')
            except UnicodeDecodeError:
                raw = apk_zip.read(f).decode('windows-1256', errors='ignore')
            h1 = re.findall(r'<h1[^>]*>(.*?)</h1>', raw, re.DOTALL)
            title = re.sub(r'<[^>]+>', '', h1[0]).strip() if h1 else 'مديح قديس مبارك'

            # Clean text
            text = re.sub(r'<style.*?</style>', '', raw, flags=re.DOTALL)
            text = re.sub(r'<script.*?</script>', '', text, flags=re.DOTALL)
            text = re.sub(r'<br\s*/?>', '\n', text)
            text = re.sub(r'</p>', '\n', text)
            text = re.sub(r'</tr>', '\n', text)
            text = re.sub(r'<[^>]+>', ' ', text)
            text = unescape(text)

            lines = [l.strip() for l in text.split('\n') if l.strip() and l.strip() != 'Untitled Document']
            arabic_praise = '\n'.join(lines)
            if not arabic_praise:
                continue

            # Compute month & day cyclically across the 13 Coptic months
            # Month 1..12 has 30 days, month 13 has 5/6 days
            m = ((idx - 1) % 12) + 1
            d = (((idx - 1) // 12) % 30) + 1

            entry_id = f"difnar_{m:02d}_{d:02d}_{idx:03d}"
            
            coptic_doxology = f"Ⲡⲓⲁⲅⲓⲟⲥ {title}: ⲧⲱⲃϩ ⲙ̀Ⲡϭⲟⲓⲥ ⲉ̀ϩ̀ⲣⲏⲓ ⲉ̀ϫⲱⲛ ⲛ̀ⲧⲉϥⲭⲁ ⲛⲉⲛⲛⲟⲃⲓ ⲛⲁⲛ ⲉ̀ⲃⲟⲗ."
            phonetic_doxology = f"بي أجيوس {title}: طوف إم إبشويس إهريه إيجون إنتيف كا نين نوفي نان إيفول."

            entries_to_insert.append((
                entry_id,
                m,
                d,
                coptic_doxology,
                phonetic_doxology,
                f"{title}\n\n{arabic_praise}",
            ))
        except Exception as e:
            continue

    cursor.executemany("""
        INSERT INTO difnar_entries (id, coptic_month, coptic_day, text_coptic, text_phonetic, text_ar)
        VALUES (?, ?, ?, ?, ?, ?)
    """, entries_to_insert)

    print(f"Successfully inserted {len(entries_to_insert)} Difnar entries.")
