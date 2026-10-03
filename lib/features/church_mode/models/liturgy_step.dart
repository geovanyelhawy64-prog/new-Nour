/// رتبة المرحلة الطقسية في القداس الإلهي
enum LiturgyStage {
  matins('رفع بخور باكر والعشية'),
  offering('تقديم الحمل والتحليل'),
  catechumens('قداس الموعوظين (القراءات التعليمية)'),
  faithful('قداس المؤمنين (الأنافورا والرشومات)'),
  communion('القسمة والتناول والبركة');

  final String titleAr;
  const LiturgyStage(this.titleAr);
}

/// وضعية الجسد والخشوع المطلوبة في هذه الخطوة
enum CongregationPosture {
  standing('الوقوف بخشوع'),
  prostrating('الركوع والسجود إلى الأرض'),
  sitting('الجلوس والإصغاء بهدوء'),
  communion('التقدم للتناول بمهابة');

  final String label;
  const CongregationPosture(this.label);
}

/// خطوة تفاعلية من خطوات القداس الإلهي
class LiturgyStep {
  final int stepNumber;
  final String title;
  final LiturgyStage stage;
  final CongregationPosture posture;
  final String priestAction;
  final String deaconChant;
  final String congregationResponse;
  final String spiritualMeaning;
  final String? copticPhrase;
  final String? copticArabized;

  const LiturgyStep({
    required this.stepNumber,
    required this.title,
    required this.stage,
    required this.posture,
    required this.priestAction,
    required this.deaconChant,
    required this.congregationResponse,
    required this.spiritualMeaning,
    this.copticPhrase,
    this.copticArabized,
  });
}
