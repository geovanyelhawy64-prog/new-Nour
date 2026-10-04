import sqlite3

conn = sqlite3.connect('assets/databases/noor.db')
c = conn.cursor()

c.execute('''CREATE TABLE IF NOT EXISTS psalis (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    psali_id TEXT UNIQUE NOT NULL,
    type TEXT NOT NULL,
    name_ar TEXT NOT NULL,
    name_coptic TEXT,
    name_phonetic TEXT,
    occasion TEXT NOT NULL,
    day_of_week TEXT,
    season TEXT,
    "order" INTEGER NOT NULL
)''')

c.execute('''CREATE TABLE IF NOT EXISTS psali_sections (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    psali_id TEXT NOT NULL,
    section_order INTEGER NOT NULL,
    text_coptic TEXT NOT NULL,
    text_phonetic TEXT NOT NULL,
    text_arabic TEXT NOT NULL,
    rubric TEXT,
    response TEXT
)''')

# === الهوسات الأربع ===
hos_data = [
    ("hos_1", "hos", "الهوس الأول (تسبحة موسى)", "ⲱϣⲉ ⲁ ⲛⲙⲟⲩⲥⲏⲥ", "أوشي إن مويسيس", "الخروج 15", None, None, 1),
    ("hos_2", "hos", "الهوس الثاني (تسبحة موسى)", "ⲱϣⲉ ⲃ ⲛⲙⲟⲩⲥⲏⲥ", "أوشي في إن مويسيس", "التثنية 32", None, None, 2),
    ("hos_3", "hos", "الهوس الثالث (تسبحة حنة)", "ⲱϣⲉ ⲅ ⲛⲁⲛⲛⲁ", "أوشي غيم إن آنا", "1 صموئيل 2", None, None, 3),
    ("hos_4", "hos", "الهوس الرابع (تسبحة الثلاثة فتية)", "ⲱϣⲉ ⲇ ⲛⲧⲉ ϣⲙⲧⲉ ⲛϣⲏⲣⲉ", "أوشي دي إن تي شمتي إن شيري", "دانيال 3", None, None, 4),
]

# === التئوطوكيات السبع ===
theotokia_data = [
    ("theotokia_sun", "theotokia", "تئوطوكية الأحد", "ⲑⲉⲟⲧⲟⲕⲓⲁ ⲉⲧⲉⲛⲟⲩ ⲉⲧⲃⲉ ⲡⲓⲉⲃⲇⲟⲙⲏ", "ثيئوتوكيا إتينو إيتفي بي إفدومي", "عن التجسد الإلهي", "sunday", "annual", 1),
    ("theotokia_mon", "theotokia", "تئوطوكية الإثنين", "ⲑⲉⲟⲧⲟⲕⲓⲁ ⲉⲧⲉⲛⲟⲩ ⲉⲧⲃⲉ ⲛⲓⲁⲅⲅⲉⲗⲟⲥ", "ثيئوتوكيا إتينو إيتفي ني أنغيلوس", "عن الملائكة", "monday", "annual", 2),
    ("theotokia_tue", "theotokia", "تئوطوكية الثلاثاء", "ⲑⲉⲟⲧⲟⲕⲓⲁ ⲉⲧⲉⲛⲟⲩ ⲉⲧⲃⲉ ⲓⲱⲁⲛⲛⲏⲥ", "ثيئوتوكيا إتينو إيتفي يوانيس", "عن يوحنا المعمدان", "tuesday", "annual", 3),
    ("theotokia_wed", "theotokia", "تئوطوكية الأربعاء", "ⲑⲉⲟⲧⲟⲕⲓⲁ ⲉⲧⲉⲛⲟⲩ ⲉⲧⲃⲉ ⲡⲓⲥⲧⲁⲩⲣⲟⲥ", "ثيئوتوكيا إتينو إيتفي بي ستافروس", "عن الصليب", "wednesday", "annual", 4),
    ("theotokia_thu", "theotokia", "تئوطوكية الخميس", "ⲑⲉⲟⲧⲟⲕⲓⲁ ⲉⲧⲉⲛⲟⲩ ⲉⲧⲃⲉ ⲛⲓⲁⲡⲟⲥⲧⲟⲗⲟⲥ", "ثيئوتوكيا إتينو إيتفي ني أبوستولوس", "عن الرسل", "thursday", "annual", 5),
    ("theotokia_fri", "theotokia", "تئوطوكية الجمعة", "ⲑⲉⲟⲧⲟⲕⲓⲁ ⲉⲧⲉⲛⲟⲩ ⲉⲧⲃⲉ ⲧⲑⲉⲟⲧⲟⲕⲟⲥ", "ثيئوتوكيا إتينو إيتفي تي ثيئوتوكوس", "عن العذراء مريم", "friday", "annual", 6),
    ("theotokia_sat", "theotokia", "تئوطوكية السبت", "ⲑⲉⲟⲧⲟⲕⲓⲁ ⲉⲧⲉⲛⲟⲩ ⲉⲧⲃⲉ ⲛⲓⲁⲅⲓⲟⲥ", "ثيئوتوكيا إتينو إيتفي ني أغيوس", "عن القديسين والراقدين", "saturday", "annual", 7),
]

# === مديحات كيهك (عينة) ===
kiahki_data = [
    ("madih_kiahki_1", "madih", "المديح الأول لكيةك", "ⲧⲉⲛⲟⲩϣⲉ ⲙⲙⲁⲣⲓⲁ", "تينوشيه إم ماريا", "شهر كيهك", None, "kiahki", 1),
    ("madih_kiahki_2", "madih", "المديح الثاني لكيةك", "ⲁⲥⲡⲁⲥⲙⲟⲥ ⲛⲧⲉ ⲧⲑⲉⲟⲧⲟⲕⲟⲥ", "أسبازموس إن تي ثيئوتوكوس", "شهر كيهك", None, "kiahki", 2),
    ("madih_kiahki_3", "madih", "المديح الثالث لكيةك", "ⲟⲩⲉⲡⲓⲥⲕⲟⲡⲟⲥ ⲁϥⲓ", "أوي إبيسكوبوس أف إي", "شهر كيهك", None, "kiahki", 3),
]

# === إبصلمودية (عينة) ===
psalmody_data = [
    ("psali_adam_sun", "psali", "إبصلمودية آدام الأحد", "ⲯⲁⲗⲓ ⲁⲇⲁⲙ ⲉⲧⲉⲛⲟⲩ", "بسالي آدام إتينو", "الأحد", "sunday", "annual", 1),
    ("psali_adam_mon", "psali", "إبصلمودية آدام الإثنين", "ⲯⲁⲗⲓ ⲁⲇⲁⲙ ⲉⲧⲉⲛⲟⲩ", "بسالي آدام إتينو", "الإثنين", "monday", "annual", 2),
    ("psali_watos_wed", "psali", "إبصلمودية واطس الأربعاء", "ⲯⲁⲗⲓ ⲟⲩⲁⲧⲟⲥ ⲉⲧⲉⲛⲟⲩ", "بسالي واطس إتينو", "الأربعاء", "wednesday", "annual", 3),
    ("psali_watos_thu", "psali", "إبصلمودية واطس الخميس", "ⲯⲁⲗⲓ ⲟⲩⲁⲧⲟⲥ ⲉⲧⲉⲛⲟⲩ", "بسالي واطس إتينو", "الخميس", "thursday", "annual", 4),
]

all_psalis = hos_data + theotokia_data + kiahki_data + psalmody_data

for p in all_psalis:
    c.execute('''INSERT OR REPLACE INTO psalis
        (psali_id, type, name_ar, name_coptic, name_phonetic, occasion, day_of_week, season, "order")
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)''', p)

# === أقسام الهوس الأول (عينة) ===
hos1_sections = [
    ("hos_1", 1, "ⲱϣⲉ ⲁ ⲛⲙⲟⲩⲥⲏⲥ ⲉⲧⲃⲉ ⲡⲓⲉⲃⲟⲗ ⲛⲧⲉ ⲛⲓⲓⲥⲣⲁⲏⲗ", "أوشي إن مويسيس إيتفي بي إفول إن تي ني إسرائيل", "تسبحة موسى عن خلاص بني إسرائيل", "يبدأ الكاهن", None),
    ("hos_1", 2, "ⲁⲓⲱϣ ⲉⲡⲭⲟⲉⲓⲥ ⲅⲁⲣ ⲉⲛⲇⲟⲝⲁⲍⲉⲥⲑⲁⲓ", "أيوش إب خويس غار إن ذوكسازيسثاي", "لأنه تمجد وتعظم", None, "الشعب: كيرياليسون"),
    ("hos_1", 3, "ⲡⲓⲙⲁⲣⲉ ⲛⲧⲉ ϩⲓⲡⲡⲟⲥ ⲛⲉⲙ ⲡⲓⲣⲱⲙⲓ ⲁϥⲭⲉⲛ ⲉⲃⲟⲗ ⲉⲡⲓⲟⲙ", "بي ماري إن تي هيبوس نيم بي رومي أف خين إفول إبي يوم", "الفرس وراكبه طرحهما في البحر", None, None),
]

# === أقسام تئوطوكية الأحد (عينة) ===
theotokia_sun_sections = [
    ("theotokia_sun", 1, "ⲑⲉⲟⲧⲟⲕⲓⲁ ⲉⲧⲉⲛⲟⲩ ⲉⲧⲃⲉ ⲡⲓⲉⲃⲟⲗ ⲛⲧⲉ ⲡⲓⲥⲁⲃⲃⲁⲧⲟⲛ", "ثيئوتوكيا إتينو إيتفي بي إفدومي إن تي بي ساباتون", "تئوطوكية الأحد عن التجسد", "يبدأ الشماس", None),
    ("theotokia_sun", 2, "ⲧⲉⲛⲟⲩϣⲉ ⲙⲙⲁⲣⲓⲁ ⲧⲑⲉⲟⲧⲟⲕⲟⲥ ⲧⲡⲁⲣⲑⲉⲛⲟⲥ", "تينوشيه إم ماريا تي ثيئوتوكوس تي بارثينوس", "نسبحك يا مريم والدة الإله العذراء", None, "الشعب: نسبحك يا والدة الإله"),
    ("theotokia_sun", 3, "ⲁⲥⲭⲉ ⲙⲡⲓⲥⲱⲙⲁ ⲛⲧⲉ ⲡⲓⲭⲣⲓⲥⲧⲟⲥ ⲉⲙⲁⲧⲉ", "أس خيه إم بي سوما إن تي بي خريستوس إماتي", "حبلت بالمسيح بالجسد بلا زرع بشر", None, None),
]

all_sections = hos1_sections + theotokia_sun_sections

c.execute("DELETE FROM psali_sections WHERE psali_id IN ('hos_1', 'theotokia_sun')")

for s in all_sections:
    c.execute('''INSERT INTO psali_sections
        (psali_id, section_order, text_coptic, text_phonetic, text_arabic, rubric, response)
        VALUES (?, ?, ?, ?, ?, ?, ?)''', s)

conn.commit()

c.execute('SELECT count(*) FROM psalis')
p_count = c.fetchone()[0]
c.execute('SELECT count(*) FROM psali_sections')
s_count = c.fetchone()[0]
print(f'تم إدخال {p_count} تسبيحة و {s_count} قسم')
conn.close()
