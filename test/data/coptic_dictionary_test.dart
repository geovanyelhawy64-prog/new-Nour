import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/models/coptic_dictionary_entry.dart' as model;
import 'package:noor_app/data/repositories/dictionary_repository.dart';

void main() {
  late AppDatabase db;
  late DictionaryRepository repository;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);
    repository = DictionaryRepository();

    // Insert sample dictionary entries
    await db.into(db.copticDictionary).insert(
          CopticDictionaryCompanion.insert(
            coptic: 'ⲁⲅⲓⲟⲥ',
            phonetic: 'أغيوس',
            arabic: 'قدوس، مقدس',
            partOfSpeech: const Value('adjective'),
            english: const Value('holy'),
            usage: const Value('أغيوس أغيوس أغيوس'),
            hymnReference: const Value('التريساجيون'),
          ),
        );

    await db.into(db.copticDictionary).insert(
          CopticDictionaryCompanion.insert(
            coptic: 'ⲕⲩⲣⲓⲟⲥ',
            phonetic: 'كيريوس',
            arabic: 'رب، سيد',
            partOfSpeech: const Value('noun'),
            english: const Value('Lord'),
            usage: const Value('كيرياليسون'),
            hymnReference: const Value('كل الصلوات'),
          ),
        );

    await db.into(db.copticDictionary).insert(
          CopticDictionaryCompanion.insert(
            coptic: 'ⲉⲗⲉⲏⲥⲟⲛ',
            phonetic: 'إليسون',
            arabic: 'ارحم',
            partOfSpeech: const Value('verb'),
            english: const Value('have mercy'),
            usage: const Value('كيرياليسون'),
            hymnReference: const Value('كل الصلوات'),
          ),
        );
  });

  tearDown(() async {
    await DatabaseService.close();
  });

  group('CopticDictionaryEntry Model Tests', () {
    test('partOfSpeechAr maps correctly for various parts of speech', () {
      const noun = model.CopticDictionaryEntry(
        id: 1,
        coptic: 'ⲕⲩⲣⲓⲟⲥ',
        phonetic: 'كيريوس',
        arabic: 'رب',
        partOfSpeech: 'noun',
      );
      expect(noun.partOfSpeechAr, 'اسم');
      expect(noun.displayText, 'ⲕⲩⲣⲓⲟⲥ (كيريوس) — رب');

      const verb = model.CopticDictionaryEntry(
        id: 2,
        coptic: 'ⲉⲗⲉⲏⲥⲟⲛ',
        phonetic: 'إليسون',
        arabic: 'ارحم',
        partOfSpeech: 'verb',
      );
      expect(verb.partOfSpeechAr, 'فعل');

      const adj = model.CopticDictionaryEntry(
        id: 3,
        coptic: 'ⲁⲅⲓⲟⲥ',
        phonetic: 'أغيوس',
        arabic: 'قدوس',
        partOfSpeech: 'adjective',
      );
      expect(adj.partOfSpeechAr, 'صفة');

      const adverb = model.CopticDictionaryEntry(
        id: 4,
        coptic: 'ⲉⲧⲉⲛⲟⲩ',
        phonetic: 'إتينو',
        arabic: 'الآن',
        partOfSpeech: 'adverb',
      );
      expect(adverb.partOfSpeechAr, 'ظرف');
    });
  });

  group('DictionaryDao & Repository Tests', () {
    test('search returns matching entries across coptic, phonetic, arabic, and english', () async {
      final byCoptic = await repository.search('ⲁⲅⲓⲟⲥ');
      expect(byCoptic.length, 1);
      expect(byCoptic.first.arabic, contains('قدوس'));

      final byArabic = await repository.search('ارحم');
      expect(byArabic.length, 1);
      expect(byArabic.first.coptic, 'ⲉⲗⲉⲏⲥⲟⲛ');

      final byEnglish = await repository.search('Lord');
      expect(byEnglish.length, 1);
      expect(byEnglish.first.phonetic, 'كيريوس');

      final empty = await repository.search('');
      expect(empty.isEmpty, isTrue);
    });

    test('getByLetter returns words starting with the letter', () async {
      final entries = await repository.getByLetter('ⲁ');
      expect(entries.length, 1);
      expect(entries.first.coptic, 'ⲁⲅⲓⲟⲥ');
    });

    test('getAll and getCount return correct entries', () async {
      final count = await repository.getCount();
      expect(count, 3);

      final all = await repository.getAll(limit: 2);
      expect(all.length, 2);
    });

    test('getDistinctLetters returns distinct initial letters', () async {
      final letters = await repository.getDistinctLetters();
      expect(letters, containsAll(['ⲁ', 'ⲉ', 'ⲕ']));
    });
  });
}
