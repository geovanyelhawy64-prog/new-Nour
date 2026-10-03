class BibleCommentary {
  final int id;
  final int bookId;
  final int chapter;
  final int? verseStart;
  final int? verseEnd;
  final String source;
  final String author;
  final String text;
  final String summary;

  const BibleCommentary({
    required this.id,
    required this.bookId,
    required this.chapter,
    this.verseStart,
    this.verseEnd,
    required this.source,
    required this.author,
    required this.text,
    required this.summary,
  });

  String get reference {
    if (verseStart != null && verseEnd != null) {
      return '$chapter:$verseStart-$verseEnd';
    }
    if (verseStart != null) {
      return '$chapter:$verseStart';
    }
    return '$chapter';
  }

  bool get isChapterLevel => verseStart == null;
  bool get isVerseLevel => verseStart != null;
}
