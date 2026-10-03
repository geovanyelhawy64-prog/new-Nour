import sqlite3, sys
sys.stdout.reconfigure(encoding='utf-8')
conn = sqlite3.connect('assets/databases/noor.db')
c = conn.cursor()
c.execute("SELECT section_order, type, title, text_ar FROM agpeya_sections WHERE hour_id = 'prime' AND section_order <= 10")
for r in c.fetchall():
    print(f"Order: {r[0]} | Type: {r[1]} | Title: {r[2]} | Text: {r[3][:40]}")
