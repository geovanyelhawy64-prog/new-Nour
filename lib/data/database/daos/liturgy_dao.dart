import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/liturgy_tables.dart';

part 'liturgy_dao.g.dart';

class LiturgyPartWithSection {
  final LiturgySection section;
  final LiturgyPart part;

  const LiturgyPartWithSection({required this.section, required this.part});
}

@DriftAccessor(tables: [Liturgies, LiturgySections, LiturgyParts])
class LiturgyDao extends DatabaseAccessor<AppDatabase> with _$LiturgyDaoMixin {
  LiturgyDao(super.db);

  /// جلب كل القداسات
  Future<List<Liturgy>> getAllLiturgies() {
    return (select(liturgies)..orderBy([(l) => OrderingTerm.asc(l.liturgyOrder)])).get();
  }

  /// جلب قداس معين
  Future<Liturgy> getLiturgy(String liturgyId) {
    return (select(liturgies)..where((l) => l.id.equals(liturgyId))).getSingle();
  }

  /// جلب أقسام قداس معين
  Future<List<LiturgySection>> getSectionsForLiturgy(String liturgyId) {
    return (select(liturgySections)
          ..where((s) => s.liturgyId.equals(liturgyId))
          ..orderBy([(s) => OrderingTerm.asc(s.sectionOrder)]))
        .get();
  }

  /// جلب أجزاء قسم معين مع دعم فلتر السرية والدور
  Future<List<LiturgyPart>> getPartsForSection(
    String sectionId, {
    bool includeSecret = true,
    String? roleFilter,
  }) {
    final query = select(liturgyParts)..where((p) => p.sectionId.equals(sectionId));

    if (!includeSecret) {
      query.where((p) => p.isSecret.equals(false));
    }

    if (roleFilter != null && roleFilter.isNotEmpty && roleFilter != 'all') {
      query.where((p) => p.role.equals(roleFilter) | p.role.equals('all'));
    }

    query.orderBy([(p) => OrderingTerm.asc(p.partOrder)]);
    return query.get();
  }

  /// جلب كل أجزاء القداس الكامل مرتبة بالأقسام مع دعم الفلاتر
  Future<List<LiturgyPartWithSection>> getFullLiturgyParts(
    String liturgyId, {
    bool includeSecret = true,
    String? roleFilter,
  }) async {
    final sections = await getSectionsForLiturgy(liturgyId);
    final result = <LiturgyPartWithSection>[];

    for (final sec in sections) {
      final parts = await getPartsForSection(
        sec.id,
        includeSecret: includeSecret,
        roleFilter: roleFilter,
      );
      for (final p in parts) {
        result.add(LiturgyPartWithSection(section: sec, part: p));
      }
    }
    return result;
  }
}
