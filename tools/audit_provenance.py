#!/usr/bin/env python3
"""
Provenance Audit for Noor Database
Classifies all tables by origin: printed | reference | authored | unknown
Output: docs/provenance_audit.csv
"""
import csv
import json
import sqlite3
import sys
from pathlib import Path

DB_PATH = Path('assets/databases/noor.db')
OUT_CSV = Path('docs/provenance_audit.csv')

# Known builder scripts mapping
BUILDER_MAP = {
    'bible_books': 'tools/ingest_bible_usfm.py / tools/apply_bible_van_dyke.py',
    'bible_verses': 'tools/ingest_bible_usfm.py / tools/apply_bible_van_dyke.py',
    'bible_commentaries': 'tools/import_commentaries.py',
    'bible_cross_references': 'tools/import_cross_references.py',
    'agpeya_hours': 'tools/analyze_agpeya_structure.py (legacy)',
    'agpeya_sections': 'tools/analyze_agpeya_structure.py (legacy)',
    'difnar_entries': 'clean_synaxarium.py (partial) / manual',
    'synaxarium_entries': 'clean_synaxarium.py',
    'saints': 'tools/import_holy_places.py (partial) / tools/migrate_monasteries.py (deprecated)',
    'feasts_and_fasts': 'tools/import_holy_places.py (partial) / manual',
    'hymn_books': 'tools/import_psali.py / tools/restructure_hymns_and_indexes.py',
    'hymns': 'tools/import_psali.py / tools/restructure_hymns_and_indexes.py',
    'hymn_segments': 'tools/import_psali.py / tools/upgrade_coptic_and_hymns.py (deprecated)',
    'psalis': 'tools/import_psali.py',
    'psali_sections': 'tools/import_psali.py',
    'liturgies': 'tools/import_rites.py / manual',
    'liturgy_sections': 'tools/import_rites.py / manual',
    'liturgy_parts': 'tools/import_rites.py / manual',
    'rites': 'tools/import_rites.py',
    'rite_sections': 'tools/import_rites.py',
    'pascha_readings': 'tools/import_holy_places.py (partial) / manual',
    'katameros_readings': 'tools/import_holy_places.py (partial) / manual',
    'coptic_dictionary': 'tools/import_dictionary.py',
    'daily_verses': 'tools/enrich_massive_data.py (deprecated) / manual',
    'emotion_prayers': 'tools/import_emotion_prayers.py / tools/migrate_occasional_prayers.py (deprecated)',
    'occasional_prayers': 'tools/migrate_occasional_prayers.py (deprecated)',
    'monasteries': 'tools/import_holy_places.py / tools/migrate_monasteries.py (deprecated)',
    'holy_places': 'tools/import_holy_places.py',
    'theology_articles': 'tools/migrate_theology_articles.py (deprecated)',
    'bookmarks': 'user data (runtime)',
    'sqlite_sequence': 'internal (auto)',
}

# Provenance classification rules
# printed  = منقول من كتاب مطبوع معتمد (مع الطبعة والصفحة)
# reference = نقل من مرجع رقمي، ينتظر مطابقته بالمطبوع
# authored  = كتبه صاحب التطبيق أو ولّده برنامج (enrich scripts)
# unknown   = لا يُعرف أصله

CLASSIFICATION = {
    # ---- PRINTED: من كتب مطبوعة معتمدة ----
    'bible_books': 'printed',
    'bible_verses': 'printed',
    'bible_commentaries': 'printed',
    'bible_cross_references': 'printed',
    'agpeya_hours': 'printed',           # من كتب الأجبية المطبوعة (مطبعة القديس مرقس)
    'agpeya_sections': 'printed',        # من كتب الأجبية المطبوعة
    'synaxarium_entries': 'printed',     # من السنكسار المطبوع (الأب متى المسكين / مجمع القديسين)
    'feasts_and_fasts': 'printed',       # من الكتب الطقسية المطبوعة
    'hymn_books': 'printed',             # من ألحان الشماس أسامة لطفى (4 مجلدات مطبوعة)
    'hymns': 'printed',                  # من نفس المصدر المطبوع
    'hymn_segments': 'printed',          # من نفس المصدر المطبوع (مع ترميز المقاطع)
    'psalis': 'printed',                 # من الأبصلمودية المطبوعة
    'psali_sections': 'printed',         # من الأبصلمودية المطبوعة
    'liturgies': 'printed',              # من كتب القداسات المطبوعة (الباسلي، الغريغوري، الكيرلسي)
    'liturgy_sections': 'printed',       # من كتب القداسات المطبوعة
    'liturgy_parts': 'printed',          # من كتب القداسات المطبوعة (مع أدوار: كاهن/شمامس/شعب/سري)
    'pascha_readings': 'printed',        # من البصخة المقدسة المطبوعة
    'katameros_readings': 'printed',     # من القطمارس اليومي المطبوع
    'sacraments': 'printed',             # من كتب الأسرار المقدسة المطبوعة
    'sacrament_sections': 'printed',     # من كتب الأسرار المقدسة المطبوعة
    'saints': 'reference',               # من دليل القديسين (مرجع رقمي، يحتاج مطابقة مطبوع)
    'difnar_entries': 'reference',       # من الدفنار (مرجع رقمي، يحتاج مطابقة مطبوع)

    # ---- AUTHORED: مولد/كُتب للتطبيق ----
    'daily_verses': 'authored',          # من enrich_massive_data.py (deprecated) - تأملات يومية
    'emotion_prayers': 'authored',       # من migrate_occasional_prayers.py (deprecated) - صيدلية المشاعر
    'occasional_prayers': 'authored',    # من migrate_occasional_prayers.py (deprecated)
    'theology_articles': 'authored',     # من migrate_theology_articles.py (deprecated) - 80 مقال لاهوتي
    'coptic_dictionary': 'authored',     # 110 مفردة فقط، مصدر غير موثق

    # ---- UNKNOWN / EMPTY: لا يُعرف أصلها أو فارغة ----
    'monasteries': 'unknown',            # فارغ (0 rows) - لا يوجد مصدر
    'holy_places': 'unknown',            # فارغ (0 rows) - لا يوجد مصدر
    'rites': 'unknown',                  # فارغ (0 rows) - لا يوجد مصدر
    'rite_sections': 'unknown',          # فارغ (0 rows) - لا يوجد مصدر
    'psalis': 'unknown',                 # فارغ (0 rows) - رغم وجود import_psali.py
    'psali_sections': 'unknown',         # فارغ (0 rows)
    'coptic_dictionary': 'authored',     # تم تصنيفه authored أعلاه

    # ---- USER DATA / INTERNAL ----
    'bookmarks': 'user_data',            # بيانات مستخدم وقت التشغيل
    'sqlite_sequence': 'internal',       # داخلي
}

# Publishing decision for v1 release
PUBLISHABLE = {
    'printed': 'YES',
    'reference': 'YES',       # مع ملاحظة: يحتاج مطابقة مطبوع
    'authored': 'NO',         # محجوب في release (visibility=private)
    'unknown': 'NO',          # محجوب
    'user_data': 'NO',        # user.db منفصل
    'internal': 'NO',         # نظامي
}


def get_table_info(cursor, table):
    """Get column info and sample data for a table."""
    cursor.execute(f"PRAGMA table_info({table})")
    cols = cursor.fetchall()
    cursor.execute(f"SELECT * FROM {table} LIMIT 3")
    samples = cursor.fetchall()
    return cols, samples


def main():
    con = sqlite3.connect(DB_PATH)
    cur = con.cursor()

    # Get all tables
    cur.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name")
    all_tables = [r[0] for r in cur.fetchall()]

    OUT_CSV.parent.mkdir(parents=True, exist_ok=True)

    with open(OUT_CSV, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow([
            'table_name', 'row_count', 'builder_script',
            'inferred_origin', 'publishable_v1', 'notes'
        ])

        for table in all_tables:
            if table == 'sqlite_sequence':
                continue

            # Row count
            cur.execute(f'SELECT COUNT(*) FROM {table}')
            row_count = cur.fetchone()[0]

            # Builder script
            builder = BUILDER_MAP.get(table, 'unknown')

            # Classification
            origin = CLASSIFICATION.get(table, 'unknown')
            publishable = PUBLISHABLE.get(origin, 'NO')

            # Notes
            notes = []
            if origin == 'reference':
                notes.append('Needs printed source verification')
            elif origin == 'authored':
                notes.append('Generated by deprecated script; quarantine in dev only')
            elif origin == 'unknown' and row_count == 0:
                notes.append('Empty table; no source identified')
            elif origin == 'authored' and 'deprecated' in builder:
                notes.append('Builder script moved to tools/_deprecated/')

            # Column info for reference
            cur.execute(f"PRAGMA table_info({table})")
            cols = [c[1] for c in cur.fetchall()]
            if 'origin' in cols:
                notes.append('Has origin column')
            if 'review_status' in cols:
                notes.append('Has review_status column')
            if 'visibility' in cols:
                notes.append('Has visibility column')

            writer.writerow([
                table,
                row_count,
                builder,
                origin,
                publishable,
                '; '.join(notes) if notes else ''
            ])

            print(f"{table:30s} | {str(row_count):>6s} | {origin:10s} | {publishable:3s} | {builder}")

    con.close()
    print(f"\n[OK] Audit complete: {OUT_CSV}")

if __name__ == '__main__':
    main()