# خط إنتاج محتوى نور

لا يعدّل السكربت قاعدة المصدر. ينتج قاعدة محتوى جديدة، وقاعدة مستخدم فارغة، وملف manifest يتضمن SHA-256 والأعداد.

## بناء نسخة مراجعة

```bash
python3 tools/content_pipeline.py \
  --source assets/databases/noor.db \
  --output build/content.db \
  --user-output build/user.db \
  --manifest build/content_manifest.json \
  --sources tools/content_sources.json
```

## بناء إصدار نشر

```bash
python3 tools/content_pipeline.py --sources tools/content_sources.json --release
```

خيار `--release` يفشل عمداً إذا وجد سجلاً غير `approved` أو بلا مصدر ومراجع وتاريخ مراجعة. لا يحذف المسودات بصمت ولا ينتج إصداراً ناقصاً.

صيغة بيانات المراجعة الحالية موضحة في `content_sources.example.json`. أما سجل المصادر المصنف المقترح للمرحلة الأولى فهو `content_sources.template.json`؛ لا يُستخدم كاعتماد، ويجب استبدال العناصر المؤقتة بمصادر حقيقية قبل الإصدار. حالة `approved` تتطلب القيم التالية:

- `source_ref`: الطبعة ودار النشر والسنة أو المرجع المحدد.
- `verified_by`: اسم المراجع المعتمد.
- `verified_at`: تاريخ المراجعة بصيغة ISO-8601.

> التعيين على مستوى الجدول مناسب عندما يكون الجدول كله من المصدر نفسه. عند اختلاف المصادر داخل الجدول يمكن استخدام `records` في ملف metadata، وتحديد `id` و`source_id` وحقول المراجعة لكل سجل. يفشل البناء إذا كان السجل غير موجود أو كان المصدر غير معروف.

## ضمانات آلية

- توحيد كل حقول TEXT إلى Unicode NFC.
- إفراغ جداول المستخدم من قاعدة المحتوى.
- إنشاء `user.db` بمخطط المحفوظات وتظليل الآيات.
- إنشاء FTS5 للآيات بالنص العربي المطبّع.
- `integrity_check` و`foreign_key_check`.
- منع تعديل ملف المصدر.
- manifest يحوي checksum والحجم وعدد صفوف كل جدول.

## مقارنة إصداري محتوى

بعد بناء إصدار جديد، قارن manifest القديم والجديد قبل المراجعة:

```bash
python3 tools/compare_manifests.py old/content_manifest.json new/content_manifest.json
```

يعرض الأمر تغير checksum، المصادر، أعداد السجلات، وprovenance. أي تغيير غير متوقع يحتاج تفسيرًا ومراجعة قبل النشر.

## الاختبار

```bash
python3 -m unittest tools.tests.test_content_pipeline -v
```
