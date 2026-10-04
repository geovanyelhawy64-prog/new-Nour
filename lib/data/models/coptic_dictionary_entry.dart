class CopticDictionaryEntry {
  final int id;
  final String coptic;
  final String phonetic;
  final String arabic;
  final String? english;
  final String partOfSpeech;
  final String? usage;
  final String? hymnReference;

  const CopticDictionaryEntry({
    required this.id,
    required this.coptic,
    required this.phonetic,
    required this.arabic,
    this.english,
    required this.partOfSpeech,
    this.usage,
    this.hymnReference,
  });

  String get partOfSpeechAr {
    switch (partOfSpeech) {
      case 'noun':
        return 'اسم';
      case 'verb':
        return 'فعل';
      case 'adjective':
        return 'صفة';
      case 'pronoun':
        return 'ضمير';
      case 'preposition':
        return 'حرف جر';
      case 'conjunction':
        return 'حرف عطف';
      case 'particle':
        return 'أداة';
      case 'interjection':
        return 'تعجب';
      case 'adverb':
        return 'ظرف';
      default:
        return partOfSpeech;
    }
  }

  String get displayText => '$coptic ($phonetic) — $arabic';
}
