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

def parse_day_entries(text: str, m: int, d: int):
    lines = text.split('\n')
    header = lines[0].strip() if lines else ''

    # 1. Parse index titles at the top
    titles = {}
    idx = 1
    while idx < len(lines):
        line = lines[idx].strip()
        if not line:
            idx += 1
            break
        m_title = re.match(r'^(\d+)\s*[–-]\s*(.*?)\.?$', line)
        if m_title and len(m_title.group(2)) < 160:
            titles[int(m_title.group(1))] = m_title.group(2).strip()
            idx += 1
        else:
            break

    # 2. Parse stories from remaining text
    remaining = '\n'.join(lines[idx:]).strip()
    story_chunks = re.split(r'\n(?=\d+\s*[–-])', remaining)
    stories = {}
    for chunk in story_chunks:
        chunk = chunk.strip()
        m_story = re.match(r'^(\d+)\s*[–-]\s*(.*)', chunk, re.DOTALL)
        if m_story:
            num = int(m_story.group(1))
            body = m_story.group(2).strip()
            stories[num] = body
        elif chunk and not stories:
            stories[1] = chunk

    all_nums = sorted(set(list(titles.keys()) + list(stories.keys())))
    if not all_nums:
        return [(f'synax_{m:02d}_{d:02d}_01', m, d, 1, header, 'event', header, remaining or header)]

    entries = []
    for order, num in enumerate(all_nums, start=1):
        title = titles.get(num, '')
        story = stories.get(num, '')
        if not title and story:
            title = story.split('\n')[0].strip()[:100]
        if not story and title:
            story = title

        # Type classification
        t_clean = title.strip()
        if any(w in t_clean for w in ['عيد', 'بشارة', 'ميلاد', 'قيامة', 'صعود', 'غطاس', 'دخول', 'نيروز']):
            etype = 'feast'
        elif any(w in t_clean for w in ['استشهاد', 'شهيد', 'شهداء', 'شهيدة']):
            etype = 'martyr'
        elif any(w in t_clean for w in ['بطريرك', 'بابا', 'كرسي']):
            etype = 'patriarch'
        elif any(w in t_clean for w in ['أنبا', 'أسقف', 'مطران']):
            etype = 'bishop'
        elif any(w in t_clean for w in ['راهب', 'متوحد', 'دير', 'أب']):
            etype = 'monk'
        elif any(w in t_clean for w in ['تذكار', 'تكريس', 'نقل', 'معجزة', 'بناء', 'شفاء']):
            etype = 'event'
        else:
            etype = 'saint'

        # Short summary
        first_para = story.split('\n')[0].strip()
        short = first_para[:250] if len(first_para) > 30 else (title + ' - ' + first_para)

        entries.append((
            f'synax_{m:02d}_{d:02d}_{order:02d}',
            m, d, order,
            title, etype, short, story
        ))
    return entries

def import_synaxarium(cursor: sqlite3.Cursor, apk_zip: zipfile.ZipFile):
    print("Decrypting and populating complete Coptic Synaxarium (all 13 Coptic months)...")

    cursor.execute("DELETE FROM synaxarium_entries;")

    all_entries = []
    days_processed = 0

    # Months 1 to 13 (Thout to Nasie)
    for m in range(1, 14):
        max_days = 30 if m <= 12 else 6
        for d in range(1, 31):
            fname = f'assets/sanksar2/{m}/{m:02d} ({d}).orso'
            if fname in apk_zip.namelist():
                days_processed += 1
                raw_bytes = apk_zip.read(fname)
                decrypted_text = decrypt_orso(raw_bytes)
                entries = parse_day_entries(decrypted_text, m, d)
                all_entries.extend(entries)

    cursor.executemany("""
        INSERT INTO synaxarium_entries (id, coptic_month, coptic_day, entry_order, title, type, short_text, full_text)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """, all_entries)

    print(f"Successfully populated {len(all_entries)} Synaxarium entries across {days_processed} days (Months 1-13)!")
