import 'dart:io';
import 'package:drift/native.dart';
import 'package:noor_app/data/database/app_database.dart';

void main() async {
  final file = File('assets/databases/noor.db');
  print('File exists: ${file.existsSync()}');
  
  final db = AppDatabase(NativeDatabase(file));
  
  // Check liturgies
  final liturgies = await db.liturgyDao.getAllLiturgies();
  print('Liturgies count: ${liturgies.length}');
  for (var l in liturgies) {
    print('  - ${l.id}: ${l.nameAr}');
  }
  
  // Check hymn books
  final hymnBooks = await db.hymnsDao.getAllBooks();
  print('\nHymn books count: ${hymnBooks.length}');
  for (var b in hymnBooks) {
    print('  - ${b.id}: ${b.nameAr}');
  }
  
  // Check hymns per book
  for (var b in hymnBooks) {
    final hymns = await db.hymnsDao.getHymnsForBook(b.id);
    print('  ${b.id}: ${hymns.length} hymns');
  }
  
  // Check monasteries
  final allSites = await db.select(db.holyPlaces).get();
  print('\nHoly places count: ${allSites.length}');
  for (var s in allSites) {
    print('  - ${s.id}: ${s.nameAr} (${s.type})');
  }
  
  await db.close();
  exit(0);
}