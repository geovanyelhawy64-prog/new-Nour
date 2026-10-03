# أوراق مراجعة المحتوى

هذه الملفات **تقارير كشف** وليست أحكاماً بصحة النص أو خطئه. لا يصح تعديل آية أو ترقيم اعتماداً على التقرير وحده.

## التشغيل

```bash
python3 tools/content_audit.py --output review_sheets/generated
```

وللمقارنة بطبعة معتمدة بعد إعداد ملف الأعداد وتوقيعه من المراجع:

```bash
python3 tools/content_audit.py \
  --reference-counts review_sheets/reference/chapter_verse_counts_approved.csv \
  --output review_sheets/generated \
  --strict
```

صيغة ملف المرجع:

```csv
book_id,book_name,chapter,expected_count
1,التكوين,1,31
```

## التقارير

- `chapter_verse_counts.csv`: العدد الفعلي لكل إصحاح.
- `verse_numbering_anomalies.csv`: فجوات أو أرقام أقل من 1 أو تكرار.
- `missing_cross_references.csv`: شواهد مصدرها أو هدفها غير موجود في القاعدة.
- `verse_text_issues.csv`: نص فارغ أو HTML أو رموز تحكم.
- `hymns_without_segments.csv`: لحن لا يحتوي على ربع واحد على الأقل.
- `reference_count_mismatches.csv`: الفرق عن ملف الطبعة المعتمدة، إن قُدّم.
- `summary.json`: ملخص قابل للقراءة من CI.

## إجراء التصحيح

1. يكتب المراجع موضع الملاحظة والصواب والطبعة والصفحة.
2. يوقّع المراجع الملاحظة ويؤرخها.
3. يُصحح المصدر، لا ملف التقرير المولّد.
4. يضاف اختبار regression للحالة المصححة.
5. يعاد تشغيل التدقيق وخط إنتاج المحتوى.

## نتيجة الفحص الحالي

الفحص الحالي حدّد خمس حالات ترقيم للمراجعة: اللاويين 14، عزرا 6، المزمور 77، يشوع بن سيراخ 29، وباروخ 6. كما حدّد شواهد مترابطة لا تجد أهدافها الحالية. لم يُصحح أي منها آلياً لغياب قرار موثق من طبعة معتمدة.
