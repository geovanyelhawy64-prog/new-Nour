import sqlite3
import json
import os

# المصدر: تفسير القمص أنطونيوس فكري
# https://st-takla.org/pub_Bible-Interpretations/

db_path = os.path.join(os.path.dirname(__file__), '..', 'assets', 'databases', 'noor.db')
conn = sqlite3.connect(db_path)
c = conn.cursor()

# إنشاء الجدول لو مش موجود
c.execute('''
    CREATE TABLE IF NOT EXISTS bible_commentaries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        book_id INTEGER NOT NULL,
        chapter INTEGER NOT NULL,
        verse_start INTEGER,
        verse_end INTEGER,
        source TEXT NOT NULL,
        author TEXT NOT NULL,
        text TEXT NOT NULL,
        summary TEXT NOT NULL
    )
''')

# عينة تفاسير (هتتملأ من المصدر الفعلي)
sample_commentaries = [
    {
        "book_id": 43,  # يوحنا
        "chapter": 3,
        "verse_start": 16,
        "verse_end": 16,
        "source": "تفسير القمص أنطونيوس فكري",
        "author": "القمص أنطونيوس فكري",
        "text": "هذه الآية تلخص جوهر الإنجيل كله. كلمة 'هكذا' تعني أن محبة الله ليست محبة عادية بل محبة فائقة لا يمكن للعقل البشري أن يستوعبها. الله لم يحب العالم لأنه مستحق للمحبة، بل أحبه رغم أنه كان في خطاياه. وبذل ابنه الوحيد أي أعطى أغلى ما عنده. وهذا يدل على أن المحبة الحقيقية هي العطاء والتضحية. والهدف هو الخلاص من الهلاك الأبدي والحصول على الحياة الأبدية.",
        "summary": "محبة الله الفائقة وبذله لابنه الوحيد لخلاص العالم"
    },
    {
        "book_id": 19,  # المزامير
        "chapter": 23,
        "verse_start": 1,
        "verse_end": 1,
        "source": "تفسير القمص أنطونيوس فكري",
        "author": "القمص أنطونيوس فكري",
        "text": "الرب راعيّ: داود كان راعياً للغنم قبل أن يكون ملكاً، وهو يعرف معنى الرعاية. الراعي الصالح يهتم بكل خروف على حدة، يحميه من الذئاب، يقوده للمراعي الخضراء، ويعتني به لو مرض. وهكذا الله يرعانا. فلا يعوزني شيء: من كان الله راعيه لا ينقصه شيء، لأن الراعي الكامل يوفر كل احتياجات خرافه.",
        "summary": "الله الراعي الصالح الذي يوفر كل احتياجاتنا"
    },
    {
        "book_id": 1,  # التكوين
        "chapter": 1,
        "verse_start": 1,
        "verse_end": 1,
        "source": "تفسير القمص أنطونيوس فكري",
        "author": "القمص أنطونيوس فكري",
        "text": "في البدء: أي في بداية الزمان. فالله موجود قبل الزمان وهو خالق الزمان. خلق: الكلمة العبرية 'بارا' تعني خلق من العدم. فالله لم يستخدم مادة سابقة بل أوجد كل شيء من العدم. الله: الكلمة العبرية 'إلوهيم' وهي صيغة جمع تدل على العظمة والجلال، وفيها إشارة للثالوث القدوس. السماوات والأرض: أي الكون كله بكل ما فيه.",
        "summary": "الله خالق الكون من العدم قبل بدء الزمان"
    },
    # إضافة تفسير على مستوى الإصحاح (يوحنا 3) لتجربة getChapterCommentary
    {
        "book_id": 43,  # يوحنا
        "chapter": 3,
        "verse_start": None,
        "verse_end": None,
        "source": "تفسير القمص أنطونيوس فكري",
        "author": "القمص أنطونيوس فكري",
        "text": "يقدم هذا الإصحاح حديث السيد المسيح مع نيقوديموس حول الولادة الجديدة بالماء والروح كشرط أساسي لمعاينة ملكوت الله ودخوله. كما يبرز محبة الآب الفائقة التي بذل فيها ابنه الوحيد لخلاص كل من يؤمن به.",
        "summary": "حديث الرب مع نيقوديموس عن المعمودية والولادة الجديدة ومحبة الله الفائقة للعالم"
    }
]

# مسح أي عينات قديمة لتفادي التكرار عند إعادة التشغيل
c.execute('DELETE FROM bible_commentaries')

# إدخال العينات
for c_data in sample_commentaries:
    c.execute('''
        INSERT INTO bible_commentaries
        (book_id, chapter, verse_start, verse_end, source, author, text, summary)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ''', (
        c_data['book_id'],
        c_data['chapter'],
        c_data['verse_start'],
        c_data['verse_end'],
        c_data['source'],
        c_data['author'],
        c_data['text'],
        c_data['summary'],
    ))

conn.commit()

# التحقق
c.execute('SELECT count(*) FROM bible_commentaries')
count = c.fetchone()[0]
print(f'Successfully inserted {count} commentaries.')

conn.close()
