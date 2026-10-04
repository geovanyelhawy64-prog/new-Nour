import 'package:flutter/material.dart';
import '../../../data/models/monastery.dart';
import '../../../data/repositories/monasteries_repository.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class MonasteryDetailScreen extends StatelessWidget {
  final String siteId;

  const MonasteryDetailScreen({super.key, required this.siteId});

  @override
  Widget build(BuildContext context) {
    final repo = MonasteriesRepository();
    const accentGold = Color(0xFFD4AF37);

    return FutureBuilder<Monastery?>(
      future: repo.getSiteById(siteId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final site = snapshot.data;
        if (site == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('المعلم غير موجود')),
            body: const Center(
              child: Text('عذراً، لم يتم العثور على هذا الدير أو المزار الأثري.'),
            ),
          );
        }

        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(site.isMonastery ? 'دير قبطي عامر' : 'كنيسة ومزار أثري'),
            actions: const [
              AppQuickMenu(),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            // بطاقة العنوان والاسم القبطي
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    accentGold.withValues(alpha: 0.2),
                    accentGold.withValues(alpha: 0.04),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentGold.withValues(alpha: 0.35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        site.isMonastery ? Icons.castle_rounded : Icons.church_rounded,
                        color: accentGold,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: accentGold.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          site.century,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD4AF37),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    site.nameAr,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  if (site.nameCoptic != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      site.nameCoptic!,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        fontFamily: 'Coptic',
                        fontSize: 16,
                        color: Color(0xFFD4AF37),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // شبكة المعلومات السريعة
            _buildInfoTile(
              icon: Icons.location_on_rounded,
              title: 'الموقع الجغرافي',
              content: site.location,
              accentGold: accentGold,
              theme: theme,
            ),
            const SizedBox(height: 10),

            _buildInfoTile(
              icon: Icons.person_rounded,
              title: 'المؤسس وتاريخ التأسيس',
              content: site.founder,
              accentGold: accentGold,
              theme: theme,
            ),
            const SizedBox(height: 10),

            _buildInfoTile(
              icon: Icons.auto_awesome_rounded,
              title: 'الشفيع والرفات المقدسة',
              content: site.patronSaints,
              accentGold: accentGold,
              theme: theme,
            ),
            const SizedBox(height: 10),

            _buildInfoTile(
              icon: Icons.celebration_rounded,
              title: 'تاريخ العيد السنوي والموسم',
              content: site.feastDate,
              accentGold: accentGold,
              theme: theme,
            ),
            const SizedBox(height: 10),

            _buildInfoTile(
              icon: Icons.access_time_filled_rounded,
              title: 'مواعيد الزيارة واستقبال الزوار',
              content: site.visitingHours,
              accentGold: accentGold,
              theme: theme,
            ),
            ...[
            const SizedBox(height: 10),
            _buildInfoTile(
              icon: Icons.map_rounded,
              title: 'الإحداثيات الجغرافية',
              content: site.coordinates,
              accentGold: accentGold,
              theme: theme,
            ),
          ],
            const SizedBox(height: 16),

            // اللمحة التاريخية الكاملة
            _buildSectionCard(
              title: 'اللمحة التاريخية والروحية',
              icon: Icons.history_edu_rounded,
              content: site.historySummary,
              accentGold: accentGold,
              theme: theme,
            ),
            const SizedBox(height: 14),

            // الوصف المعماري والآثار
            _buildSectionCard(
              title: 'الوصف المعماري والآثار والأيقونات',
              icon: Icons.architecture_rounded,
              content: site.architecturalDescription,
              accentGold: accentGold,
              theme: theme,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  },
);
}

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String content,
    required Color accentGold,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: accentGold),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required String content,
    required Color accentGold,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: accentGold),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: accentGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
