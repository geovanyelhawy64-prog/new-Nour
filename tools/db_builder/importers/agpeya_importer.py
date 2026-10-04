import zipfile, io, re, sqlite3
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import padding

HOUR_PARTS_MAPPING = [
    (1, 'prime', 'صلاة باكر'),
    (2, 'terce', 'صلاة الساعة الثالثة'),
    (3, 'sext', 'صلاة الساعة السادسة'),
    (4, 'none', 'صلاة الساعة التاسعة'),
    (5, 'vespers', 'صلاة الغروب'),
    (6, 'compline', 'صلاة النوم'),
    (7, 'curtain', 'صلاة الستار'),
    (8, 'midnight', 'صلاة نصف الليل - الخدمة الأولى'),
    (9, 'midnight', 'صلاة نصف الليل - الخدمة الثانية'),
    (10, 'midnight', 'صلاة نصف الليل - الخدمة الثالثة'),
]

def determine_type_and_role(title: str, text: str):
    t_lower = title.lower()
    if 'مز' in title or 'مزمور' in title:
        sec_type = 'psalm'
        role = 'all'
    elif 'إنجيل' in title or 'الانجيل' in title:
        sec_type = 'gospel'
        role = 'all'
    elif 'قِطْعَة' in title or 'قطعة' in title:
        sec_type = 'litanies'
        role = 'people'
    elif 'تحليل' in title or 'تَحْليل' in title:
        sec_type = 'absolution'
        role = 'priest'
    elif 'شكر' in title:
        sec_type = 'thanksgiving'
        role = 'priest'
    elif 'ربانية' in title or 'الرَّبَّانيةُ' in title:
        sec_type = 'intro'
        role = 'all'
    elif 'طلبة' in title or 'طِلْبَة' in title:
        sec_type = 'supplication'
        role = 'all'
    elif 'قانون الإيمان' in title:
        sec_type = 'creed'
        role = 'all'
    elif 'إيليسُون' in title or 'ارحم' in title:
        sec_type = 'response'
        role = 'people'
    else:
        sec_type = 'prayer'
        role = 'all'
        
    ref = None
    m_ref = re.search(r'مز\s*(\d+)', title)
    if m_ref:
        ref = f"مز {m_ref.group(1)}"
    elif 'يوحنا' in title or 'متى' in title or 'لوقا' in title or 'مرقس' in title or 'أفسس' in title:
        ref = title

    return sec_type, role, ref

def import_agpeya(cursor: sqlite3.Cursor, apk_zip: zipfile.ZipFile):
    print("Decrypting and populating complete canonical Agpeya prayers...")
    
    # Decrypt agypa.orso
    ciphertext = apk_zip.read('assets/agypa.orso')
    iv = b"\x00" * 12 + b"orso"
    password = b"1j2e3s4u5s6"
    kdf = PBKDF2HMAC(algorithm=hashes.SHA1(), length=32, salt=iv, iterations=100)
    key = kdf.derive(password)
    cipher = Cipher(algorithms.AES(key), modes.CBC(iv))
    decryptor = cipher.decryptor()
    decrypted = decryptor.update(ciphertext) + decryptor.finalize()
    unpadder = padding.PKCS7(128).unpadder()
    data = unpadder.update(decrypted) + unpadder.finalize()
    text = data.decode('utf-8', errors='replace')
    parts = text.split('++++++++++')

    # Seed 8 canonical hours
    hours = [
        ('prime', 'صلاة باكر', 'Prime', 1, 'الساعة الأولى من النهار - تذكار قيامة الرب ونوره الحقيقي'),
        ('terce', 'صلاة الساعة الثالثة', 'Terce', 2, 'الساعة التاسعة صباحاً - تذكار محاكمة المسيح وحلول الروح القدس'),
        ('sext', 'صلاة الساعة السادسة', 'Sext', 3, 'الساعة الثانية عشرة ظهراً - تذكار صلب مخلصنا الصالح'),
        ('none', 'صلاة الساعة التاسعة', 'None', 4, 'الساعة الثالثة عصراً - تذكار موت الرب المحيي بالجسد على الصليب'),
        ('vespers', 'صلاة الغروب', 'Vespers', 5, 'الساعة الخامسة مساءً - تذكار إنزال جسد الرب وإيداعه في القبر'),
        ('compline', 'صلاة النوم', 'Compline', 6, 'تذكار وضع جسد المسيح في القبر والنوم الأخير'),
        ('curtain', 'صلاة الستار', 'Curtain', 7, 'صلاة خاصة بالآباء الرهبان والعذارى'),
        ('midnight', 'صلاة نصف الليل', 'Midnight', 8, 'ثلاث خدمات - تذكار المجيء الثاني والاستعداد للقاء العريس'),
    ]
    cursor.executemany("""
        INSERT OR REPLACE INTO agpeya_hours (id, name_ar, name_en, hour_order, description)
        VALUES (?, ?, ?, ?, ?)
    """, hours)

    # Clean existing sections
    cursor.execute("DELETE FROM agpeya_sections;")

    sections_batch = []
    hour_order_counters = {}

    for part_idx, hour_id, hour_desc in HOUR_PARTS_MAPPING:
        if part_idx >= len(parts):
            continue
        p_text = parts[part_idx]
        chunks = p_text.split('+++')
        
        for c in chunks:
            clines = [l.strip() for l in c.strip().splitlines() if l.strip()]
            if not clines:
                continue
            title = clines[0].lstrip('+').strip()
            # Clean title
            title = title.replace('**', '').strip()
            body = "\n".join(clines[1:]).strip()
            if not body and len(clines) == 1:
                body = title
                
            sec_type, role, ref = determine_type_and_role(title, body)
            
            curr_order = hour_order_counters.get(hour_id, 0) + 1
            hour_order_counters[hour_id] = curr_order
            
            sections_batch.append((
                hour_id,
                curr_order,
                sec_type,
                title,
                role,
                body,
                None, # text_coptic
                None, # text_phonetic
                ref
            ))

    cursor.executemany("""
        INSERT INTO agpeya_sections (hour_id, section_order, type, title, role, text_ar, text_coptic, text_phonetic, reference)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, sections_batch)

    print(f"Successfully populated {len(sections_batch)} Agpeya sections across all 8 canonical hours!")
