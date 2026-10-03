# -*- coding: utf-8 -*-
"""
Saints Importer for Noor App.
Populates canonical Coptic Orthodox Saints and Martyrs biographies from the Synaxarium.
"""

import sqlite3
import re

PREFIX_PATTERNS = [
    r'^تذكار\s+استشهاد\s+القديس[ة]?\s+',
    r'^تذكار\s+نياحة\s+القديس[ة]?\s+',
    r'^تذكار\s+استشهاد\s+',
    r'^تذكار\s+نياحة\s+',
    r'^استشهاد\s+القديس[ة]?\s+',
    r'^نياحة\s+القديس[ة]?\s+',
    r'^استشهاد\s+الأنبا\s+',
    r'^نياحة\s+الأنبا\s+',
    r'^استشهاد\s+الشهيد[ة]?\s+',
    r'^استشهاد\s+الأب\s+',
    r'^نياحة\s+الأب\s+',
    r'^استشهاد\s+مار\s+',
    r'^نياحة\s+البابا\s+',
    r'^استشهاد\s+',
    r'^نياحة\s+',
]

def clean_saint_name(title: str) -> str:
    cleaned = title.strip()
    for pat in PREFIX_PATTERNS:
        cleaned = re.sub(pat, '', cleaned, flags=re.IGNORECASE).strip()
    return cleaned if cleaned else title.strip()

def determine_saint_type(title: str, orig_type: str) -> str:
    t = title.lower()
    if any(w in t for w in ['عذراء', 'شهيدة', 'قديسة', 'مارينا', 'دميانة', 'رفقا', 'فيرولينا', 'إيلارية', 'أربسيما']):
        return 'women'
    if any(w in t for w in ['البابا كيرلس السادس', 'حبيب جرجس', 'بيشوي كامل', 'ميخائيل إبراهيم', 'أبونا يسى']):
        return 'modern'
    if orig_type in ['patriarch', 'bishop'] or any(w in t for w in ['البابا', 'بطريرك', 'أسقف', 'مطران', 'أثناسيوس', 'ديسقورس', 'كيرلس']):
        return 'patriarchs'
    if orig_type == 'monk' or any(w in t for w in ['راهب', 'متوحد', 'سائح', 'أنطونيوس', 'بولا', 'مكاريوس', 'باخوميوس', 'شنودة']):
        return 'monks'
    if orig_type == 'martyr' or any(w in t for w in ['شهيد', 'مارجرجس', 'مارمينا', 'أبانوب', 'تادرس', 'موريس', 'قلتة']):
        return 'martyrs'
    return 'martyrs' if 'شهيد' in t else 'monks' if 'أنبا' in t else 'saints'

def import_saints(cursor: sqlite3.Cursor):
    print("Extracting and populating Saints and Martyrs from Synaxarium...")
    cursor.execute("DELETE FROM saints;")

    cursor.execute("""
        SELECT id, coptic_month, coptic_day, title, type, short_text, full_text
        FROM synaxarium_entries
        WHERE type IN ('martyr', 'saint', 'monk', 'patriarch', 'bishop')
    """)
    rows = cursor.fetchall()

    saints_to_insert = []
    seen_ids = set()

    for row in rows:
        entry_id, month, day, title, orig_type, short_text, full_text = row
        saint_id = f"saint_{entry_id.replace('synax_', '')}"
        if saint_id in seen_ids:
            continue
        seen_ids.add(saint_id)

        clean_name = clean_saint_name(title)
        saint_type = determine_saint_type(title, orig_type)
        short_bio = short_text if short_text else clean_name
        bio = full_text if full_text else short_bio

        saints_to_insert.append((
            saint_id,
            clean_name,
            None, # nameCoptic
            None, # nameEn
            saint_type,
            month,
            day,
            bio,
            short_bio,
        ))

    cursor.executemany("""
        INSERT INTO saints (
            id, name_ar, name_coptic, name_en, type,
            feast_month, feast_day, biography, short_bio
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, saints_to_insert)

    print(f"Successfully inserted {len(saints_to_insert)} canonical saints and martyrs.")
