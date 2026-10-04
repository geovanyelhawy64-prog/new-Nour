import zipfile, io, re, sqlite3, xlrd, base64
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

IV = b"\x00" * 12 + b"orso"
PASSWORD = b"1j2e3s4u5s6"

def get_cipher_key():
    kdf = PBKDF2HMAC(algorithm=hashes.SHA1(), length=32, salt=IV, iterations=100)
    return kdf.derive(PASSWORD)

KEY = get_cipher_key()

def unpad(b):
    pad = b[-1]
    return b[:-pad] if 1 <= pad <= 16 and b[-pad:] == bytes([pad]) * pad else b

def decrypt_val(val):
    if not isinstance(val, str) or not val.strip():
        return ''
    try:
        ct = bytes.fromhex(base64.b64decode(val.strip()).decode('ascii'))
        dec = Cipher(algorithms.AES(KEY), modes.CBC(IV)).decryptor()
        d = dec.update(ct) + dec.finalize()
        return unpad(d).decode('utf-8', errors='replace').strip()
    except Exception:
        return val.strip()

def parse_xls_parts(apk_zip: zipfile.ZipFile, zip_path: str):
    if zip_path not in apk_zip.namelist():
        return "", []
    try:
        wb = xlrd.open_workbook(file_contents=apk_zip.read(zip_path))
        s = wb.sheet_by_index(0)
    except Exception:
        return "", []

    title = decrypt_val(s.cell_value(0, 1)) if s.ncols > 1 else ""
    parts = []
    for r in range(1, s.nrows):
        rubric = decrypt_val(s.cell_value(r, 2)) if s.ncols > 2 else ""
        text_ar = decrypt_val(s.cell_value(r, 3)) if s.ncols > 3 else ""
        text_phonetic = decrypt_val(s.cell_value(r, 4)) if s.ncols > 4 else ""
        text_coptic = decrypt_val(s.cell_value(r, 5)) if s.ncols > 5 else ""
        role_en = decrypt_val(s.cell_value(r, 10)) if s.ncols > 10 else ""
        
        if not text_ar and not text_coptic and not rubric:
            continue
            
        r_lower = role_en.lower()
        rubric_lower = rubric.lower()
        if 'priest' in r_lower or 'كاهن' in rubric_lower:
            role = 'priest'
        elif 'deacon' in r_lower or 'شماس' in rubric_lower:
            role = 'deacon'
        elif 'people' in r_lower or 'شعب' in rubric_lower:
            role = 'people'
        elif 'سر' in rubric_lower or 'سراً' in rubric_lower:
            role = 'priest'
        else:
            role = 'all'
            
        is_secret = 1 if ('سر' in rubric_lower or 'سراً' in rubric_lower or 'حجاب' in rubric_lower) else 0
        part_type = 'response' if role in ('deacon', 'people') else ('rubric' if not text_ar and rubric else 'prayer')
        
        parts.append({
            'role': role,
            'type': part_type,
            'text_ar': text_ar or rubric,
            'text_coptic': text_coptic or None,
            'text_phonetic': text_phonetic or None,
            'rubric': rubric or None,
            'is_secret': is_secret
        })
    return title, parts

def import_liturgies(cursor: sqlite3.Cursor, apk_zip: zipfile.ZipFile):
    print("Populating Holy Liturgies (St. Basil, St. Gregory, St. Cyril, Raising of Incense)...")
    
    # 1. Seed liturgies table
    liturgies_data = [
        ('raising_incense', 'رفع بخور عشية وباكر', 'Raising of Incense', 1),
        ('basil', 'القداس الباسيلي', 'Liturgy of St. Basil', 2),
        ('gregory', 'القداس الغريغوري', 'Liturgy of St. Gregory', 3),
        ('cyril', 'القداس الكيرلسي', 'Liturgy of St. Cyril', 4),
    ]
    cursor.executemany("""
        INSERT OR REPLACE INTO liturgies (id, name_ar, name_en, liturgy_order)
        VALUES (?, ?, ?, ?)
    """, liturgies_data)

    cursor.execute("DELETE FROM liturgy_parts;")
    cursor.execute("DELETE FROM liturgy_sections;")

    total_sections_count = 0
    total_parts_count = 0

    # 2. Basil Liturgy
    print("Extracting St. Basil Liturgy...")
    basil_index_path = 'assets/kholagy/basily_sanawy_sun_1.xls'
    if basil_index_path in apk_zip.namelist():
        wb = xlrd.open_workbook(file_contents=apk_zip.read(basil_index_path))
        s = wb.sheet_by_index(0)
        for r in range(s.nrows):
            f_num = decrypt_val(s.cell_value(r, 0)).replace('.0', '')
            sec_name = decrypt_val(s.cell_value(r, 1))
            
            # Locate file in basely/ or normal/
            path = f"assets/kholagy/basely/{f_num}.xls"
            if path not in apk_zip.namelist():
                path = f"assets/kholagy/normal/{f_num}.xls"
                
            if path in apk_zip.namelist():
                t, parts = parse_xls_parts(apk_zip, path)
                sec_id = f"basil_sec_{r+1:03d}_{f_num}"
                final_name = sec_name or t or f"قسم {r+1}"
                
                cursor.execute("""
                    INSERT INTO liturgy_sections (id, liturgy_id, name_ar, section_order)
                    VALUES (?, ?, ?, ?)
                """, (sec_id, 'basil', final_name, r + 1))
                total_sections_count += 1
                
                parts_batch = []
                for p_idx, p in enumerate(parts):
                    parts_batch.append((
                        sec_id,
                        p_idx + 1,
                        p['role'],
                        p['type'],
                        p['text_ar'],
                        p['text_coptic'],
                        p['text_phonetic'],
                        p['rubric'],
                        p['is_secret']
                    ))
                if parts_batch:
                    cursor.executemany("""
                        INSERT INTO liturgy_parts (section_id, part_order, role, type, text_ar, text_coptic, text_phonetic, rubric, is_secret)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """, parts_batch)
                    total_parts_count += len(parts_batch)

    # 3. Gregory Liturgy
    print("Extracting St. Gregory Liturgy...")
    greg_index_path = 'assets/kholagy/gergory_sanawy_sun_1.xls'
    if greg_index_path in apk_zip.namelist():
        wb = xlrd.open_workbook(file_contents=apk_zip.read(greg_index_path))
        s = wb.sheet_by_index(0)
        for r in range(s.nrows):
            f_num = decrypt_val(s.cell_value(r, 0)).replace('.0', '')
            sec_name = decrypt_val(s.cell_value(r, 1))
            
            path = f"assets/kholagy/gergory/{f_num}.xls"
            if path not in apk_zip.namelist():
                path = f"assets/kholagy/normal/{f_num}.xls"
                
            if path in apk_zip.namelist():
                t, parts = parse_xls_parts(apk_zip, path)
                sec_id = f"gregory_sec_{r+1:03d}_{f_num}"
                final_name = sec_name or t or f"قسم {r+1}"
                
                cursor.execute("""
                    INSERT INTO liturgy_sections (id, liturgy_id, name_ar, section_order)
                    VALUES (?, ?, ?, ?)
                """, (sec_id, 'gregory', final_name, r + 1))
                total_sections_count += 1
                
                parts_batch = []
                for p_idx, p in enumerate(parts):
                    parts_batch.append((
                        sec_id,
                        p_idx + 1,
                        p['role'],
                        p['type'],
                        p['text_ar'],
                        p['text_coptic'],
                        p['text_phonetic'],
                        p['rubric'],
                        p['is_secret']
                    ))
                if parts_batch:
                    cursor.executemany("""
                        INSERT INTO liturgy_parts (section_id, part_order, role, type, text_ar, text_coptic, text_phonetic, rubric, is_secret)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """, parts_batch)
                    total_parts_count += len(parts_batch)

    # 4. Raising of Incense (رفع بخور)
    print("Extracting Raising of Incense...")
    baker_sequence = [
        ('1000', 'صلاة الشكر وبخور باكر'),
        ('1019', 'أوشية المياه'),
        ('1020', 'أوشية الزروع'),
        ('1021', 'أوشية الأهوية والثمار'),
        ('1022', 'اصعدها كمقدارها'),
        ('1030', 'الذكصولوجيات'),
        ('1032', 'أبانا الذي في السماوات'),
        ('1033', 'تسبحة الملائكة'),
        ('1034', 'الثلاث تقديسات'),
    ]
    for r, (f_num, sec_name) in enumerate(baker_sequence):
        path = f"assets/kholagy/baker/{f_num}.xls"
        if path in apk_zip.namelist():
            t, parts = parse_xls_parts(apk_zip, path)
            sec_id = f"incense_sec_{r+1:03d}_{f_num}"
            cursor.execute("""
                INSERT INTO liturgy_sections (id, liturgy_id, name_ar, section_order)
                VALUES (?, ?, ?, ?)
            """, (sec_id, 'raising_incense', sec_name or t, r + 1))
            total_sections_count += 1
            
            parts_batch = []
            for p_idx, p in enumerate(parts):
                parts_batch.append((
                    sec_id,
                    p_idx + 1,
                    p['role'],
                    p['type'],
                    p['text_ar'],
                    p['text_coptic'],
                    p['text_phonetic'],
                    p['rubric'],
                    p['is_secret']
                ))
            if parts_batch:
                cursor.executemany("""
                    INSERT INTO liturgy_parts (section_id, part_order, role, type, text_ar, text_coptic, text_phonetic, rubric, is_secret)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """, parts_batch)
                total_parts_count += len(parts_batch)

    # 5. Cyril Liturgy (قداس القديس كيرلس)
    print("Extracting St. Cyril Liturgy...")
    cyril_sequence = [
        ('945', 'صلاة الحجاب للقداس الكيرلسي'),
        ('912', 'تحليل الخدام ناظر الإله مرقس'),
        ('914', 'تي شوري (المبخرة الذهب)'),
        ('917', 'الهيتنيات (سؤالات القديسين)'),
        ('920', 'بي أهموت غار'),
        ('927', 'أوشية القرابين الكيرلسية'),
        ('934', 'أجيوس (الثلاث تقديسات)'),
        ('935', 'أوشية الإنجيل'),
        ('946', 'أوشية السلام الكيرلسية'),
        ('947', 'أوشية الآباء الكيرلسية'),
        ('948', 'أوشية الاجتماعات'),
        ('950', 'قانون الإيمان الأرثوذكسي'),
        ('954', 'أللي القربان والاعتراف الأخير'),
    ]
    for r, (f_num, sec_name) in enumerate(cyril_sequence):
        path = f"assets/kholagy/normal/{f_num}.xls"
        if path in apk_zip.namelist():
            t, parts = parse_xls_parts(apk_zip, path)
            sec_id = f"cyril_sec_{r+1:03d}_{f_num}"
            cursor.execute("""
                INSERT INTO liturgy_sections (id, liturgy_id, name_ar, section_order)
                VALUES (?, ?, ?, ?)
            """, (sec_id, 'cyril', sec_name or t, r + 1))
            total_sections_count += 1
            
            parts_batch = []
            for p_idx, p in enumerate(parts):
                parts_batch.append((
                    sec_id,
                    p_idx + 1,
                    p['role'],
                    p['type'],
                    p['text_ar'],
                    p['text_coptic'],
                    p['text_phonetic'],
                    p['rubric'],
                    p['is_secret']
                ))
            if parts_batch:
                cursor.executemany("""
                    INSERT INTO liturgy_parts (section_id, part_order, role, type, text_ar, text_coptic, text_phonetic, rubric, is_secret)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """, parts_batch)
                total_parts_count += len(parts_batch)

    print(f"Successfully populated {total_sections_count} liturgy sections and {total_parts_count} liturgy parts across all 4 Liturgies!")
