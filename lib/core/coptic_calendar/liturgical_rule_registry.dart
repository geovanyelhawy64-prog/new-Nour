import 'dart:convert';

import 'package:flutter/services.dart';

const liturgicalRulesAsset = 'assets/data/liturgical_rules.json';

enum LiturgicalRuleStatus { draft, reviewed, approved }

class LiturgicalRule {
  const LiturgicalRule({
    required this.id,
    required this.titleAr,
    required this.category,
    required this.condition,
    required this.result,
    required this.status,
    required this.enabledInRelease,
    this.sourceRef,
    this.verifiedBy,
    this.verifiedAt,
    this.implementation,
  });

  final String id;
  final String titleAr;
  final String category;
  final String condition;
  final String result;
  final String? sourceRef;
  final LiturgicalRuleStatus status;
  final String? verifiedBy;
  final DateTime? verifiedAt;
  final bool enabledInRelease;
  final String? implementation;

  bool get isSignedAndApproved =>
      status == LiturgicalRuleStatus.approved &&
      sourceRef?.trim().isNotEmpty == true &&
      verifiedBy?.trim().isNotEmpty == true &&
      verifiedAt != null;
}

class LiturgicalRuleRegistry {
  const LiturgicalRuleRegistry._(this.rules);

  final List<LiturgicalRule> rules;

  static Future<LiturgicalRuleRegistry> load({AssetBundle? bundle}) async {
    final source = await (bundle ?? rootBundle).loadString(liturgicalRulesAsset);
    return fromJson(source);
  }

  static LiturgicalRuleRegistry fromJson(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('سجل القواعد الطقسية يجب أن يكون كائناً.');
    }
    if (decoded['schema_version'] != 1 || decoded['rules'] is! List<dynamic>) {
      throw const FormatException('إصدار سجل القواعد الطقسية غير مدعوم.');
    }
    final rawRules = decoded['rules'] as List<dynamic>;
    final rules = rawRules.map(_parseRule).toList(growable: false);
    final ids = rules.map((rule) => rule.id).toSet();
    if (ids.length != rules.length) {
      throw const FormatException('معرفات القواعد الطقسية يجب ألا تتكرر.');
    }
    return LiturgicalRuleRegistry._(rules);
  }

  List<LiturgicalRule> get releaseRules => rules
      .where((rule) => rule.enabledInRelease && rule.isSignedAndApproved)
      .toList(growable: false);

  LiturgicalRule? approvedRule(String id) {
    for (final rule in rules) {
      if (rule.id == id && rule.enabledInRelease && rule.isSignedAndApproved) {
        return rule;
      }
    }
    return null;
  }

  static LiturgicalRule _parseRule(dynamic value) {
    if (value is! Map<String, dynamic>) {
      throw const FormatException('كل قاعدة طقسية يجب أن تكون كائناً.');
    }
    final statusName = _requiredString(value, 'review_status');
    final status = switch (statusName) {
      'draft' => LiturgicalRuleStatus.draft,
      'reviewed' => LiturgicalRuleStatus.reviewed,
      'approved' => LiturgicalRuleStatus.approved,
      _ => throw FormatException('حالة مراجعة غير صالحة: $statusName'),
    };
    final rule = LiturgicalRule(
      id: _requiredString(value, 'id'),
      titleAr: _requiredString(value, 'title_ar'),
      category: _requiredString(value, 'category'),
      condition: _requiredString(value, 'condition'),
      result: _requiredString(value, 'result'),
      sourceRef: _optionalString(value, 'source_ref'),
      status: status,
      verifiedBy: _optionalString(value, 'verified_by'),
      verifiedAt: _optionalDate(value, 'verified_at'),
      enabledInRelease: value['enabled_in_release'] == true,
      implementation: _optionalString(value, 'implementation'),
    );
    if (rule.enabledInRelease && !rule.isSignedAndApproved) {
      throw FormatException(
        'القاعدة ${rule.id} مفعلة للإصدار من دون اعتماد مكتمل.',
      );
    }
    return rule;
  }

  static String _requiredString(Map<String, dynamic> value, String key) {
    final field = value[key];
    if (field is! String || field.trim().isEmpty) {
      throw FormatException('الحقل $key مطلوب في سجل القواعد.');
    }
    return field;
  }

  static String? _optionalString(Map<String, dynamic> value, String key) {
    final field = value[key];
    if (field == null) return null;
    if (field is! String) throw FormatException('الحقل $key يجب أن يكون نصاً.');
    return field.trim().isEmpty ? null : field;
  }

  static DateTime? _optionalDate(Map<String, dynamic> value, String key) {
    final field = _optionalString(value, key);
    if (field == null) return null;
    return DateTime.tryParse(field) ??
        (throw FormatException('الحقل $key يجب أن يكون تاريخ ISO-8601.'));
  }
}
