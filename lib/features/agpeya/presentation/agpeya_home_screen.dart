import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../widgets/common/adaptive_master_detail.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';
import '../providers/agpeya_providers.dart';
import 'hour_reader_screen.dart';

class AgpeyaHomeScreen extends ConsumerStatefulWidget {
  const AgpeyaHomeScreen({super.key});

  @override
  ConsumerState<AgpeyaHomeScreen> createState() => _AgpeyaHomeScreenState();
}

class _AgpeyaHomeScreenState extends ConsumerState<AgpeyaHomeScreen> {
  String? _selectedHourId;

  static const _canonicalHours = [
    _HourItem('prime', 'صلاة باكر', 'الساعة الأولى من النهار - تذكار قيامة الرب ونوره الحقيقي', Icons.wb_sunny_rounded, Color(0xFFFFA000)),
    _HourItem('terce', 'صلاة الساعة الثالثة', 'الساعة التاسعة صباحاً - تذكار محاكمة المسيح وحلول الروح القدس', Icons.schedule_rounded, Color(0xFFFF7043)),
    _HourItem('sext', 'صلاة الساعة السادسة', 'الساعة الثانية عشرة ظهراً - تذكار صلب مخلصنا الصالح', Icons.wb_twilight_rounded, Color(0xFFE53935)),
    _HourItem('none', 'صلاة الساعة التاسعة', 'الساعة الثالثة عصراً - تذكار موت الرب المحيي بالجسد على الصليب', Icons.wb_twilight_outlined, Color(0xFF8E24AA)),
    _HourItem('vespers', 'صلاة الغروب', 'الساعة الخامسة مساءً - تذكار إنزال جسد الرب وإيداعه في القبر', Icons.nights_stay_outlined, Color(0xFF3949AB)),
    _HourItem('compline', 'صلاة النوم', 'تذكار وضع جسد المسيح في القبر والنوم الأخير', Icons.bedtime_rounded, Color(0xFF1E88E5)),
    _HourItem('curtain', 'صلاة الستار', 'صلاة خاصة بالآباء الرهبان والعذارى', Icons.curtains_closed_rounded, Color(0xFF00897B)),
    _HourItem('midnight', 'صلاة نصف الليل', 'ثلاث خدمات - تذكار المجيء الثاني والاستعداد للقاء العريس', Icons.dark_mode_rounded, Color(0xFF2E7D32)),
  ];

  @override
  void initState() {
    super.initState();
    _selectedHourId = null;
  }

  @override
  Widget build(BuildContext context) {
    final hoursAsync = ref.watch(agpeyaHoursProvider);
    final isTablet = AdaptiveMasterDetail.isTablet(context);

    final masterList = Scaffold(
      appBar: AppBar(
        title: const Text('الصلوات (الأجبية المقدسة)'),
        actions: const [
          AppQuickMenu(),
        ],
      ),
      body: hoursAsync.when(
        data: (dbHours) {
          final lastHourId = PreferencesService.getLastAgpeyaHour();
          final lastHourItem = lastHourId != null
              ? _canonicalHours.where((h) => h.id == lastHourId).firstOrNull
              : null;

          return RefreshIndicator(
            onRefresh: () => ref.refresh(agpeyaHoursProvider.future),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (lastHourItem != null) ...[
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: AppColors.primary.withValues(alpha: 0.4)),
                    ),
                    color: AppColors.primary.withValues(alpha: 0.08),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(Icons.history_rounded, color: Colors.white),
                      ),
                      title: const Text('متابعة آخر صلاة', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(lastHourItem.title),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      onTap: () {
                        if (isTablet) {
                          setState(() => _selectedHourId = lastHourItem.id);
                        } else {
                          context.push('/agpeya/hour/${lastHourItem.id}');
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                ..._canonicalHours.map((canonical) {
                  final dbHour = dbHours.where((h) => h.id == canonical.id).firstOrNull;
                  final title = dbHour?.nameAr ?? canonical.title;
                  final description = dbHour?.description ?? canonical.description;
                  final isSelected = isTablet && _selectedHourId == canonical.id;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      elevation: isSelected ? 3 : 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: isSelected
                            ? const BorderSide(color: AppColors.primary, width: 2)
                            : BorderSide.none,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          if (isTablet) {
                            setState(() {
                              _selectedHourId = canonical.id;
                            });
                          } else {
                            context.push('/agpeya/hour/${canonical.id}');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: canonical.color.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  canonical.icon,
                                  color: canonical.color,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: AppTypography.heading3.copyWith(
                                        fontSize: 16,
                                        color: isSelected ? AppColors.primary : null,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      description,
                                      style: AppTypography.caption,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: isSelected ? AppColors.primary : AppColors.textSecondaryLight,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
        loading: () => const LoadingView(message: 'جاري تحميل السواعي المقدسة...'),
        error: (error, stack) => ErrorView(
          message: 'حدث خطأ أثناء تحميل السواعي المقدسة',
          onRetry: () => ref.refresh(agpeyaHoursProvider),
        ),
      ),
    );

    return AdaptiveMasterDetail(
      master: masterList,
      detail: _selectedHourId != null
          ? KeyedSubtree(
              key: ValueKey(_selectedHourId),
              child: HourReaderScreen(hourId: _selectedHourId!),
            )
          : null,
      emptyDetailMessage: 'اختر إحدى السواعي المقدسة لقراءتها هنا مباشرة',
    );
  }
}

class _HourItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _HourItem(this.id, this.title, this.description, this.icon, this.color);
}
