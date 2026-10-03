import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/utils/search_normalizer.dart';
import 'package:noor_app/data/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(
      NativeDatabase(File('assets/databases/noor.db'), readOnly: true),
    );
  });

  tearDown(() => database.close());

  test('قاعدة الإصدار تحتوي على FTS5 قابل للاستعلام', () async {
    final table = await database.customSelect(
      "SELECT 1 FROM sqlite_master "
      "WHERE type = 'table' AND name = 'bible_verses_fts'",
    ).getSingleOrNull();
    expect(table, isNotNull);

    final result = await database.customSelect(
      'SELECT verse_id FROM bible_verses_fts '
      'WHERE bible_verses_fts MATCH ? LIMIT 1',
      variables: [
        const Variable<String>('يسوع'),
      ],
    ).getSingleOrNull();
    expect(result, isNotNull);
  });

  test('البحث المشكول وغير المشكول يعطي النتائج نفسها', () async {
    final plain = await database.bibleDao.searchVerses('يسوع', limit: 1000);
    final vocalized = await database.bibleDao.searchVerses('يَسُوع', limit: 1000);

    expect(plain, isNotEmpty);
    expect(vocalized.map((verse) => verse.id), plain.map((verse) => verse.id));
  });

  test('مدخل المستخدم يتحول إلى MATCH آمن', () {
    expect(
      SearchNormalizer.toFts5Query('  فِي   الْبَدْءِ  '),
      '"في" AND "البد"',
    );
    expect(SearchNormalizer.toFts5Query(''), isEmpty);
  });
}
