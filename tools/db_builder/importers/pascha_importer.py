import re
import sqlite3
import zipfile
import hashlib
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend

SALT_IV = b'\x00' * 12 + b'orso'
KEY = hashlib.pbkdf2_hmac('sha1', b'1j2e3s4u5s6', SALT_IV, 100, dklen=32)

def decrypt_orso(data: bytes) -> str:
    cipher = Cipher(algorithms.AES(KEY), modes.CBC(SALT_IV), backend=default_backend())
    decryptor = cipher.decryptor()
    padded = decryptor.update(data) + decryptor.finalize()
    pad = padded[-1]
    if 1 <= pad <= 16 and padded[-pad:] == bytes([pad]) * pad:
        padded = padded[:-pad]
    s = padded.decode('utf-8', errors='ignore').strip()
    if s.startswith('\ufeff'):
        s = s[1:]
    return s.replace('\r', '')

def parse_hour_file(text: str):
    lines = text.split('\n')
    sections = []
    cur_title = None
    cur_lines = []

    for l in lines:
        l_str = l.strip()
        if l_str.startswith('+') and not l_str.startswith('+++'):
            if cur_title and cur_lines:
                content = '\n'.join(cur_lines).strip()
                if content:
                    sections.append((cur_title, content))
            cur_title = l_str[1:].strip()
            cur_lines = []
        elif l_str in ['+++', '&', '&&', '&&&']:
            continue
        else:
            if cur_title is not None:
                cur_lines.append(l)

    if cur_title and cur_lines:
        content = '\n'.join(cur_lines).strip()
        if content:
            sections.append((cur_title, content))

    return sections

DAY_HOURS = [
    # (code, hour_num, hour_name, day_id, day_name)
    # Monday Night (Sunday Eve)
    ('sun1', 1, 'الساعة الأولى', 'monday_night', 'ليلة الإثنين'),
    ('sun3', 3, 'الساعة الثالثة', 'monday_night', 'ليلة الإثنين'),
    ('sun6', 6, 'الساعة السادسة', 'monday_night', 'ليلة الإثنين'),
    ('sun9', 9, 'الساعة التاسعة', 'monday_night', 'ليلة الإثنين'),
    ('sun11', 11, 'الساعة الحادية عشر', 'monday_night', 'ليلة الإثنين'),
    # Monday Day
    ('mm1', 1, 'باكر', 'monday_day', 'يوم الإثنين'),
    ('mm3', 3, 'الساعة الثالثة', 'monday_day', 'يوم الإثنين'),
    ('mm6', 6, 'الساعة السادسة', 'monday_day', 'يوم الإثنين'),
    ('mm9', 9, 'الساعة التاسعة', 'monday_day', 'يوم الإثنين'),
    ('mm11', 11, 'الساعة الحادية عشر', 'monday_day', 'يوم الإثنين'),
    # Tuesday Night
    ('mn1', 1, 'الساعة الأولى', 'tuesday_night', 'ليلة الثلاثاء'),
    ('mn3', 3, 'الساعة الثالثة', 'tuesday_night', 'ليلة الثلاثاء'),
    ('mn6', 6, 'الساعة السادسة', 'tuesday_night', 'ليلة الثلاثاء'),
    ('mn9', 9, 'الساعة التاسعة', 'tuesday_night', 'ليلة الثلاثاء'),
    ('mn11', 11, 'الساعة الحادية عشر', 'tuesday_night', 'ليلة الثلاثاء'),
    # Tuesday Day
    ('tm1', 1, 'باكر', 'tuesday_day', 'يوم الثلاثاء'),
    ('tm3', 3, 'الساعة الثالثة', 'tuesday_day', 'يوم الثلاثاء'),
    ('tm6', 6, 'الساعة السادسة', 'tuesday_day', 'يوم الثلاثاء'),
    ('tm9', 9, 'الساعة التاسعة', 'tuesday_day', 'يوم الثلاثاء'),
    ('tm11', 11, 'الساعة الحادية عشر', 'tuesday_day', 'يوم الثلاثاء'),
    # Wednesday Night
    ('tn1', 1, 'الساعة الأولى', 'wednesday_night', 'ليلة الأربعاء'),
    ('tn3', 3, 'الساعة الثالثة', 'wednesday_night', 'ليلة الأربعاء'),
    ('tn6', 6, 'الساعة السادسة', 'wednesday_night', 'ليلة الأربعاء'),
    ('tn9', 9, 'الساعة التاسعة', 'wednesday_night', 'ليلة الأربعاء'),
    ('tn11', 11, 'الساعة الحادية عشر', 'wednesday_night', 'ليلة الأربعاء'),
    # Wednesday Day
    ('wm1', 1, 'باكر', 'wednesday_day', 'يوم الأربعاء'),
    ('wm3', 3, 'الساعة الثالثة', 'wednesday_day', 'يوم الأربعاء'),
    ('wm6', 6, 'الساعة السادسة', 'wednesday_day', 'يوم الأربعاء'),
    ('wm9', 9, 'الساعة التاسعة', 'wednesday_day', 'يوم الأربعاء'),
    ('wm11', 11, 'الساعة الحادية عشر', 'wednesday_day', 'يوم الأربعاء'),
    # Thursday Night
    ('wn1', 1, 'الساعة الأولى', 'thursday_night', 'ليلة الخميس'),
    ('wn3', 3, 'الساعة الثالثة', 'thursday_night', 'ليلة الخميس'),
    ('wn6', 6, 'الساعة السادسة', 'thursday_night', 'ليلة الخميس'),
    ('wn9', 9, 'الساعة التاسعة', 'thursday_night', 'ليلة الخميس'),
    ('wn11', 11, 'الساعة الحادية عشر', 'thursday_night', 'ليلة الخميس'),
    # Covenant Thursday Day
    ('thm1', 1, 'باكر', 'covenant_thursday', 'خميس العهد'),
    ('thm3', 3, 'الساعة الثالثة', 'covenant_thursday', 'خميس العهد'),
    ('thm6', 6, 'الساعة السادسة', 'covenant_thursday', 'خميس العهد'),
    ('thm9', 9, 'الساعة التاسعة', 'covenant_thursday', 'خميس العهد'),
    ('thm11', 11, 'الساعة الحادية عشر', 'covenant_thursday', 'خميس العهد'),
    # Good Friday Night
    ('thn1', 1, 'الساعة الأولى', 'good_friday_night', 'ليلة الجمعة العظيمة'),
    ('thn3', 3, 'الساعة الثالثة', 'good_friday_night', 'ليلة الجمعة العظيمة'),
    ('thn6', 6, 'الساعة السادسة', 'good_friday_night', 'ليلة الجمعة العظيمة'),
    ('thn9', 9, 'الساعة التاسعة', 'good_friday_night', 'ليلة الجمعة العظيمة'),
    ('thn11', 11, 'الساعة الحادية عشر', 'good_friday_night', 'ليلة الجمعة العظيمة'),
    # Good Friday Day
    ('f1', 1, 'باكر', 'good_friday', 'الجمعة العظيمة'),
    ('f3', 3, 'الساعة الثالثة', 'good_friday', 'الجمعة العظيمة'),
    ('f6', 6, 'الساعة السادسة', 'good_friday', 'الجمعة العظيمة'),
    ('f9', 9, 'الساعة التاسعة', 'good_friday', 'الجمعة العظيمة'),
    ('f11', 11, 'الساعة الحادية عشر', 'good_friday', 'الجمعة العظيمة'),
    ('f12', 12, 'الساعة الثانية عشر', 'good_friday', 'الجمعة العظيمة'),
    # Joyous Saturday
    ('sa3', 3, 'الساعة الثالثة', 'joyous_saturday', 'سبت الفرح'),
    ('sa6', 6, 'الساعة السادسة', 'joyous_saturday', 'سبت الفرح'),
    ('sa9', 9, 'الساعة التاسعة', 'joyous_saturday', 'سبت الفرح'),
]

def map_reading_type(title: str) -> str:
    t = title.strip()
    if 'نبوات' in t or 'النبوات' in t:
        return 'prophecy'
    elif 'ثوك' in t or 'أمانة' in t:
        return 'hymn'
    elif 'المزمور القبط' in t:
        return 'psalm_coptic'
    elif 'الإنجيل القبط' in t:
        return 'gospel_coptic'
    elif 'المزمور' in t:
        return 'psalm'
    elif 'الإنجيل' in t:
        return 'gospel'
    elif 'طرح' in t or 'الطرح' in t:
        return 'tarh'
    elif 'بيان' in t:
        return 'commentary'
    return 'hymn'

def extract_reference(text: str) -> str:
    lines = text.split('\n')
    for line in lines[:3]:
        m = re.search(r'\((.*?)\)', line)
        if m:
            return m.group(1).strip()
    return ''

def import_pascha(cursor: sqlite3.Cursor, apk_zip: zipfile.ZipFile):
    print("Decrypting and populating complete Holy Pascha Dallal (54 hours across Holy Week)...")

    cursor.execute("DELETE FROM pascha_readings;")

    all_rows = []
    hours_count = 0

    for code, h_num, h_name, d_id, d_name in DAY_HOURS:
        fname = f'assets/dallal/{code}.orso'
        if fname not in apk_zip.namelist():
            continue

        hours_count += 1
        raw = apk_zip.read(fname)
        text = decrypt_orso(raw)
        sections = parse_hour_file(text)

        for order, (title, body) in enumerate(sections, start=1):
            rtype = map_reading_type(title)
            ref = extract_reference(body)
            all_rows.append((
                d_id, d_name, h_num, h_name, rtype,
                ref if ref else None, body, order
            ))

    cursor.executemany("""
        INSERT INTO pascha_readings (
            day_id, day_name_ar, hour_number, hour_name_ar,
            reading_type, reference, text, reading_order
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """, all_rows)

    cursor.execute("SELECT COUNT(*) FROM pascha_readings;")
    total_count = cursor.fetchone()[0]
    print(f"Successfully populated {total_count} Pascha readings and prayers across {hours_count} hours!")
