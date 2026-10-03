import sqlite3
import sys, io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

db_path = "assets/databases/noor.db"
conn = sqlite3.connect(db_path)
cur = conn.cursor()

print("--- تنظيف السنكسار من الأيام الوهمية لشهر النسيء ---")

# 1. فحص قبل الحذف
cur.execute("SELECT count(*) FROM synaxarium_entries WHERE coptic_month = 13 AND coptic_day > 6;")
to_delete = cur.fetchone()[0]
print(f"عدد الصفوف الوهمية المراد حذفها (النسيء أيام 7-30): {to_delete}")

cur.execute("SELECT count(*) FROM synaxarium_entries WHERE coptic_month = 13;")
total_nasie_before = cur.fetchone()[0]
print(f"إجمالي صفوف النسيء قبل الحذف: {total_nasie_before}")

# 2. تنفيذ الحذف
cur.execute("DELETE FROM synaxarium_entries WHERE coptic_month = 13 AND coptic_day > 6;")
deleted_rows = cur.rowcount
print(f"تم حذف: {deleted_rows} صفاً بنجاح.")

conn.commit()

# 3. فحص بعد الحذف
cur.execute("SELECT count(*) FROM synaxarium_entries WHERE coptic_month = 13;")
total_nasie_after = cur.fetchone()[0]
print(f"إجمالي صفوف النسيء المتبقية الصحيحة (أيام 1-6): {total_nasie_after}")

cur.execute("SELECT DISTINCT coptic_day FROM synaxarium_entries WHERE coptic_month = 13 ORDER BY coptic_day;")
days_remaining = [r[0] for r in cur.fetchall()]
print(f"الأيام المتبقية في شهر النسيء: {days_remaining}")

# تفاصيل السير لكل يوم من أيام النسيء
print("\nتفاصيل السير الصحيحة لأيام النسيء (1-6):")
cur.execute("SELECT coptic_day, title FROM synaxarium_entries WHERE coptic_month = 13 ORDER BY coptic_day, entry_order;")
for day, title in cur.fetchall():
    print(f"  - نسيء {day}: {title}")

# 4. تفريغ وضغط قاعدة البيانات
print("\nجاري ضغط قاعدة البيانات (VACUUM)...")
cur.execute("VACUUM;")
conn.commit()
print("تم ضغط قاعدة البيانات بنجاح.")

# 5. العدد الإجمالي للسنكسار الآن
cur.execute("SELECT count(*) FROM synaxarium_entries;")
total_synax = cur.fetchone()[0]
print(f"العدد الإجمالي لسنكسار الكنيسة الآن: {total_synax} سيرة نقية وخالية من أي فراغات.")

conn.close()
