import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/repositories/bible_repository.dart';

void main() {
  late AppDatabase db;
  late BibleRepository repo;

  setUp(() {
    db = AppDatabase.test(NativeDatabase.memory());
    repo = BibleRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('verse_highlights table is created on fresh DB and roundtrips', () async {
    await repo.setVerseHighlight(1, 1, 1, 'yellow');
    await repo.setVerseHighlight(1, 1, 2, 'red');

    var highlights = await repo.getChapterHighlights(1, 1);
    expect(highlights, {1: 'yellow', 2: 'red'});

    await repo.setVerseHighlight(1, 1, 1, 'green');
    highlights = await repo.getChapterHighlights(1, 1);
    expect(highlights[1], 'green');

    await repo.removeVerseHighlight(1, 1, 2);
    highlights = await repo.getChapterHighlights(1, 1);
    expect(highlights, {1: 'green'});
  });
}
