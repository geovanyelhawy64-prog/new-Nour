#!/usr/bin/env python3
"""
Comprehensive audit of noor.db - verifies all tables, row counts,
and data integrity against expected values.
"""
import sqlite3
import os
import sys

if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

DB_PATH = os.path.join(os.path.dirname(__file__), '..', 'assets', 'databases', 'noor.db')

# Expected minimum row counts based on verified sources
EXPECTED = {
    'bible_books':          {'min': 73,    'desc': 'أسفار الكتاب المقدس (73 سفر)'},
    'bible_verses':         {'min': 35700, 'desc': 'آيات الكتاب المقدس'},
    'bible_commentaries':   {'min': 3,     'desc': 'تفاسير الأصحاحات'},
    'bible_cross_references': {'min': 31,  'desc': 'شواهد الآيات المترابطة'},
    'agpeya_hours':         {'min': 8,     'desc': 'سواعي الأجبية (7 + الستار)'},
    'agpeya_sections':      {'min': 300,   'desc': 'أقسام صلوات الأجبية'},
    'liturgies':            {'min': 3,     'desc': 'القداسات (باسيلي/غريغوري/كيرلسي)'},
    'liturgy_sections':     {'min': 100,   'desc': 'أقسام القداسات'},
    'liturgy_parts':        {'min': 1000,  'desc': 'أجزاء القداسات التفصيلية'},
    'hymn_books':           {'min': 4,     'desc': 'كتب الألحان (أسامة لطفي 4 أجزاء)'},
    'hymns':                {'min': 50,    'desc': 'الألحان'},
    'hymn_segments':        {'min': 50,    'desc': 'مقاطع الألحان'},
    'psalis':               {'min': 18,    'desc': 'التسابيح (هوسات/تذاكيات/مديحات)'},
    'psali_sections':       {'min': 6,     'desc': 'أقسام التسابيح النصية'},
    'synaxarium_entries':   {'min': 800,   'desc': 'السنكسار (تذكارات يومية)'},
    'katameros_readings':   {'min': 4000,  'desc': 'قراءات القطمارس'},
    'saints':               {'min': 700,   'desc': 'القديسين'},
    'difnar_entries':       {'min': 200,   'desc': 'الدفنار'},
    'pascha_readings':      {'min': 600,   'desc': 'قراءات البصخة'},
    'feasts_and_fasts':     {'min': 30,    'desc': 'الأعياد والأصوام'},
    'occasional_prayers':   {'min': 50,    'desc': 'الصلوات المناسباتية'},
    'theology_articles':    {'min': 70,    'desc': 'مقالات لاهوتية'},
    'daily_verses':         {'min': 365,   'desc': 'آيات يومية'},
    'monasteries':          {'min': 20,    'desc': 'الأديرة (قديم)'},
    'sacraments':           {'min': 7,     'desc': 'الأسرار السبعة'},
    'sacrament_sections':   {'min': 20,    'desc': 'أقسام الأسرار'},
    'coptic_dictionary':    {'min': 50,    'desc': 'القاموس القبطي'},
    'rites':                {'min': 10,    'desc': 'الطقوس الطقسية'},
    'rite_sections':        {'min': 40,    'desc': 'أقسام الطقوس'},
    'holy_places':          {'min': 20,    'desc': 'الأماكن المقدسة والأديرة'},
    'emotion_prayers':      {'min': 10,    'desc': 'صلوات حسب المشاعر والحاجة'},
}

def check_empty_text_fields(cursor, table, text_columns):
    """Check for rows with empty or NULL text fields"""
    issues = []
    for col in text_columns:
        cursor.execute(f"SELECT COUNT(*) FROM {table} WHERE {col} IS NULL OR TRIM({col}) = ''")
        count = cursor.fetchone()[0]
        if count > 0:
            issues.append(f"  ⚠️  العمود '{col}': {count} صف فارغ أو NULL")
    return issues

def check_duplicate_names(cursor, table, name_col):
    """Check for duplicate names"""
    cursor.execute(f"SELECT {name_col}, COUNT(*) as cnt FROM {table} GROUP BY {name_col} HAVING cnt > 1 LIMIT 5")
    dupes = cursor.fetchall()
    if dupes:
        return [f"  ⚠️  تكرار في '{name_col}': {', '.join(str(d[0]) for d in dupes)}"]
    return []

def main():
    if not os.path.exists(DB_PATH):
        print(f"❌ قاعدة البيانات غير موجودة: {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    # Get all tables
    c.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name")
    all_tables = [row[0] for row in c.fetchall()]

    # Filter out drift internal tables
    user_tables = [t for t in all_tables if not t.startswith('drift_') and not t.startswith('sqlite_') and t != '__drift_schema_version']

    print("=" * 70)
    print("📊 تقرير فحص شامل لقاعدة بيانات noor.db")
    print("=" * 70)
    print(f"\n📁 حجم الملف: {os.path.getsize(DB_PATH) / (1024*1024):.1f} MB")
    print(f"📋 عدد الجداول: {len(user_tables)}")
    print()

    total_rows = 0
    issues = []
    passed = 0
    failed = 0
    warnings = 0

    print(f"{'الجدول':<30} {'المتوقع':>8} {'الفعلي':>8} {'الحالة':>10}")
    print("-" * 60)

    for table in sorted(user_tables):
        c.execute(f"SELECT COUNT(*) FROM {table}")
        count = c.fetchone()[0]
        total_rows += count

        if table in EXPECTED:
            exp = EXPECTED[table]
            min_count = exp['min']
            desc = exp['desc']

            if count >= min_count:
                status = "✅ PASS"
                passed += 1
            elif count > 0:
                status = "⚠️  LOW"
                warnings += 1
                issues.append(f"⚠️  {table}: {count} صف فقط (المتوقع ≥{min_count}) - {desc}")
            else:
                status = "❌ EMPTY"
                failed += 1
                issues.append(f"❌ {table}: فارغ تماماً! (المتوقع ≥{min_count}) - {desc}")

            print(f"{table:<30} {f'≥{min_count}':>8} {count:>8} {status:>10}")

            # Check for empty text fields in important tables
            if count > 0:
                c.execute(f"PRAGMA table_info({table})")
                cols = [row[1] for row in c.fetchall() if row[2] == 'TEXT' and row[3] == 1]  # NOT NULL text cols
                empty_issues = check_empty_text_fields(c, table, cols[:3])  # Check first 3 text cols
                issues.extend(empty_issues)
        else:
            status = "ℹ️  N/A" if count > 0 else "⚠️  EMPTY"
            if count == 0 and table not in ('bookmarks', 'reading_progress', 'user_notes', 'highlighted_verses', 'verse_highlights'):
                issues.append(f"ℹ️  {table}: جدول غير متوقع أو فارغ ({count} صف)")
            print(f"{table:<30} {'---':>8} {count:>8} {status:>10}")

    print("-" * 60)
    print(f"\n📈 إجمالي الصفوف في كل الجداول: {total_rows:,}")
    print(f"✅ جداول ناجحة: {passed}")
    print(f"⚠️  جداول بتحذيرات: {warnings}")
    print(f"❌ جداول فاشلة: {failed}")

    if issues:
        print(f"\n{'=' * 70}")
        print("🔍 التفاصيل والمشاكل المكتشفة:")
        print("=" * 70)
        for issue in issues:
            print(issue)
    else:
        print("\n🎉 لا توجد مشاكل! كل البيانات سليمة ومطابقة.")

    # Bible-specific checks
    print(f"\n{'=' * 70}")
    print("📖 فحص تفصيلي للكتاب المقدس:")
    print("=" * 70)

    try:
        c.execute("SELECT COUNT(DISTINCT book_id) FROM bible_verses")
        books_with_verses = c.fetchone()[0]
        print(f"  الأسفار التي تحتوي آيات: {books_with_verses}/73")

        c.execute("SELECT COUNT(*) FROM bible_verses WHERE book_id <= 46")
        ot = c.fetchone()[0]
        c.execute("SELECT COUNT(*) FROM bible_verses WHERE book_id > 46")
        nt = c.fetchone()[0]
        print(f"  العهد القديم: {ot:,} آية")
        print(f"  العهد الجديد: {nt:,} آية")

        # Check psalms count dynamically
        c.execute("SELECT id FROM bible_books WHERE name_ar LIKE '%مزامير%'")
        psalms_row = c.fetchone()
        psalms_book_id = psalms_row[0] if psalms_row else 21
        c.execute("SELECT COUNT(*) FROM bible_verses WHERE book_id = ?", (psalms_book_id,))
        psalms = c.fetchone()[0]
        print(f"  المزامير (سفر {psalms_book_id} - الـ 151 مزمور كاملة): {psalms} آية")

        # Check for hamza issues
        c.execute("SELECT COUNT(*) FROM bible_verses WHERE text LIKE '%إله%'")
        with_hamza = c.fetchone()[0]
        c.execute("SELECT COUNT(*) FROM bible_verses WHERE text LIKE '%اله%' AND text NOT LIKE '%إله%'")
        without_hamza = c.fetchone()[0]
        print(f"  آيات بكلمة 'إله' (بهمزة): {with_hamza}")
        print(f"  آيات بكلمة 'اله' (بدون همزة): {without_hamza}")
        if without_hamza > 100:
            print(f"  ⚠️  تحذير: عدد كبير من الآيات بدون همزة في 'إله'!")

    except Exception as e:
        print(f"  ❌ خطأ في فحص الكتاب المقدس: {e}")

    # Agpeya check
    print(f"\n📿 فحص الأجبية:")
    try:
        c.execute("SELECT id, name_ar FROM agpeya_hours ORDER BY id")
        hours = c.fetchall()
        for h in hours:
            c.execute("SELECT COUNT(*) FROM agpeya_sections WHERE hour_id = ?", (h[0],))
            sections = c.fetchone()[0]
            print(f"  {h[1]}: {sections} قسم")
    except Exception as e:
        print(f"  ❌ خطأ: {e}")

    # Synaxarium check
    print(f"\n📅 فحص السنكسار:")
    try:
        c.execute("SELECT coptic_month, COUNT(*) FROM synaxarium_entries GROUP BY coptic_month ORDER BY coptic_month")
        months = c.fetchall()
        for m in months:
            print(f"  شهر {m[0]}: {m[1]} تذكارة")

        # Check for fake Nasie days
        c.execute("SELECT COUNT(*) FROM synaxarium_entries WHERE coptic_month = 13 AND coptic_day > 6")
        fake_nasie = c.fetchone()[0]
        if fake_nasie > 0:
            print(f"  ❌ تحذير: {fake_nasie} تذكارة وهمية في أيام نسيء (يوم 7-30)!")
        else:
            print(f"  ✅ أيام نسيء نظيفة (لا توجد تذكارات وهمية)")
    except Exception as e:
        print(f"  ❌ خطأ: {e}")

    print(f"\n{'=' * 70}")
    print("✅ انتهى الفحص الشامل")
    print("=" * 70)

    conn.close()

if __name__ == '__main__':
    main()
