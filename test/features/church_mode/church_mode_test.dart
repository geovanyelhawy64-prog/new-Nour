import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/features/church_mode/data/church_mode_data.dart';
import 'package:noor_app/features/church_mode/models/liturgy_step.dart';

void main() {
  group('Church Mode (وضع الكنيسة) Liturgical Verifications', () {
    test('contains exactly 22 sequential canonical liturgy steps', () {
      final steps = ChurchModeData.steps;
      expect(steps.length, 22);

      for (int i = 0; i < steps.length; i++) {
        expect(steps[i].stepNumber, i + 1);
        expect(steps[i].title.isNotEmpty, isTrue);
        expect(steps[i].priestAction.isNotEmpty, isTrue);
        expect(steps[i].deaconChant.isNotEmpty, isTrue);
        expect(steps[i].congregationResponse.isNotEmpty, isTrue);
        expect(steps[i].spiritualMeaning.isNotEmpty, isTrue);
      }
    });

    test('verifies key theological and liturgical landmark steps', () {
      final steps = ChurchModeData.steps;

      // الخطوة 4: تقديم الحمل
      final offeringStep = steps[3];
      expect(offeringStep.title, contains('تقديم الحمل'));
      expect(offeringStep.stage, LiturgyStage.offering);

      // الخطوة 13: صلاة الصلح
      final reconciliationStep = steps[12];
      expect(reconciliationStep.title, contains('صلاة الصلح'));
      expect(reconciliationStep.stage, LiturgyStage.faithful);

      // الخطوة 17: قصة التأسيس والرشومات
      final institutionStep = steps[16];
      expect(institutionStep.title, contains('التأسيس'));
      expect(institutionStep.stage, LiturgyStage.faithful);

      // الخطوة 18: حلول الروح القدس (الإپيكليسيس)
      final epiclesisStep = steps[17];
      expect(epiclesisStep.title, contains('حلول الروح القدس'));
      expect(epiclesisStep.posture, CongregationPosture.prostrating);

      // الخطوة 21: الاعتراف الأخير
      final confessionStep = steps[20];
      expect(confessionStep.title, contains('الاعتراف الأخير'));
      expect(confessionStep.posture, CongregationPosture.prostrating);

      // الخطوة 22: التناول والختام
      final communionStep = steps[21];
      expect(communionStep.title, contains('التناول'));
      expect(communionStep.stage, LiturgyStage.communion);
    });

    test('verifies Coptic phrases and phonetic arabized texts are present', () {
      final stepsWithCoptic = ChurchModeData.steps.where((s) => s.copticPhrase != null).toList();
      expect(stepsWithCoptic.length, greaterThan(15));

      for (final step in stepsWithCoptic) {
        expect(step.copticArabized, isNotNull);
        expect(step.copticArabized!.isNotEmpty, isTrue);
      }
    });
  });
}
