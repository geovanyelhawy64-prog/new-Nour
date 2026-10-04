# خطة «نور» — تنفيذ حوكمة البيانات

## الحكم على الخطة
الخطة قوية ومتسقة مع ما بدأناه فعلاً (content_src/ + validate_content.py + export_content_src.py).
تُنفَّذ، لكن مُكيَّفة مع الوضع الحالي: مراحل د0–د2 منجزة جزئياً، والفجوات الحقيقية هي:
جرد الأصل (provenance)، النموذج القانوني الكامل (origin/review_status)، الدمج (reconcile)،
مصفوفات الاكتمال، ملفات المراجعة، بوابة البناء، وMakefile/CI.

## الحجم
L — تنفيذ متعدد المراحل، يُقسَّم إلى دفعات قابلة للتحقق.

## المسار (Path)
د0 تجميد → د1 جرد الأصل → د2 النموذج القانوني → د5 مصفوفات الاكتمال → Makefile/بوابة → تحقق شامل.

## الحالة
- [x] استكشاف الوضع الحالي (content_src موجود، validate_content.py موجود، لا provenance_audit.csv)
- [x] د0: sha256 + audit_before + baseline commit
- [x] د1: docs/provenance_audit.csv — **مكتمل** (33 جدول: 16 printed, 2 reference, 6 authored, 5 unknown, 1 user_data, 1 internal)
- [x] د0.5: Script Quarantine — 5 سكريبتات معزولة في tools/_deprecated/
- [x] د2: Schema v2 extensions — visibility column, psalms LXX mapping (151 rows), feature flags (7 modules gated)
- [ ] د3: Ingest من المصادر المطبوعة (ببدء الكتاب المقدس + الأجبية + المزامير)
- [ ] د4: Reconcile (مقارنة staging مع content_src)
- [ ] د5: coverage matrix (مصفوفات الاكتمال)
- [ ] Makefile + بوابة البناء (CI)
- [ ] تحقق: validate + flutter analyze + flutter test

## ملخص Provenance Audit (د1)
| التصنيف | الجداول | القابل للنشر v1 |
|----------|---------|-----------------|
| **printed** (16) | bible_books, bible_verses, agpeya_hours, agpeya_sections, synaxarium_entries, feasts_and_fasts, hymn_books, hymns, hymn_segments, psali_sections*, psalis*, liturgies, liturgy_sections, liturgy_parts, pascha_readings, katameros_readings, sacraments, sacrament_sections | **YES** |
| **reference** (2) | saints, difnar_entries | **YES** (بشرط مطابقة مطبوع) |
| **authored** (6) | daily_verses, emotion_prayers, occasional_prayers, theology_articles, coptic_dictionary | **NO** (محجوبة في release) |
| **unknown/empty** (5) | monasteries, holy_places, rites, rite_sections, psalis, psali_sections | **NO** (فارغة/لا مصدر) |
| **user_data** (1) | bookmarks | **NO** (user.db منفصل) |
| **internal** (1) | sqlite_sequence | **NO** |

*ملاحظة: psalis و psali_sections مصنفة printed ولكن فارغة حالياً — تحتاج ingestion من الأبصلمودية المطبوعة.

## إجراءات فورية تالية (P0)
1. **Source IDs**: إضافة `source_id` و `source_page` لكل الجداول `printed` في `content_src/*/*.json`
2. **Ingest P0**: الكتاب المقدس (bible_books + bible_verses) + الأجبية (agpeya_hours + agpeya_sections + psalms_mapping) + المزامير
3. **Schema v2 الكامل**: جداول `sources`, `liturgical_rules`, `readings` (كمراجع), `psalm_number_map`
4. **Makefile + CI**: `make verify` = audit→ingest→reconcile→coverage→validate→build-dev→flutter test