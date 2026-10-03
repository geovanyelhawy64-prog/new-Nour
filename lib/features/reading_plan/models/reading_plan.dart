class PlanReadingItem {
  final int bookId;
  final String bookName;
  final int chapter;
  final String? notes;

  const PlanReadingItem({
    required this.bookId,
    required this.bookName,
    required this.chapter,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
    'bookId': bookId,
    'bookName': bookName,
    'chapter': chapter,
    'notes': notes,
  };

  factory PlanReadingItem.fromJson(Map<String, dynamic> json) => PlanReadingItem(
    bookId: json['bookId'] as int,
    bookName: json['bookName'] as String,
    chapter: json['chapter'] as int,
    notes: json['notes'] as String?,
  );
}

class PlanDay {
  final int dayNumber;
  final String title;
  final List<PlanReadingItem> readings;

  const PlanDay({
    required this.dayNumber,
    required this.title,
    required this.readings,
  });
}

class BibleReadingPlan {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final int totalDays;
  final String iconName;

  const BibleReadingPlan({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.totalDays,
    required this.iconName,
  });
}
