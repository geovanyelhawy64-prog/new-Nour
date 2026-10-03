import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/coptic_calendar/liturgical_rule_registry.dart';

void main() {
  test('المسودة لا تدخل قواعد الإصدار', () {
    final registry = LiturgicalRuleRegistry.fromJson('''
      {
        "schema_version": 1,
        "rules": [{
          "id": "rite.test",
          "title_ar": "قاعدة اختبار",
          "category": "ecclesiastical_rubric",
          "condition": "شرط",
          "result": "نتيجة",
          "source_ref": null,
          "review_status": "draft",
          "verified_by": null,
          "verified_at": null,
          "enabled_in_release": false,
          "implementation": null
        }]
      }
    ''');

    expect(registry.rules, hasLength(1));
    expect(registry.releaseRules, isEmpty);
    expect(registry.approvedRule('rite.test'), isNull);
  });

  test('يرفض تفعيل قاعدة غير موقعة', () {
    expect(
      () => LiturgicalRuleRegistry.fromJson('''
        {
          "schema_version": 1,
          "rules": [{
            "id": "rite.unsafe",
            "title_ar": "قاعدة غير معتمدة",
            "category": "ecclesiastical_rubric",
            "condition": "شرط",
            "result": "نتيجة",
            "source_ref": null,
            "review_status": "reviewed",
            "verified_by": null,
            "verified_at": null,
            "enabled_in_release": true,
            "implementation": "RiteDeterminer"
          }]
        }
      '''),
      throwsFormatException,
    );
  });

  test('يسمح بقاعدة مكتملة الاعتماد فقط', () {
    final registry = LiturgicalRuleRegistry.fromJson('''
      {
        "schema_version": 1,
        "rules": [{
          "id": "calendar.approved",
          "title_ar": "قاعدة معتمدة",
          "category": "calendar_computation",
          "condition": "شرط معلوم",
          "result": "نتيجة معلومة",
          "source_ref": "المرجع، الطبعة الأولى، ص 10",
          "review_status": "approved",
          "verified_by": "اسم المراجع",
          "verified_at": "2026-10-03T12:00:00+02:00",
          "enabled_in_release": true,
          "implementation": "Example.calculate"
        }]
      }
    ''');

    expect(registry.releaseRules, hasLength(1));
    expect(registry.approvedRule('calendar.approved'), isNotNull);
  });
}
