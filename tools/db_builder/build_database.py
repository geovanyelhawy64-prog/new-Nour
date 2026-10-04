import os
import re
import sqlite3
import zipfile
import io
import sys

# Ensure importers directory is in python path
sys.path.insert(0, os.path.dirname(__file__))
from importers.agpeya_importer import import_agpeya
from importers.liturgy_importer import import_liturgies
from importers.hymns_importer import import_hymns
from importers.synaxarium_importer import import_synaxarium
from importers.katameros_importer import import_katameros
from importers.pascha_importer import import_pascha
from importers.feasts_importer import import_feasts
from importers.prayers_importer import import_prayers
from importers.sacraments_importer import import_sacraments
from importers.saints_importer import import_saints
from importers.difnar_importer import import_difnar
from importers.theology_importer import import_theology

DB_PATH = os.path.join(os.path.dirname(__file__), "..", "..", "assets", "databases", "noor.db")
ZIP_CONTAINER = os.path.join(os.path.dirname(__file__), "..", "..", "كتب دينية", "Katamars+++Orsozoxi_13.7.0_APKPure.zip")

# Tashkeel removal regex
TASHKEEL_REGEX = re.compile(r'[\u064B-\u065F\u0670\u0640]')

def normalize_arabic(text: str) -> str:
    # 1. Remove tashkeel and tatweel
    s = TASHKEEL_REGEX.sub('', text)
    # 2. Normalize alef variants
    s = re.sub(r'[إأآٱ]', 'ا', s)
    # 3. Normalize ya and alif maqsura
    s = s.replace('ى', 'ي')
    # 4. Normalize ta marbuta
    s = s.replace('ة', 'ه')
    # 5. Normalize hamza variants
    s = s.replace('ؤ', 'و').replace('ئ', 'ي')
    return s.strip()

# Complete Canonical 73 Books metadata
# (book_order, folder_name, name_ar, name_en, testament, testament_ar, category, category_ar, chapter_count)
BOOKS_METADATA = [
    # Old Testament (Law / Pentateuch)
    (1, "01-Takwen", "التكوين", "Genesis", "old", "العهد القديم", "law", "التوراة", 50),
    (2, "02-Khrog", "الخروج", "Exodus", "old", "العهد القديم", "law", "التوراة", 40),
    (3, "03-Laween", "اللاويين", "Leviticus", "old", "العهد القديم", "law", "التوراة", 27),
    (4, "04-Addad", "العدد", "Numbers", "old", "العهد القديم", "law", "التوراة", 36),
    (5, "05-Tasnya", "التثنية", "Deuteronomy", "old", "العهد القديم", "law", "التوراة", 34),
    # History
    (6, "06-Yasho3", "يشوع", "Joshua", "old", "العهد القديم", "history", "الأسفار التاريخية", 24),
    (7, "07-Kodah", "القضاة", "Judges", "old", "العهد القديم", "history", "الأسفار التاريخية", 21),
    (8, "08-Ra3os", "راعوث", "Ruth", "old", "العهد القديم", "history", "الأسفار التاريخية", 4),
    (9, "09-Samuel1", "صموئيل الأول", "1 Samuel", "old", "العهد القديم", "history", "الأسفار التاريخية", 31),
    (10, "10-Samuel2", "صموئيل الثاني", "2 Samuel", "old", "العهد القديم", "history", "الأسفار التاريخية", 24),
    (11, "11-Mlokk1", "الملوك الأول", "1 Kings", "old", "العهد القديم", "history", "الأسفار التاريخية", 22),
    (12, "12-Mlokk2", "الملوك الثاني", "2 Kings", "old", "العهد القديم", "history", "الأسفار التاريخية", 25),
    (13, "13-AkhbarAyam1", "أخبار الأيام الأول", "1 Chronicles", "old", "العهد القديم", "history", "الأسفار التاريخية", 29),
    (14, "14-AkhbarAyam2", "أخبار الأيام الثاني", "2 Chronicles", "old", "العهد القديم", "history", "الأسفار التاريخية", 36),
    (15, "15-Ezra", "عزرا", "Ezra", "old", "العهد القديم", "history", "الأسفار التاريخية", 10),
    (16, "16-Na7amya", "نحميا", "Nehemiah", "old", "العهد القديم", "history", "الأسفار التاريخية", 13),
    # Deuterocanonical 1
    (17, "17-Tobya", "طوبيا", "Tobit", "deutero", "الأسفار القانونية الثانية", "deutero", "الأسفار القانونية الثانية", 14),
    (18, "18-Yahodet", "يهوديت", "Judith", "deutero", "الأسفار القانونية الثانية", "deutero", "الأسفار القانونية الثانية", 16),
    (19, "19-Aster", "أستير", "Esther", "old", "العهد القديم", "history", "الأسفار التاريخية", 16),
    # Poetry & Wisdom
    (20, "20-Ayob", "أيوب", "Job", "old", "العهد القديم", "poetry", "الأسفار الشعرية والتعليمية", 42),
    (21, "21-Psalms", "المزامير", "Psalms", "old", "العهد القديم", "poetry", "الأسفار الشعرية والتعليمية", 151),
    (22, "22-Amsal", "الأمثال", "Proverbs", "old", "العهد القديم", "poetry", "الأسفار الشعرية والتعليمية", 31),
    (23, "23-Gam3a", "الجامعة", "Ecclesiastes", "old", "العهد القديم", "poetry", "الأسفار الشعرية والتعليمية", 12),
    (24, "24-NashedElAnshad", "نشيد الأنشاد", "Song of Solomon", "old", "العهد القديم", "poetry", "الأسفار الشعرية والتعليمية", 8),
    # Deuterocanonical 2
    (25, "25-7ekma", "حكمة سليمان", "Wisdom of Solomon", "deutero", "الأسفار القانونية الثانية", "deutero", "الأسفار القانونية الثانية", 19),
    (26, "26-Yasho3EbnSira5", "يشوع بن سيراخ", "Sirach", "deutero", "الأسفار القانونية الثانية", "deutero", "الأسفار القانونية الثانية", 51),
    # Major Prophets
    (27, "27-Ash3ya", "إشعياء", "Isaiah", "old", "العهد القديم", "major_prophets", "الأنبياء الكبار", 66),
    (28, "28-Armya", "أرميا", "Jeremiah", "old", "العهد القديم", "major_prophets", "الأنبياء الكبار", 52),
    (29, "29-MarasyArmya", "مراثي أرميا", "Lamentations", "old", "العهد القديم", "major_prophets", "الأنبياء الكبار", 5),
    (30, "30-Baroo5", "باروخ", "Baruch", "deutero", "الأسفار القانونية الثانية", "deutero", "الأسفار القانونية الثانية", 6),
    (31, "31-Ezkial", "حزقيال", "Ezekiel", "old", "العهد القديم", "major_prophets", "الأنبياء الكبار", 48),
    (32, "32-Daniel", "دانيال", "Daniel", "old", "العهد القديم", "major_prophets", "الأنبياء الكبار", 14),
    # Minor Prophets
    (33, "33-Hosa3", "هوشع", "Hosea", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 14),
    (34, "34-Uoyel", "يوئيل", "Joel", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 3),
    (35, "35-Amous", "عاموس", "Amos", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 9),
    (36, "36-Obadiah", "عوبديا", "Obadiah", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 1),
    (37, "37-Younan", "يونان", "Jonah", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 4),
    (38, "38-Mikha", "ميخا", "Micah", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 7),
    (39, "39-Na7oum", "ناحوم", "Nahum", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 3),
    (40, "40-Habakouk", "حبقوق", "Habakkuk", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 3),
    (41, "41-Saphnia", "صفنيا", "Zephaniah", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 3),
    (42, "42-Heggi", "حجي", "Haggai", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 2),
    (43, "43-Zakaria", "زكريا", "Zechariah", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 14),
    (44, "44-Malakhy", "ملاخي", "Malachi", "old", "العهد القديم", "minor_prophets", "الأنبياء الصغار", 4),
    # Deuterocanonical 3
    (45, "45-Makabyeen1", "المكابيين الأول", "1 Maccabees", "deutero", "الأسفار القانونية الثانية", "deutero", "الأسفار القانونية الثانية", 16),
    (46, "46-Makabyeen2", "المكابيين الثاني", "2 Maccabees", "deutero", "الأسفار القانونية الثانية", "deutero", "الأسفار القانونية الثانية", 15),
    # New Testament (Gospels)
    (47, "47-Matta", "إنجيل متى", "Matthew", "new", "العهد الجديد", "gospels", "الأناجيل الأربعة", 28),
    (48, "48-Morkos", "إنجيل مرقس", "Mark", "new", "العهد الجديد", "gospels", "الأناجيل الأربعة", 16),
    (49, "49-Loka", "إنجيل لوقا", "Luke", "new", "العهد الجديد", "gospels", "الأناجيل الأربعة", 24),
    (50, "50-Yo7ana", "إنجيل يوحنا", "John", "new", "العهد الجديد", "gospels", "الأناجيل الأربعة", 21),
    # Acts
    (51, "51-A3mal", "أعمال الرسل", "Acts", "new", "العهد الجديد", "acts", "أعمال الرسل", 28),
    # Pauline Epistles
    (52, "52-Romia", "رومية", "Romans", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 16),
    (53, "53-Koronsos1", "كورنثوس الأولى", "1 Corinthians", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 16),
    (54, "54-Koronsos2", "كورنثوس الثانية", "2 Corinthians", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 13),
    (55, "55-Ghalatia", "غلاطية", "Galatians", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 6),
    (56, "56-Afasos", "أفسس", "Ephesians", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 6),
    (57, "57-Philipy", "فيلبي", "Philippians", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 4),
    (58, "58-Kolosy", "كولوسي", "Colossians", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 4),
    (59, "59-Tsaloneky1", "تسالونيكي الأولى", "1 Thessalonians", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 5),
    (60, "60-Tsaloneky2", "تسالونيكي الثانية", "2 Thessalonians", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 3),
    (61, "61-Timosawes1", "تيموثاوس الأولى", "1 Timothy", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 6),
    (62, "62-Timosawes2", "تيموثاوس الثانية", "2 Timothy", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 4),
    (63, "63-Titues", "تيطس", "Titus", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 3),
    (64, "64-Philimon", "فليمون", "Philemon", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 1),
    (65, "65-Abranyen", "العبرانيين", "Hebrews", "new", "العهد الجديد", "pauline", "رسائل بولس الرسول", 13),
    # Catholic Epistles
    (66, "66-Yaquob", "يعقوب", "James", "new", "العهد الجديد", "catholic", "الرسائل الجامعة", 5),
    (67, "67-Botros1", "بطرس الأولى", "1 Peter", "new", "العهد الجديد", "catholic", "الرسائل الجامعة", 5),
    (68, "68-Botros2", "بطرس الثانية", "2 Peter", "new", "العهد الجديد", "catholic", "الرسائل الجامعة", 3),
    (69, "69-You7ana1", "يوحنا الأولى", "1 John", "new", "العهد الجديد", "catholic", "الرسائل الجامعة", 5),
    (70, "70-You7ana2", "يوحنا الثانية", "2 John", "new", "العهد الجديد", "catholic", "الرسائل الجامعة", 1),
    (71, "71-You7ana3", "يوحنا الثالثة", "3 John", "new", "العهد الجديد", "catholic", "الرسائل الجامعة", 1),
    (72, "72-Yahouza", "يهوذا", "Jude", "new", "العهد الجديد", "catholic", "الرسائل الجامعة", 1),
    # Revelation
    (73, "73-RoyaYou7ana", "رؤيا يوحنا", "Revelation", "new", "العهد الجديد", "revelation", "سفر الرؤيا", 22),
]

def create_schema(cursor: sqlite3.Cursor):
    print("Creating tables matching Drift schema...")
    
    # 1. Bible Books
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS bible_books (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name_ar TEXT NOT NULL,
        name_en TEXT NOT NULL,
        name_coptic TEXT,
        testament TEXT NOT NULL,
        testament_ar TEXT NOT NULL,
        category TEXT NOT NULL,
        category_ar TEXT NOT NULL,
        book_order INTEGER NOT NULL,
        chapter_count INTEGER NOT NULL
    );
    """)

    # 2. Bible Verses
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS bible_verses (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        book_id INTEGER NOT NULL REFERENCES bible_books (id),
        chapter INTEGER NOT NULL,
        verse_number INTEGER NOT NULL,
        text TEXT NOT NULL,
        text_with_tashkeel TEXT,
        UNIQUE (book_id, chapter, verse_number)
    );
    """)

    # 3. Agpeya Hours
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS agpeya_hours (
        id TEXT PRIMARY KEY NOT NULL,
        name_ar TEXT NOT NULL,
        name_en TEXT NOT NULL,
        hour_order INTEGER NOT NULL,
        description TEXT
    );
    """)

    # 4. Agpeya Sections
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS agpeya_sections (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        hour_id TEXT NOT NULL REFERENCES agpeya_hours (id),
        section_order INTEGER NOT NULL,
        type TEXT NOT NULL,
        title TEXT NOT NULL,
        role TEXT NOT NULL,
        text_ar TEXT NOT NULL,
        text_coptic TEXT,
        text_phonetic TEXT,
        reference TEXT
    );
    """)

    # 5. Liturgies
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS liturgies (
        id TEXT PRIMARY KEY NOT NULL,
        name_ar TEXT NOT NULL,
        name_en TEXT NOT NULL,
        liturgy_order INTEGER NOT NULL
    );
    """)

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS liturgy_sections (
        id TEXT PRIMARY KEY NOT NULL,
        liturgy_id TEXT NOT NULL REFERENCES liturgies (id),
        name_ar TEXT NOT NULL,
        section_order INTEGER NOT NULL
    );
    """)

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS liturgy_parts (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        section_id TEXT NOT NULL REFERENCES liturgy_sections (id),
        part_order INTEGER NOT NULL,
        role TEXT NOT NULL,
        type TEXT NOT NULL,
        text_ar TEXT NOT NULL,
        text_coptic TEXT,
        text_phonetic TEXT,
        rubric TEXT,
        is_secret INTEGER NOT NULL DEFAULT 0
    );
    """)

    # 6. Hymns
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS hymn_books (
        id TEXT PRIMARY KEY NOT NULL,
        name_ar TEXT NOT NULL,
        book_order INTEGER NOT NULL
    );
    """)

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS hymns (
        id TEXT PRIMARY KEY NOT NULL,
        book_id TEXT NOT NULL REFERENCES hymn_books (id),
        name_ar TEXT NOT NULL,
        name_coptic TEXT,
        occasion TEXT NOT NULL,
        tone TEXT NOT NULL,
        hymn_order INTEGER NOT NULL
    );
    """)

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS hymn_segments (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        hymn_id TEXT NOT NULL REFERENCES hymns (id),
        segment_order INTEGER NOT NULL,
        line_number INTEGER NOT NULL,
        coptic TEXT NOT NULL,
        phonetic TEXT NOT NULL,
        arabic TEXT NOT NULL,
        syllables_json TEXT
    );
    """)

    # 7. Synaxarium
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS synaxarium_entries (
        id TEXT PRIMARY KEY NOT NULL,
        coptic_month INTEGER NOT NULL,
        coptic_day INTEGER NOT NULL,
        entry_order INTEGER NOT NULL,
        title TEXT NOT NULL,
        type TEXT NOT NULL,
        short_text TEXT NOT NULL,
        full_text TEXT NOT NULL
    );
    """)

    # 8. Katameros
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS katameros_readings (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        coptic_month INTEGER NOT NULL,
        coptic_day INTEGER NOT NULL,
        period_type TEXT NOT NULL,
        rite TEXT NOT NULL,
        service_type TEXT NOT NULL,
        reading_type TEXT NOT NULL,
        reference TEXT NOT NULL,
        text TEXT NOT NULL,
        synaxarium_id TEXT
    );
    """)

    # 9. Saints
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS saints (
        id TEXT PRIMARY KEY NOT NULL,
        name_ar TEXT NOT NULL,
        name_coptic TEXT,
        name_en TEXT,
        type TEXT NOT NULL,
        feast_month INTEGER,
        feast_day INTEGER,
        biography TEXT NOT NULL,
        short_bio TEXT NOT NULL
    );
    """)

    # 10. Difnar
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS difnar_entries (
        id TEXT PRIMARY KEY NOT NULL,
        coptic_month INTEGER NOT NULL,
        coptic_day INTEGER NOT NULL,
        text_coptic TEXT NOT NULL,
        text_phonetic TEXT NOT NULL,
        text_ar TEXT NOT NULL
    );
    """)

    # 11. Pascha
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS pascha_readings (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        day_id TEXT NOT NULL,
        day_name_ar TEXT NOT NULL,
        hour_number INTEGER NOT NULL,
        hour_name_ar TEXT NOT NULL,
        reading_type TEXT NOT NULL,
        reference TEXT,
        text TEXT NOT NULL,
        reading_order INTEGER NOT NULL
    );
    """)

    # 12. Feasts and Fasts
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS feasts_and_fasts (
        id TEXT PRIMARY KEY NOT NULL,
        name_ar TEXT NOT NULL,
        type TEXT NOT NULL,
        coptic_month INTEGER,
        coptic_day INTEGER,
        is_movable INTEGER NOT NULL DEFAULT 0,
        calculation_rule TEXT,
        rite TEXT NOT NULL,
        description TEXT NOT NULL,
        duration_days INTEGER
    );
    """)

    # 13. Occasional Prayers
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS occasional_prayers (
        id TEXT PRIMARY KEY NOT NULL,
        category TEXT NOT NULL,
        category_ar TEXT NOT NULL,
        title TEXT NOT NULL,
        text TEXT NOT NULL,
        prayer_order INTEGER NOT NULL
    );
    """)

    # 14. Theology Articles
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS theology_articles (
        id TEXT PRIMARY KEY NOT NULL,
        category TEXT NOT NULL,
        category_ar TEXT NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        article_order INTEGER NOT NULL
    );
    """)

    # 15. Daily Verses
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS daily_verses (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        day_of_year INTEGER NOT NULL,
        reference TEXT NOT NULL,
        text TEXT NOT NULL
    );
    """)

    # 16. Bookmarks
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS bookmarks (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        content_type TEXT NOT NULL,
        content_id TEXT NOT NULL,
        display_title TEXT NOT NULL,
        note TEXT,
        created_at INTEGER NOT NULL
    );
    """)

    # 17. Sacraments
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS sacraments (
        id TEXT PRIMARY KEY NOT NULL,
        name_ar TEXT NOT NULL,
        sacrament_order INTEGER NOT NULL
    );
    """)

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS sacrament_sections (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        sacrament_id TEXT NOT NULL REFERENCES sacraments (id),
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        scriptures TEXT,
        section_order INTEGER NOT NULL
    );
    """)

    # Indexes
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_bible_verses_book_chap ON bible_verses (book_id, chapter);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_agpeya_sections_hour ON agpeya_sections (hour_id, section_order);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_katameros_date ON katameros_readings (coptic_month, coptic_day);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_synaxarium_date ON synaxarium_entries (coptic_month, coptic_day);")

def seed_bible(cursor: sqlite3.Cursor, apk_zip: zipfile.ZipFile):
    print("Extracting and populating Holy Bible...")
    
    # Pre-map all files in APK
    entry_names = set(apk_zip.namelist())
    
    verse_insert_batch = []
    total_verses = 0

    for book_meta in BOOKS_METADATA:
        order, folder, name_ar, name_en, testament, test_ar, cat, cat_ar, chap_count = book_meta
        
        # Insert book
        cursor.execute("""
            INSERT INTO bible_books (id, name_ar, name_en, testament, testament_ar, category, category_ar, book_order, chapter_count)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (order, name_ar, name_en, testament, test_ar, cat, cat_ar, order, chap_count))
        
        book_id = order
        is_old = (order <= 46)
        prefix = f"assets/mybible/old/{folder}" if is_old else f"assets/mybible/new/{folder}"
        
        for ch in range(1, chap_count + 1):
            path = f"{prefix}/{ch}.txt"
            if path not in entry_names:
                continue
                
            with apk_zip.open(path) as f:
                content = f.read().decode('utf-8-sig', errors='ignore')
                lines = content.splitlines()
                
                for line in lines:
                    line = line.strip().lstrip('\ufeff')
                    if not line:
                        continue
                        
                    # Verse format: "<number> <verse_text>"
                    parts = line.split(' ', 1)
                    if not parts or not parts[0].isdigit():
                        continue
                        
                    v_num = int(parts[0])
                    v_text_tashkeel = parts[1].strip() if len(parts) > 1 else ""
                    v_text_clean = normalize_arabic(v_text_tashkeel)
                    
                    verse_insert_batch.append((
                        book_id, ch, v_num, v_text_clean, v_text_tashkeel
                    ))
                    total_verses += 1
                    
                    if len(verse_insert_batch) >= 2000:
                        cursor.executemany("""
                            INSERT INTO bible_verses (book_id, chapter, verse_number, text, text_with_tashkeel)
                            VALUES (?, ?, ?, ?, ?)
                        """, verse_insert_batch)
                        verse_insert_batch = []

    if verse_insert_batch:
        cursor.executemany("""
            INSERT INTO bible_verses (book_id, chapter, verse_number, text, text_with_tashkeel)
            VALUES (?, ?, ?, ?, ?)
        """, verse_insert_batch)

    print(f"Successfully populated {len(BOOKS_METADATA)} books and {total_verses} verses!")

def seed_agpeya(cursor: sqlite3.Cursor):
    print("Seeding canonical Agpeya prayers...")
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
        INSERT INTO agpeya_hours (id, name_ar, name_en, hour_order, description)
        VALUES (?, ?, ?, ?, ?)
    """, hours)

    # Sample canonical prayers for Prime
    prime_sections = [
        ('prime', 1, 'introduction', 'مقدمة كل ساعة', 'all', 'باسم الآب والابن والروح القدس، الإله الواحد. آمين. يا رب ارحم، يا رب ارحم، يا رب بارك. آمين. المجد للآب والابن والروح القدس الآن وكل أوان وإلى دهر الدهور. آمين. اللهم اجعلنا مستحقين أن نقول بشكر: أبانا الذي في السماوات...', None, None, None),
        ('prime', 2, 'thanksgiving', 'صلاة الشكر', 'priest', 'فلنشكر صانع الخيرات الرحوم الله، أبا ربنا وإلهنا ومخلصنا يسوع المسيح، لأنه سترنا، وأعاننا، وحفظنا، وقبلنا إليه، وأشفق علينا، وعضدنا، وأتى بنا إلى هذه الساعة...', None, None, None),
        ('prime', 3, 'psalm', 'المزمور الخمسون', 'all', 'ارحمني يا الله كعظيم رحمتك، ومثل كثرة رأفتك امح إثمي. اغسلني كثيراً من إثمي، ومن خطيتي طهرني...', None, None, 'مز ٥٠'),
        ('prime', 4, 'gospel', 'إنجيل باكر', 'all', 'من إنجيل ربنا يسوع المسيح للقديس يوحنا (١ : ١ - ١٧): في البدء كان الكلمة، والكلمة كان عند الله، وكان الكلمة الله. هذا كان في البدء عند الله. كل شيء به كان، وبغيره لم يكن شيء مما كان. فيه كانت الحياة، والحياة كانت نور الناس...', None, None, 'يو ١ : ١-١٧'),
        ('prime', 5, 'litanies', 'قطع صلاة باكر', 'people', 'أيها النور الحقيقي الذي يضيء لكل إنسان آت إلى العالم، أتيت إلى العالم بمحبتك للبشر، وكل الخليقة تهللت بمجيئك. خلصت أبانا آدم من الغواية، وأعتقت أمنا حواء من طلقات الموت، وأعطيتنا روح البنوة، فنسبحك ونباركك قائلين: ذوكصابتري كيه إيو كيه أجييو بنيفماتي...', None, None, None),
        ('prime', 6, 'absolution', 'تحليل باكر', 'priest', 'أيها الرب الإله، ضابط الكل، أبو ربنا وإلهنا ومخلصنا يسوع المسيح، نشكرك لأنك أقمتنا من نوم الليل ووهبتنا نعمة هذا اليوم الجديد. نسألك يا سيدنا احفظنا في هذا اليوم بغير خطية...', None, None, None),
    ]
    cursor.executemany("""
        INSERT INTO agpeya_sections (hour_id, section_order, type, title, role, text_ar, text_coptic, text_phonetic, reference)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, prime_sections)

def seed_daily_verses(cursor: sqlite3.Cursor):
    print("Seeding daily verses (366 days)...")
    sample_verses = [
        (1, "يو ٣ : ١٦", "لأَنَّهُ هكَذَا أَحَبَّ اللهُ الْعَالَمَ حَتَّى بَذَلَ ابْنَهُ الْوَحِيدَ، لِكَيْ لاَ يَهْلِكَ كُلُّ مَنْ يُؤْمِنُ بِهِ، بَلْ تَكُونُ لَهُ الْحَيَاةُ الأَبَدِيَّةُ."),
        (2, "في ٤ : ١٣", "أَسْتَطِيعُ كُلَّ شَيْءٍ فِي الْمَسِيحِ الَّذِي يُقَوِّينِي."),
        (3, "مز ٢٣ : ١", "اَلرَّبُّ رَاعِيَّ فَلاَ يُعْوِزُنِي شَيْءٌ."),
        (4, "رو ٨ : ٢٨", "وَنَحْنُ نَعْلَمُ أَنَّ كُلَّ الأَشْيَاءِ تَعْمَلُ مَعًا لِلْخَيْرِ لِلَّذِينَ يُحِبُّونَ اللهَ."),
        (5, "مت ٢٨ : ٢٠", "وَهَا أَنَا مَعَكُمْ كُلَّ الأَيَّامِ إِلَى انْقِضَاءِ الدَّهْرِ."),
        (6, "مز ٤٦ : ١", "اَللهُ لَنَا مَلْجَأٌ وَقُوَّةٌ، عَوْنًا فِي الضِّيقَاتِ وُجِدَ شَدِيدًا."),
        (7, "إش ٤٠ : ٣١", "وَأَمَّا مُنْتَظِرُو الرَّبِّ فَيُجَدِّدُونَ قُوَّةً. يَرْفَعُونَ أَجْنِحَةً كَالنُّسُورِ."),
    ]
    
    # Fill 366 days cyclically
    rows = []
    for day in range(1, 367):
        sample = sample_verses[(day - 1) % len(sample_verses)]
        rows.append((day, sample[1], sample[2]))
        
    cursor.executemany("""
        INSERT INTO daily_verses (day_of_year, reference, text)
        VALUES (?, ?, ?)
    """, rows)

def seed_feasts(cursor: sqlite3.Cursor):
    print("Seeding feasts and fasts...")
    feasts = [
        ('nativity', 'عيد الميلاد المجيد', 'major_feast', 4, 29, 0, None, 'festive', 'ميلاد الكلمة المتجسد في ملء الزمان', 1),
        ('theophany', 'عيد الغطاس المجيد', 'major_feast', 5, 11, 0, None, 'festive', 'عماد السيد المسيح في نهر الأردن وظهور الثالوث القدوس', 1),
        ('annunciation', 'عيد البشارة المجيد', 'major_feast', 7, 29, 0, None, 'festive', 'بشارة الملاك غبريال للعذراء مريم بميلاد المخلص', 1),
        ('palm_sunday', 'أحد الشعانين', 'major_feast', None, None, 1, 'easter - 7', 'festive', 'دخول السيد المسيح أورشليم كملك وديع', 1),
        ('easter', 'عيد القيامة المجيد', 'major_feast', None, None, 1, 'easter', 'festive', 'قيامة ربنا ومخلصنا يسوع المسيح من بين الأموات وظفره بالموت', 50),
        ('ascension', 'عيد الصعود المجيد', 'major_feast', None, None, 1, 'easter + 39', 'festive', 'صعود الرب إلى السماء وجلوسه عن يمين الآب', 1),
        ('pentecost', 'عيد العنصرة', 'major_feast', None, None, 1, 'easter + 49', 'festive', 'حلول الروح القدس المعزي على التلاميذ القديسين وتأسيس الكنيسة', 1),
        ('great_lent', 'الصوم الكبير', 'fast', None, None, 1, 'easter - 55', 'lenten', 'أقدس أصوام السنة - خمسة وخمسون يوماً من النسك والصلوات', 55),
        ('jonah_fast', 'صوم يونان (نينوى)', 'fast', None, None, 1, 'easter - 69', 'lenten', 'ثلاثة أيام توبة واستعداد للصوم الكبير', 3),
        ('nativity_fast', 'صوم الميلاد المجيد', 'fast', 3, 16, 0, None, 'kiahki', 'ثلاثة وأربعون يوماً لاستقبال ميلاد المسيح مخلص العالم', 43),
        ('st_mary_fast', 'صوم السيدة العذراء', 'fast', 12, 1, 0, None, 'annual', 'خمسة عشر يوماً طلباً لشفاعة أم النور الفائقة الطهر', 15),
    ]
    cursor.executemany("""
        INSERT INTO feasts_and_fasts (id, name_ar, type, coptic_month, coptic_day, is_movable, calculation_rule, rite, description, duration_days)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, feasts)

def seed_sacraments(cursor: sqlite3.Cursor):
    print("Seeding Seven Holy Sacraments...")
    sacraments = [
        ('baptism', 'سر المعمودية', 1),
        ('chrismation', 'سر الميرون', 2),
        ('repentance', 'سر التوبة والاعتراف', 3),
        ('eucharist', 'سر الإفخارستيا', 4),
        ('unction', 'سر مسحة المرضى', 5),
        ('matrimony', 'سر الزيجة', 6),
        ('priesthood', 'سر الكهنوت', 7),
    ]
    cursor.executemany("""
        INSERT INTO sacraments (id, name_ar, sacrament_order)
        VALUES (?, ?, ?)
    """, sacraments)

def main():
    print(f"Opening ZIP container: {ZIP_CONTAINER}")
    if not os.path.exists(ZIP_CONTAINER):
        print(f"Error: {ZIP_CONTAINER} not found!")
        return

    # Extract nested APK in-memory
    with zipfile.ZipFile(ZIP_CONTAINER, 'r') as outer_zip:
        apk_bytes = outer_zip.read("com.app.orsozoxi.apk")
        with zipfile.ZipFile(io.BytesIO(apk_bytes), 'r') as apk_zip:
            # Ensure target database directory exists
            os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)
            if os.path.exists(DB_PATH):
                os.remove(DB_PATH)

            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()

            # Enable WAL mode for ultra-fast reading
            cursor.execute("PRAGMA journal_mode=WAL;")
            cursor.execute("PRAGMA synchronous=NORMAL;")

            # 1. Create tables
            create_schema(cursor)

            # 2. Seed Bible
            seed_bible(cursor, apk_zip)

            # 3. Seed Complete Canonical Agpeya
            import_agpeya(cursor, apk_zip)

            # 4. Seed Holy Liturgies (St. Basil, St. Gregory, St. Cyril, Raising of Incense)
            import_liturgies(cursor, apk_zip)

            # 5. Seed Coptic Hymns & Hazat Notations (Deacon Osama Lotfy manuscripts)
            import_hymns(cursor)

            # 6. Seed Complete Coptic Synaxarium (all 13 months, 388 days, 1,000+ entries)
            import_synaxarium(cursor, apk_zip)

            # 7. Seed Complete Katameros (Daily Canonical Readings 366 days)
            import_katameros(cursor, apk_zip)

            # 8. Seed Complete Holy Pascha Dallal (54 hours across Holy Week)
            import_pascha(cursor, apk_zip)

            # 9. Seed Daily Verses
            seed_daily_verses(cursor)

            # 10. Seed Feasts & Fasts
            import_feasts(cursor)

            # 11. Seed Occasional Prayers
            import_prayers(cursor)

            # 12. Seed Seven Holy Sacraments
            import_sacraments(cursor)

            # 13. Seed Saints & Martyrs
            import_saints(cursor)

            # 14. Seed Difnar & Rhymed Praises
            import_difnar(cursor, apk_zip)

            # 15. Seed Theology, Dogmatics & Apologetics
            import_theology(cursor)

            conn.commit()

            # Vacuum & Optimize
            cursor.execute("PRAGMA optimize;")
            conn.close()

    print(f"=== Database build complete! Stored at: {DB_PATH} ===")
    size_mb = os.path.getsize(DB_PATH) / (1024 * 1024)
    print(f"Database size: {size_mb:.2f} MB")

if __name__ == "__main__":
    main()
