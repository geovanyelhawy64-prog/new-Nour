///نموذج بيانات المحفوظات الموحّد بين قاعدة المحتوى وقاعدة المستخدم.
class Bookmark {
  final int id;
  final String contentType;
  final String contentId;
  final String displayTitle;
  final String? note;
  final DateTime createdAt;

  const Bookmark({
    required this.id,
    required this.contentType,
    required this.contentId,
    required this.displayTitle,
    required this.note,
    required this.createdAt,
  });
}
