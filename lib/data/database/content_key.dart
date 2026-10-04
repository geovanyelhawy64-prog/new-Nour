/// صيغة مركزية للمفاتيح التي تربط بيانات المستخدم بالمحتوى.
///
/// لا تعتمد هذه المفاتيح على رقم صف `id` قابل لإعادة البناء. مفاتيح الكتاب
/// المقدس تعتمد على المرجع، وبقية الأقسام تعتمد على المعرف النصي الثابت.
class ContentKey {
  ContentKey._();

  static String bibleChapter({required int bookId, required int chapter}) {
    _requirePositive(bookId, 'bookId');
    _requirePositive(chapter, 'chapter');
    return 'chapter:$bookId:$chapter';
  }

  static String bibleVerse({
    required int bookId,
    required int chapter,
    required int verse,
  }) {
    _requirePositive(bookId, 'bookId');
    _requirePositive(chapter, 'chapter');
    _requirePositive(verse, 'verse');
    return 'verse:$bookId:$chapter:$verse';
  }

  /// يحول مفاتيح الإصدارات السابقة مثل `1/2` و`1_2_3` إلى الصيغة الثابتة.
  static String canonicalizeBookmark(String contentType, String contentId) {
    final value = contentId.trim();
    if (contentType != 'bible' || value.isEmpty) return value;
    final current = tryParseBible(value);
    if (current != null) return current.canonical;

    final legacy = value.split(RegExp(r'[/_:]'));
    if (legacy.length == 2) {
      final book = int.tryParse(legacy[0]);
      final chapter = int.tryParse(legacy[1]);
      if (_arePositive([book, chapter])) {
        return bibleChapter(bookId: book as int, chapter: chapter as int);
      }
    }
    if (legacy.length == 3) {
      final book = int.tryParse(legacy[0]);
      final chapter = int.tryParse(legacy[1]);
      final verse = int.tryParse(legacy[2]);
      if (_arePositive([book, chapter, verse])) {
        return bibleVerse(
          bookId: book as int,
          chapter: chapter as int,
          verse: verse as int,
        );
      }
    }
    return value;
  }

  static BibleContentReference? tryParseBible(String contentId) {
    final parts = contentId.split(':');
    if (parts.length == 3 && parts.first == 'chapter') {
      final book = int.tryParse(parts[1]);
      final chapter = int.tryParse(parts[2]);
      if (_arePositive([book, chapter])) {
        return BibleContentReference.chapter(
          bookId: book as int,
          chapter: chapter as int,
        );
      }
    }
    if (parts.length == 4 && parts.first == 'verse') {
      final book = int.tryParse(parts[1]);
      final chapter = int.tryParse(parts[2]);
      final verse = int.tryParse(parts[3]);
      if (_arePositive([book, chapter, verse])) {
        return BibleContentReference.verse(
          bookId: book as int,
          chapter: chapter as int,
          verse: verse as int,
        );
      }
    }
    return null;
  }

  static bool _arePositive(List<int?> values) =>
      values.every((value) => value != null && value > 0);

  static void _requirePositive(int value, String name) {
    if (value <= 0) throw ArgumentError.value(value, name, 'يجب أن يكون موجباً');
  }
}

class BibleContentReference {
  const BibleContentReference.chapter({
    required this.bookId,
    required this.chapter,
  }) : verse = null;

  const BibleContentReference.verse({
    required this.bookId,
    required this.chapter,
    required this.verse,
  });

  final int bookId;
  final int chapter;
  final int? verse;

  bool get isVerse => verse != null;

  String get canonical {
    final verseNumber = verse;
    if (verseNumber != null) {
      return ContentKey.bibleVerse(
        bookId: bookId,
        chapter: chapter,
        verse: verseNumber,
      );
    }
    return ContentKey.bibleChapter(bookId: bookId, chapter: chapter);
  }
}
