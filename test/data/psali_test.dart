import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/models/psali.dart' as model;
import 'package:noor_app/data/repositories/psali_repository.dart';

void main() {
  late AppDatabase db;
  late PsaliRepository repository;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);
    repository = PsaliRepository();

    // Insert sample psalis
    await db.into(db.psalis).insert(
          PsalisCompanion.insert(
            psaliId: 'hos_1',
            type: 'hos',
            nameAr: 'الهوس الأول',
            nameCoptic: const Value('ⲱϣⲉ ⲁ'),
            namePhonetic: const Value('أوشي إن مويسيس'),
            occasion: 'الخروج 15',
            order: 1,
          ),
        );

    await db.into(db.psalis).insert(
          PsalisCompanion.insert(
            psaliId: 'theotokia_sun',
            type: 'theotokia',
            nameAr: 'تئوطوكية الأحد',
            nameCoptic: const Value('ⲑⲉⲟⲧⲟⲕⲓⲁ'),
            namePhonetic: const Value('ثيئوتوكيا'),
            occasion: 'عن التجسد الإلهي',
            dayOfWeek: const Value('sunday'),
            season: const Value('annual'),
            order: 1,
          ),
        );

    await db.into(db.psalis).insert(
          PsalisCompanion.insert(
            psaliId: 'madih_kiahki_1',
            type: 'madih',
            nameAr: 'المديح الأول لكيهك',
            occasion: 'شهر كيهك',
            season: const Value('kiahki'),
            order: 1,
          ),
        );

    await db.into(db.psalis).insert(
          PsalisCompanion.insert(
            psaliId: 'psali_adam_sun',
            type: 'psali',
            nameAr: 'إبصلمودية آدام الأحد',
            occasion: 'الأحد',
            dayOfWeek: const Value('sunday'),
            season: const Value('annual'),
            order: 1,
          ),
        );

    // Insert sample psali sections
    await db.into(db.psaliSections).insert(
          PsaliSectionsCompanion.insert(
            psaliId: 'hos_1',
            sectionOrder: 1,
            textCoptic: 'ⲱϣⲉ ⲁ',
            textPhonetic: 'أوشي إن مويسيس',
            textArabic: 'تسبحة موسى الأولى',
            rubric: const Value('يبدأ الكاهن'),
            response: const Value('كيرياليسون'),
          ),
        );

    await db.into(db.psaliSections).insert(
          PsaliSectionsCompanion.insert(
            psaliId: 'hos_1',
            sectionOrder: 2,
            textCoptic: 'ⲁⲓⲱϣ ⲉⲡⲭⲟⲉⲓⲥ',
            textPhonetic: 'أيوش إب خويس',
            textArabic: 'لأنه تمجد وتعظم',
          ),
        );
  });

  tearDown(() async {
    await DatabaseService.close();
  });

  group('Psali Model Tests', () {
    test('typeAr maps correctly for all PsaliTypes', () {
      const p1 = model.Psali(
        id: 1,
        psaliId: 'h1',
        type: model.PsaliType.hos,
        nameAr: 'الهوس',
        occasion: 'تسبحة',
        order: 1,
      );
      expect(p1.typeAr, 'هوس');

      const p2 = model.Psali(
        id: 2,
        psaliId: 't1',
        type: model.PsaliType.theotokia,
        nameAr: 'تئوطوكية',
        occasion: 'العذراء',
        dayOfWeek: 'sunday',
        order: 1,
      );
      expect(p2.typeAr, 'تئوطوكية');
      expect(p2.dayAr, 'الأحد');

      const p3 = model.Psali(
        id: 3,
        psaliId: 'm1',
        type: model.PsaliType.madih,
        nameAr: 'مديح',
        occasion: 'كيهك',
        order: 1,
      );
      expect(p3.typeAr, 'مديح');
    });
  });

  group('PsaliDao & PsaliRepository Tests', () {
    test('getHos returns hos items', () async {
      final hos = await repository.getHos();
      expect(hos.length, 1);
      expect(hos.first.psaliId, 'hos_1');
      expect(hos.first.type, model.PsaliType.hos);
    });

    test('getTheotokiaByDay returns theotokia for specified day', () async {
      final sun = await repository.getTheotokiaByDay('sunday');
      expect(sun.length, 1);
      expect(sun.first.nameAr, 'تئوطوكية الأحد');

      final mon = await repository.getTheotokiaByDay('monday');
      expect(mon.isEmpty, isTrue);
    });

    test('getKiahkiMadihat returns kiahki madihat', () async {
      final madihat = await repository.getKiahkiMadihat();
      expect(madihat.length, 1);
      expect(madihat.first.psaliId, 'madih_kiahki_1');
    });

    test('getPsalmody returns psali items', () async {
      final psalies = await repository.getPsalmody();
      expect(psalies.length, 1);
      expect(psalies.first.type, model.PsaliType.psali);
    });

    test('getByType returns items matching requested type', () async {
      final theotokias = await repository.getByType('theotokia');
      expect(theotokias.length, 1);
      expect(theotokias.first.psaliId, 'theotokia_sun');
    });

    test('getAll returns all items sorted', () async {
      final all = await repository.getAll();
      expect(all.length, 4);
    });

    test('getSections returns sections for a psali', () async {
      final sections = await repository.getSections('hos_1');
      expect(sections.length, 2);
      expect(sections.first.sectionOrder, 1);
      expect(sections.first.rubric, 'يبدأ الكاهن');
      expect(sections.first.response, 'كيرياليسون');
      expect(sections[1].sectionOrder, 2);
    });

    test('getCount returns total psalis count', () async {
      final count = await repository.getCount();
      expect(count, 4);
    });
  });
}
