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

صيغة ملف المصادر موضحة في `content_sources.example.json`. حالة `approved` تتطلب القيم التالية:

- `source_ref`: الطبعة ودار النشر والسنة أو المرجع المحدد.
- `verified_by`: اسم المراجع المعتمد.
- `verified_at`: تاريخ المراجعة بصيغة ISO-8601.

> التعيين الحالي على مستوى الجدول مناسب فقط عندما يكون الجدول كله من المصدر نفسه وقد راجعه الشخص نفسه. عند اختلاف المصادر داخل الجدول تُملأ الأعمدة على مستوى السجل قبل تشغيل بناء الإصدار.

## ضمانات آلية

- توحيد كل حقول TEXT إلى Unicode NFC.
- إفراغ جداول المستخدم من قاعدة المحتوى.
- إنشاء `user.db` بمخطط المحفوظات وتظليل الآيات.
- إنشاء FTS5 للآيات بالنص العربي المطبّع.
- `integrity_check` و`foreign_key_check`.
- منع تعديل ملف المصدر.
- manifest يحوي checksum والحجم وعدد صفوف كل جدول.

## الاختبار

```bash
python3 -m unittest tools.tests.test_content_pipeline -v
```
