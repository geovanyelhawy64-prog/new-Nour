import base64
import binascii
import hashlib
import sqlite3
import zipfile
import xlrd
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend

SALT_IV = b'\x00' * 12 + b'orso'
KEY = hashlib.pbkdf2_hmac('sha1', b'1j2e3s4u5s6', SALT_IV, 100, dklen=32)

def decrypt_cell(val) -> str:
    if not isinstance(val, str) or not val.strip():
        return ''
    val = val.strip()
    try:
        raw_b64 = base64.b64decode(val)
        cipher_bytes = binascii.unhexlify(raw_b64)
        cipher = Cipher(algorithms.AES(KEY), modes.CBC(SALT_IV), backend=default_backend())
        dec = cipher.decryptor()
        b = dec.update(cipher_bytes) + dec.finalize()
        pad = b[-1]
        if 1 <= pad <= 16 and b[-pad:] == bytes([pad]) * pad:
            b = b[:-pad]
        return b.decode('utf-8', errors='ignore').strip()
    except Exception:
        return val

def _parse_xls_sheet(sheet, period_type, month, day, rite):
    readings = []
    cur_reading = None
    for r in range(sheet.nrows):
        title = decrypt_cell(sheet.cell_value(r, 1))
        ref = decrypt_cell(sheet.cell_value(r, 2))
        text = decrypt_cell(sheet.cell_value(r, 3)) if sheet.ncols > 3 else ''

        if 'ختام' in title or 'مقدمة' in title:
            continue

        if title:
            if cur_reading:
                readings.append(cur_reading)

            svc = 'liturgy'
            rtype = 'gospel'
            if 'عشية' in title:
                svc = 'vespers'
            elif 'باكر' in title:
                svc = 'matins'

            if 'مزمور' in title:
                rtype = 'psalm'
            elif 'انجيل' in title or 'إنجيل' in title:
                rtype = 'gospel'
            elif 'بولس' in title:
                rtype = 'pauline'
            elif 'كاثوليكون' in title:
                rtype = 'catholic'
            elif 'ابركسيس' in title or 'إبركسيس' in title:
                rtype = 'acts'
            elif 'نبؤة' in title or 'نبوة' in title:
                rtype = 'prophecy'

            cur_reading = (month, day, period_type, rite, svc, rtype, ref, text, None)
        else:
            if cur_reading and text:
                updated_text = cur_reading[7] + '\n\n' + text
                cur_reading = (
                    cur_reading[0], cur_reading[1], cur_reading[2],
                    cur_reading[3], cur_reading[4], cur_reading[5],
                    cur_reading[6], updated_text, cur_reading[8]
                )
    if cur_reading:
        readings.append(cur_reading)
    return readings

def import_katameros(cursor: sqlite3.Cursor, apk_zip: zipfile.ZipFile):
    print("Decrypting and populating complete Katameros (Annual, Great Lent, Pentecost, Jonah & Sundays)...")

    cursor.execute("DELETE FROM katameros_readings;")

    all_readings = []

    # 1. Annual Daily Readings (366 days)
    for m in range(1, 14):
        for d in range(1, 31):
            fname = f'assets/katamars/KatamarsAyamExcel/{m}/{d}.xls'
            if fname not in apk_zip.namelist():
                continue

            xls_bytes = apk_zip.read(fname)
            try:
                book = xlrd.open_workbook(file_contents=xls_bytes)
                rite = 'festive' if ((m == 1 and d == 1) or (m == 4 and d == 29) or (m == 5 and d == 11) or (m == 7 and d == 29)) else 'annual'
                all_readings.extend(_parse_xls_sheet(book.sheet_by_index(0), 'annual', m, d, rite))
            except Exception as e:
                print(f"Error opening {fname}: {e}")

    # 2. Great Lent (55 days)
    for d in range(1, 56):
        fn = f'assets/katamars/soomKeber/{d}.xls'
        if fn in apk_zip.namelist():
            try:
                book = xlrd.open_workbook(file_contents=apk_zip.read(fn))
                all_readings.extend(_parse_xls_sheet(book.sheet_by_index(0), 'great_lent', 0, d, 'lenten'))
            except Exception as e:
                print(f"Error opening {fn}: {e}")

    # 3. Holy Pentecost (50 days)
    for d in range(1, 51):
        fn = f'assets/katamars/Katamaras7maseen/{d}.xls'
        if fn in apk_zip.namelist():
            try:
                book = xlrd.open_workbook(file_contents=apk_zip.read(fn))
                all_readings.extend(_parse_xls_sheet(book.sheet_by_index(0), 'pentecost', 0, d, 'festive'))
            except Exception as e:
                print(f"Error opening {fn}: {e}")

    # 4. Jonah Fast (4 days)
    for d in range(1, 5):
        fn = f'assets/katamars/younan/{d}.xls'
        if fn in apk_zip.namelist():
            try:
                book = xlrd.open_workbook(file_contents=apk_zip.read(fn))
                all_readings.extend(_parse_xls_sheet(book.sheet_by_index(0), 'jonah', 0, d, 'lenten'))
            except Exception as e:
                print(f"Error opening {fn}: {e}")

    # 5. Sundays of the Year (13 months * 5 sundays)
    for m in range(1, 14):
        for s in range(1, 6):
            fn = f'assets/katamars/KatamarsA7adExcel/{m}/{s}.xls'
            if fn in apk_zip.namelist():
                try:
                    book = xlrd.open_workbook(file_contents=apk_zip.read(fn))
                    all_readings.extend(_parse_xls_sheet(book.sheet_by_index(0), 'sundays', m, s, 'annual'))
                except Exception as e:
                    print(f"Error opening {fn}: {e}")

    if all_readings:
        cursor.executemany("""
            INSERT INTO katameros_readings (
                coptic_month, coptic_day, period_type, rite,
                service_type, reading_type, reference, text, synaxarium_id
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, all_readings)

    cursor.execute("SELECT COUNT(*) FROM katameros_readings;")
    total_count = cursor.fetchone()[0]
    print(f"Successfully populated {total_count} complete Katameros readings!")
