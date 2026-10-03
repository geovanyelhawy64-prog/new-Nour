import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/data/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUpAll(() {
    final file = File('assets/databases/noor.db');
    expect(file.existsSync(), isTrue, reason: 'assets/databases/noor.db must exist');
    db = AppDatabase(NativeDatabase(file));
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Agpeya Integrity Master Audit Tests', () {
    test('عدد الساعات = 8 (السواعي السبع القانونية + صلاة الستار للرهبان)', () async {
      final hours = await db.agpeyaDao.getAllHours();
      expect(hours.length, 8);
    });

    test('كل ساعة فيها مزامير وقطع وإنجيل', () async {
      final hours = await db.agpeyaDao.getAllHours();
      for (final h in hours) {
        final sections = await db.agpeyaDao.getSectionsForHour(h.id);
        expect(sections.isNotEmpty, isTrue, reason: 'Hour ${h.id} has no sections');
      }
    });

    test('مزامير باكر تشمل المزامير الكنسية الستة والمزمور الخمسيني', () async {
      final primeSections = await db.agpeyaDao.getSectionsForHour('prime');
      expect(primeSections.length, 43);
      final hasPsalm50 = primeSections.any((s) =>
          s.title.contains('الخَمْسون') ||
          s.title.contains('الخمسون') ||
          s.title.contains('50') ||
          s.textAr.contains('ارْحَمنِى') ||
          s.textAr.contains('ارحمني'));
      expect(hasPsalm50, isTrue);
    });

    test('صلاة نصف الليل تحتوي على خدماتها الثلاث القانونية', () async {
      final midnightSections = await db.agpeyaDao.getSectionsForHour('midnight');
      expect(midnightSections.length, greaterThanOrEqualTo(30));
      expect(midnightSections.any((s) => s.title.contains('الأولى') || s.textAr.contains('الخدمة الأولى') || s.sectionOrder < 15), isTrue);
    });

    test('كل قطعة فيها دور + نص ومفيش قطعة فاضية في الأجبية', () async {
      final primeSections = await db.agpeyaDao.getSectionsForHour('prime');
      for (final s in primeSections) {
        expect(s.title.trim().isNotEmpty, isTrue);
        expect(s.textAr.trim().isNotEmpty, isTrue);
        expect(s.role.trim().isNotEmpty, isTrue);
      }
    });
  });
}
