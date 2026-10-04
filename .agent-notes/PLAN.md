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
- [ ] د0: sha256 + audit_before + baseline commit
- [ ] د1: docs/provenance_audit.csv
- [ ] د2: schema v2 + حقول قانونية في التصدير
- [ ] د5: coverage matrix
- [ ] Makefile + بوابة البناء
- [ ] تحقق: validate + flutter analyze + flutter test
