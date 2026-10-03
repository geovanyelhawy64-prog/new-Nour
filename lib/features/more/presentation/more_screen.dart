import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/services/widget_service.dart';
import '../../../widgets/navigation/app_quick_menu.dart';

class MoreHubScreen extends StatelessWidget {
  const MoreHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = <Widget>[
            // شريط الوصول السريع العلوي (بحث، مفضلة، إعدادات، ودجت)
            _buildQuickBar(context, isDark),
            const SizedBox(height: 18),

            // ==========================================
            // المجموعة 1:  الصلوات والطقوس
            // ==========================================
            _buildGroupHeader(
              context,
              title: 'الصلوات والطقوس',
              subtitle: 'الصلوات، القداس، ووضع الكنيسة لايف',
              icon: Icons.church_rounded,
              color: const Color(0xFFBA3838),
            ),
            _buildTile(
              context,
              title: 'الصلوات (الأجبية والسواعي)',
              subtitle: 'الصلوات السبع القانونية، المزامير، الأناجيل، القطع، وصلاة الستار',
              icon: Icons.access_time_filled_rounded,
              color: const Color(0xFF6A1B9A),
              route: '/agpeya',
              badge: '٨ سواعي كاملة',
            ),
            _buildTile(
              context,
              title: 'صلاة حسب المشاعر (جديد)',
              subtitle: 'صلوات روحية معزية حسب حالتك (قلق، حزن، فرح، توبة، مرض)',
              icon: Icons.sentiment_satisfied_alt_rounded,
              color: const Color(0xFFE91E63),
              route: '/prayers/feelings',
              badge: 'معزيات',
            ),
            _buildTile(
              context,
              title: 'القداس (الخولاجي المقدس)',
              subtitle: 'القداس الباسيلي، الغريغوري، والكيرلسي، ورفع بخور عشية وباكر',
              icon: Icons.church_rounded,
              color: const Color(0xFFBA3838),
              route: '/liturgy',
              badge: '٣ قداسات وبخور',
            ),
            _buildTile(
              context,
              title: 'الطقوس الطقسية',
              subtitle: 'المعمودية، الميرون، الزواج، الجناز، السيامات، اللقان، وتدشين الكنائس',
              icon: Icons.church_outlined,
              color: const Color(0xFFC49B3C),
              route: '/rites',
              badge: '١٠ طقوس',
            ),
            _buildTile(
              context,
              title: 'وضع الكنيسة لايف (Church Mode)',
              subtitle: 'المتابع الطقسي التفاعلي للقداس خطوة بخطوة للشعب والشمامسة',
              icon: Icons.fullscreen_rounded,
              color: AppColors.primary,
              route: '/church-mode',
              badge: 'تفاعلي',
            ),
            _buildTile(
              context,
              title: 'صلوات وتسابيح الكنيسة',
              subtitle: 'صلوات التوبة، البركة، السفر، المرضى، وطلبات المؤمنين اليومية',
              icon: Icons.volunteer_activism_rounded,
              color: const Color(0xFF00897B),
              route: '/prayers',
            ),
            _buildTile(
              context,
              title: 'صلوات حسب المشاعر والحاجة',
              subtitle: 'آيات ومزامير وصلوات للضيق، الخوف، التوبة، والشكر',
              icon: Icons.favorite_rounded,
              color: const Color(0xFFE57373),
              route: '/prayers/emotions',
            ),
            _buildTile(
              context,
              title: 'سجل الصلاة اليومي (Prayer Tracker)',
              subtitle: 'متابعة أداء صلوات السواعي وإحصائيات الأسبوع والسلسلة اليومية',
              icon: Icons.check_circle_outline_rounded,
              color: const Color(0xFF2E7D32),
              route: '/prayer-tracker',
            ),

            const SizedBox(height: 18),

            // ==========================================
            // المجموعة 2:  القراءات الكنسية
            // ==========================================
            _buildGroupHeader(
              context,
              title: 'القراءات الكنسية',
              subtitle: 'القراءات، التذكارات والدفنار، وأسبوع الآلام',
              icon: Icons.auto_stories_rounded,
              color: const Color(0xFF00695C),
            ),
            _buildTile(
              context,
              title: 'القراءات (القطمارس اليومي)',
              subtitle: 'قراءات الكنيسة اليومية، الآحاد، الصوم الكبير، الخماسين، والأعياد',
              icon: Icons.auto_stories_rounded,
              color: const Color(0xFF00695C),
              route: '/katameros',
              badge: 'سنوي وموسمي',
            ),
            _buildTile(
              context,
              title: 'التذكارات (السنكسار القبطي)',
              subtitle: 'سير القديسين والشهداء وتذكارات أعياد السنة القبطية الـ ١٣ شهراً كاملة',
              icon: Icons.calendar_today_rounded,
              color: const Color(0xFF5D4037),
              route: '/synaxarium',
              badge: '٨٨١ سيرة',
            ),
            _buildTile(
              context,
              title: 'الدفنار (مدائح الأيام)',
              subtitle: 'مدائح وتسابيح قديسي الأيام بالنغمات الآدام والواطس بالقبطي والعربي',
              icon: Icons.collections_bookmark_rounded,
              color: const Color(0xFF4E342E),
              route: '/difnar',
            ),
            _buildTile(
              context,
              title: 'أسبوع الآلام (البصخة المقدسة)',
              subtitle: 'صلوات وسواعي أسبوع الآلام الليلية والصباحية حتى سبت الفرح',
              icon: Icons.dark_mode_rounded,
              color: const Color(0xFF37474F),
              route: '/pascha',
              badge: 'أسبوع الآلام',
            ),
            _buildTile(
              context,
              title: 'خطة قراءة الكتاب المقدس',
              subtitle: 'خطط منهجية لقراءة العهد الجديد، المزامير، أو الكتاب كاملاً في عام',
              icon: Icons.bookmark_added_rounded,
              color: const Color(0xFF1565C0),
              route: '/reading-plan',
            ),

            const SizedBox(height: 18),

            // ==========================================
            // المجموعة 3:  المعرفة والتراث
            // ==========================================
            _buildGroupHeader(
              context,
              title: 'المعرفة والتراث الكنسي',
              subtitle: 'الأعياد، الأسرار، العقيدة والتاريخ، والأسئلة والأجوبة',
              icon: Icons.lightbulb_rounded,
              color: const Color(0xFF1565C0),
            ),
            _buildTile(
              context,
              title: 'الأعياد (التقويم القبطي والأصوام)',
              subtitle: 'حساب الأعياد السيدية المتنقلة والثابتة وفترات الأصوام على مدار العام',
              icon: Icons.event_note_rounded,
              color: const Color(0xFF0277BD),
              route: '/feasts',
            ),
            _buildTile(
              context,
              title: 'الأسرار (أسرار الكنيسة السبعة)',
              subtitle: 'اللاهوت الطقسي والشواهد الكتابية للأسرار السبعة المقدسة',
              icon: Icons.auto_awesome_rounded,
              color: AppColors.primary,
              route: '/sacraments',
            ),
            _buildTile(
              context,
              title: 'العقيدة والتاريخ الكنسي (أسئلة وأجوبة)',
              subtitle: 'العقيدة الأرثوذكسية، تاريخ الكنيسة والبطاركة، المجامع والردود',
              icon: Icons.menu_book_sharp,
              color: const Color(0xFF4527A0),
              route: '/theology',
            ),
            _buildTile(
              context,
              title: 'القاموس القبطي',
              subtitle: 'قاموس قبطي-عربي-إنجليزي مع النطق والشواهد اللحنية',
              icon: Icons.translate_rounded,
              color: const Color(0xFFC49B3C),
              route: '/dictionary',
              badge: 'قاموس شامل',
            ),

            const SizedBox(height: 18),

            // ==========================================
            // المجموعة 4:  القديسين والأماكن
            // ==========================================
            _buildGroupHeader(
              context,
              title: 'القديسين والأماكن المقدسة',
              subtitle: 'سير القديسين، الشهداء، والأديرة والكنائس الأثرية',
              icon: Icons.place_rounded,
              color: const Color(0xFF8D6E63),
            ),
            _buildTile(
              context,
              title: 'سير القديسين والشهداء',
              subtitle: 'سير الآباء والشهداء والمعترفين مصنفة حسب العصور والتصنيفات',
              icon: Icons.people_alt_rounded,
              color: const Color(0xFFC8A94E),
              route: '/saints',
              badge: '٧٤٩ سيرة',
            ),
            _buildTile(
              context,
              title: 'الأماكن المقدسة والأديرة',
              subtitle: 'أديرة مصر، مسار العائلة المقدسة، والكنائس الأثرية',
              icon: Icons.castle_rounded,
              color: const Color(0xFFC49B3C),
              route: '/holy-places',
            ),

            const SizedBox(height: 18),

            // ==========================================
            // المجموعة 5:  الكتاب المقدس (منفصل)
            // ==========================================
            _buildGroupHeader(
              context,
              title: 'الكتاب المقدس (منفصل)',
              subtitle: 'نسخة الفانديك SVD المشكولة مع الأسفار القانونية الثانية والمزامير الـ 151',
              icon: Icons.menu_book_rounded,
              color: const Color(0xFF1565C0),
            ),
            _buildTile(
              context,
              title: 'الكتاب المقدس الكامل (٧٣ سفراً)',
              subtitle: 'العهد القديم (٤٦ سفراً مع التتمات) والعهد الجديد (٢٧ سفراً) مع تشكيل كامل',
              icon: Icons.menu_book_rounded,
              color: const Color(0xFF1565C0),
              route: '/bible',
              badge: '٧٣ سفراً • ١٥١ مزموراً',
            ),

            const SizedBox(height: 18),

            // ==========================================
            // المجموعة 6:  مدرسة الألحان (منفصل)
            // ==========================================
            _buildGroupHeader(
              context,
              title: 'مدرسة الألحان والقبطي (منفصل)',
              subtitle: 'موسوعة الدياكون أسامة لطفي بأجزائها الأربعة بالهزات الموسيقية',
              icon: Icons.music_note_rounded,
              color: const Color(0xFFD46C20),
            ),
            _buildTile(
              context,
              title: 'مختارات من موسوعة أسامة لطفي',
              subtitle: 'الأجزاء الأربعة: السنوية، الفرايحي، الحزايني، وكيهك مع النص القبطي والمعرب والهزات (٦٣ لحناً مختاراً)',
              icon: Icons.music_note_rounded,
              color: const Color(0xFFD46C20),
              route: '/hymns',
              badge: '٦٣ لحناً • ٤ أجزاء',
            ),

            const SizedBox(height: 24),

            // بطاقة التوثيق والمطور
            _buildAboutCard(context, isDark),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المجموعات الكنسية والمزيد'),
          actions: const [
            AppQuickMenu(),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
        ),
      ),
    );
  }

  Widget _buildQuickBar(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: isDark ? 0.2 : 0.15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildQuickAction(
            context,
            icon: Icons.search_rounded,
            label: 'البحث',
            color: const Color(0xFF1565C0),
            onTap: () => context.push('/search'),
          ),
          _buildQuickAction(
            context,
            icon: Icons.star_rounded,
            label: 'المفضلة',
            color: AppColors.primary,
            onTap: () => context.push('/bookmarks'),
          ),
          _buildQuickAction(
            context,
            icon: Icons.settings_rounded,
            label: 'الإعدادات',
            color: const Color(0xFF5D4037),
            onTap: () => context.push('/settings'),
          ),
          _buildQuickAction(
            context,
            icon: Icons.widgets_rounded,
            label: 'الودجت',
            color: const Color(0xFF00897B),
            onTap: () => _showWidgetInstructions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupHeader(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.heading3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.caption.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String route,
    String? badge,
    VoidCallback? customOnTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.04),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: AppTypography.caption.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
        onTap: () {
          HapticFeedback.lightImpact();
          if (customOnTap != null) {
            customOnTap();
          } else {
            context.push(route);
          }
        },
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'ⲛ',
                    style: TextStyle(
                      fontFamily: AppTypography.copticFontFamily,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Noor • تطبيق نور الأرثوذكسي',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'الإصدار 2.3.0 الإنتاجي المعتمد',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'تطبيق مسيحي أرثوذكسي قبطي شامل، مجاني بالكامل وبدون إعلانات، يعمل أوفلاين سيادياً بنسبة 100% دون أي اتصال خارجي.',
            style: AppTypography.caption,
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المطور: Geovany Elhawy',
                style: AppTypography.caption.copyWith(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shield_outlined, size: 12, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      'أوفلاين 100%',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showWidgetInstructions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.widgets_rounded, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'ودجت شاشة الهاتف (Home Screen Widget)',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'يمكنك إضافة آية اليوم والتاريخ القبطي مباشرة على شاشة هاتفك الرئيسية عبر الخطوات التالية:\n\n'
                '1. اذهب لشاشة هاتفك الرئيسية (Home Screen).\n'
                '2. اضغط مطولاً على أي مساحة فارغة.\n'
                '3. اختر "الأدوات / Widgets".\n'
                '4. ابحث عن تطبيق "نور (Noor)".\n'
                '5. اسحب الودجت وضعه في المكان المفضل لديك.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    HapticFeedback.mediumImpact();
                    await WidgetService.updateHomeScreenWidget();
                    if (ctx.mounted) {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم تحديث بيانات الودجت بنجاح!')),
                      );
                    }
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('تحديث بيانات الودجت الآن'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
