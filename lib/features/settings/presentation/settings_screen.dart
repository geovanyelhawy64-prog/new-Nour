import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../app/app.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/providers/simple_mode_provider.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  double _fontSize = PreferencesService.getFontSize();
  String _fontFamily = 'Cairo';
  bool _showTashkeel = PreferencesService.getShowTashkeel();
  bool _notificationsEnabled = PreferencesService.getNotificationsEnabled();
  int _alertHour = PreferencesService.getDailyVerseHour();
  int _alertMinute = PreferencesService.getDailyVerseMinute();
  bool _prayerReminders = PreferencesService.getPrayerReminders();
  int _prayerHour = PreferencesService.getPrayerReminderHour();
  int _prayerMinute = PreferencesService.getPrayerReminderMinute();
  bool _showCoptic = PreferencesService.getShowCoptic();
  bool _hapticHazat = PreferencesService.getHapticHazat();
  PermissionStatus? _permissionStatus;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    try {
      final status = await Permission.notification.status;
      if (mounted) {
        setState(() {
          _permissionStatus = status;
        });
      }
    } catch (_) {}
  }

  Future<void> _requestNotificationPermission() async {
    try {
      final status = await Permission.notification.request();
      if (!mounted) return;
      setState(() {
        _permissionStatus = status;
      });

      if (status.isGranted) {
        setState(() {
          _notificationsEnabled = true;
          _prayerReminders = true;
        });
        await PreferencesService.setNotificationsEnabled(true);
        await PreferencesService.setPrayerReminders(true);
        try {
          await NotificationService.scheduleDailyVerse(
            hour: _alertHour,
            minute: _alertMinute,
          );
          await NotificationService.scheduleDailyPrayerReminder(
            hour: _prayerHour,
            minute: _prayerMinute,
          );
          await NotificationService.scheduleAllAgpeyaReminders();
        } catch (_) {}

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تفعيل الإشعارات بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('الإشعارات معطلة'),
            backgroundColor: Colors.red.shade700,
            action: status.isPermanentlyDenied
                ? SnackBarAction(
                    label: 'فتح الإعدادات',
                    textColor: Colors.white,
                    onPressed: () => openAppSettings(),
                  )
                : null,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('الإشعارات معطلة'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  Future<void> _pickDailyVerseTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _alertHour, minute: _alertMinute),
      helpText: 'اختر ساعة آية اليوم',
      confirmText: 'حفظ',
      cancelText: 'إلغاء',
    );

    if (picked != null) {
      setState(() {
        _alertHour = picked.hour;
        _alertMinute = picked.minute;
      });
      await PreferencesService.setDailyVerseTime(picked.hour, picked.minute);
      if (_notificationsEnabled) {
        await NotificationService.scheduleDailyVerse(
          hour: picked.hour,
          minute: picked.minute,
        );
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم ضبط موعد إشعار آية اليوم: ${picked.format(context)}')),
        );
      }
    }
  }

  Future<void> _pickPrayerReminderTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _prayerHour, minute: _prayerMinute),
      helpText: 'اختر ساعة تذكير الصلوات',
      confirmText: 'حفظ',
      cancelText: 'إلغاء',
    );

    if (picked != null) {
      setState(() {
        _prayerHour = picked.hour;
        _prayerMinute = picked.minute;
      });
      await PreferencesService.setPrayerReminderTime(picked.hour, picked.minute);
      if (_prayerReminders) {
        await NotificationService.scheduleDailyPrayerReminder(
          hour: picked.hour,
          minute: picked.minute,
        );
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم ضبط موعد تذكير الصلوات: ${picked.format(context)}')),
        );
      }
    }
  }

  Future<void> _exportBookmarks() async {
    final items = await DatabaseService.userData.getAllBookmarks();
    if (items.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا توجد عناصر محفوظة لتصديرها')),
        );
      }
      return;
    }

    final data = items
        .map((b) => {
              'contentType': b.contentType,
              'contentId': b.contentId,
              'displayTitle': b.displayTitle,
              'note': b.note,
              'createdAt': b.createdAt.millisecondsSinceEpoch,
            })
        .toList();

    final jsonStr = jsonEncode(data);
    await Clipboard.setData(ClipboardData(text: jsonStr));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نسخ بيانات المفضلة للحافظة بنجاح!')),
      );
    }
  }

  Future<void> _importBookmarks() async {
    final data = await Clipboard.getData('text/plain');
    final text = data?.text?.trim();
    if (text == null || text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الحافظة فارغة! انسخ نص النسخة الاحتياطية أولاً')),
        );
      }
      return;
    }

    try {
      final decoded = jsonDecode(text) as List<dynamic>;
      int added = 0;
      for (final item in decoded) {
        final map = item as Map<String, dynamic>;
        final cType = map['contentType'] as String;
        final cId = map['contentId'] as String;
        final exists = await DatabaseService.userData.isBookmarked(cType, cId);
        if (!exists) {
          await DatabaseService.userData.addBookmark(
            contentType: cType,
            contentId: cId,
            displayTitle: map['displayTitle'] as String,
            note: map['note'] as String?,
          );
          added++;
        }
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم استرجاع $added عنصر إلى المفضلة')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('خطأ في تنسيق بيانات النسخة الاحتياطية')),
        );
      }
    }
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.church_rounded, color: AppColors.primary, size: 24),
              SizedBox(width: 8),
              Text('عن تطبيق نور (Noor)'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'تطبيق مسيحي أرثوذكسي قبطي شامل، يضم الكتاب المقدس (٧٣ سفراً و ١٥١ مزموراً)، الأجبية، الخولاجي، القطمارس، السنكسار، والألحان بالهزات الموسيقية وفق كتاب المعلم أسامة لطفي.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 12),
              const Text(
                'الإصدار: 2.3.0 الإنتاجي المعتمد\nيعمل أوفلاين سيادياً 100% بدون أي اتصال خارجي.',
                style: AppTypography.caption,
              ),
              const Divider(height: 20),
              Text(
                'المطور: Geovany Elhawy',
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('إغلاق'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeType = ref.watch(appThemeProvider);
    final isSimpleMode = ref.watch(simpleModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final items = <Widget>[
            // ==========================================
            // القسم 1:  القراءة (حجم + نوع الخط)
            // ==========================================
            _buildSectionHeader('١. القراءة'),
            Card(
              elevation: 0,
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.format_size_rounded, color: AppColors.primary),
                        const SizedBox(width: 10),
                        const Text('حجم خط القراءة والصلوات', style: TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text('${_fontSize.toInt()} نقطة',
                            style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Slider(
                      value: _fontSize,
                      min: 16,
                      max: 32,
                      divisions: 8,
                      activeColor: AppColors.primary,
                      onChanged: (val) {
                        setState(() => _fontSize = val);
                        PreferencesService.setFontSize(val);
                      },
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        '«أَنَا هُوَ نُورُ الْعَالَمِ. مَنْ يَتْبَعْنِي فَلاَ يَمْشِي فِي الظُّلْمَةِ.»',
                        style: TextStyle(
                          fontFamily: _fontFamily,
                          fontSize: _fontSize,
                          height: 1.8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.font_download_rounded, color: AppColors.primary),
                        const SizedBox(width: 10),
                        const Text('نوع الخط العربي', style: TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        DropdownButton<String>(
                          value: _fontFamily,
                          underline: const SizedBox.shrink(),
                          onChanged: (font) {
                            if (font != null) {
                              setState(() => _fontFamily = font);
                            }
                          },
                          items: const [
                            DropdownMenuItem(value: 'Cairo', child: Text('خط القاهرة (Cairo)')),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==========================================
            // القسم 2:  المظهر (فاتح / غامق / تلقائي)
            // ==========================================
            _buildSectionHeader('٢. المظهر'),
            Card(
              elevation: 0,
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.palette_rounded, color: AppColors.primary),
                    title: const Text('نمط العرض والألوان', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      switch (themeType) {
                        AppThemeType.light => 'الوضع النهاري (عاجي دافئ)',
                        AppThemeType.dark => 'وضع الشموع (بني داكن)',
                        AppThemeType.amoled => 'الأسود الكامل لشاشات OLED',
                        _ => 'تلقائي حسب نظام الهاتف',
                      },
                      style: AppTypography.caption,
                    ),
                    trailing: DropdownButton<AppThemeType>(
                      value: switch (themeType) {
                        AppThemeType.light ||
                        AppThemeType.dark ||
                        AppThemeType.amoled => themeType,
                        _ => AppThemeType.system,
                      },
                      underline: const SizedBox.shrink(),
                      onChanged: (mode) {
                        if (mode != null) {
                          ref.read(appThemeProvider.notifier).state = mode;
                          PreferencesService.setThemeMode(mode.name);
                        }
                      },
                      items: const [
                        DropdownMenuItem(value: AppThemeType.system, child: Text('تلقائي (النظام)')),
                        DropdownMenuItem(value: AppThemeType.light, child: Text('نهاري')),
                        DropdownMenuItem(value: AppThemeType.dark, child: Text('شموع')),
                        DropdownMenuItem(value: AppThemeType.amoled, child: Text('أسود OLED')),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text(
                      'الوضع المبسط (لكبار السن)',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    subtitle: const Text(
                      'واجهة بأزرار وخطوط كبيرة للوصول السريع للصلوات اليومية',
                      style: TextStyle(fontSize: 13),
                    ),
                    secondary: const Icon(Icons.accessibility_new_rounded, color: AppColors.primary),
                    value: isSimpleMode,
                    onChanged: (val) async {
                      await ref.read(simpleModeProvider.notifier).setSimpleMode(val);
                      if (val && context.mounted) {
                        context.go('/simple');
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ==========================================
            // القسم 3:  التذكيرات (صلاة + آية)
            // ==========================================
            _buildSectionHeader('٣. التذكيرات'),
            Card(
              elevation: 0,
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    // زر تفعيل الإشعارات وطلب إذن النظام (Android 13+)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          key: const Key('enable_notifications_button'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 1,
                          ),
                          onPressed: _requestNotificationPermission,
                          icon: const Icon(Icons.notifications_active_rounded),
                          label: const Text(
                            'تفعيل الإشعارات',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    if (_permissionStatus != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          _permissionStatus!.isGranted
                              ? ' إذن الإشعارات مفعّل في النظام'
                              : ' إذن الإشعارات غير مفعّل في النظام',
                          style: AppTypography.caption.copyWith(
                            color: _permissionStatus!.isGranted ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const Divider(height: 1),
                    SwitchListTile(
                      secondary: const Icon(Icons.access_time_rounded, color: AppColors.primary),
                      title: const Text('تنبيهات صلوات الأجبية', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('إشعارات بأوقات السواعي القانونية السبع والتذكير اليومي', style: AppTypography.caption),
                      value: _prayerReminders,
                      onChanged: (val) async {
                        setState(() => _prayerReminders = val);
                        await PreferencesService.setPrayerReminders(val);
                        if (val) {
                          await NotificationService.scheduleDailyPrayerReminder(
                            hour: _prayerHour,
                            minute: _prayerMinute,
                          );
                          await NotificationService.scheduleAllAgpeyaReminders();
                        } else {
                          await NotificationService.cancelAll();
                        }
                      },
                    ),
                    ListTile(
                      leading: const SizedBox(width: 24),
                      title: const Text('ساعة تذكير الصلوات'),
                      subtitle: Text(
                        'الموعد المحدد: ${TimeOfDay(hour: _prayerHour, minute: _prayerMinute).format(context)}',
                        style: AppTypography.caption,
                      ),
                      trailing: TextButton.icon(
                        icon: const Icon(Icons.alarm_rounded, size: 18),
                        label: Text(TimeOfDay(hour: _prayerHour, minute: _prayerMinute).format(context)),
                        onPressed: _pickPrayerReminderTime,
                      ),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      secondary: const Icon(Icons.menu_book_rounded, color: AppColors.primary),
                      title: const Text('إشعار آية اليوم', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        'إشعار يومي صباحي (${TimeOfDay(hour: _alertHour, minute: _alertMinute).format(context)})',
                        style: AppTypography.caption,
                      ),
                      value: _notificationsEnabled,
                      onChanged: (val) async {
                        setState(() => _notificationsEnabled = val);
                        await PreferencesService.setNotificationsEnabled(val);
                        if (val) {
                          await NotificationService.scheduleDailyVerse(
                            hour: _alertHour,
                            minute: _alertMinute,
                          );
                        }
                      },
                    ),
                    ListTile(
                      leading: const SizedBox(width: 24),
                      title: const Text('ساعة آية اليوم'),
                      subtitle: Text(
                        'الموعد المحدد: ${TimeOfDay(hour: _alertHour, minute: _alertMinute).format(context)}',
                        style: AppTypography.caption,
                      ),
                      trailing: TextButton.icon(
                        icon: const Icon(Icons.access_time_rounded, size: 18),
                        label: Text(TimeOfDay(hour: _alertHour, minute: _alertMinute).format(context)),
                        onPressed: _pickDailyVerseTime,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==========================================
            // القسم 4:  المحتوى (تشكيل + قبطي)
            // ==========================================
            _buildSectionHeader('٤. المحتوى واللغة'),
            Card(
              elevation: 0,
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.spellcheck_rounded, color: AppColors.primary),
                    title: const Text('إظهار التشكيل في النصوص', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('عرض الحركات والتشكيل في آيات الكتاب المقدس وصلوات الأجبية', style: AppTypography.caption),
                    value: _showTashkeel,
                    onChanged: (val) {
                      setState(() => _showTashkeel = val);
                      PreferencesService.setShowTashkeel(val);
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.translate_rounded, color: AppColors.primary),
                    title: const Text('إظهار النصوص القبطية والمعربة', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('إظهار النصوص القبطية الأصيلة ونطقها المعرب في الألحان والقداسات', style: AppTypography.caption),
                    value: _showCoptic,
                    onChanged: (val) {
                      setState(() => _showCoptic = val);
                      PreferencesService.setShowCoptic(val);
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.vibration_rounded, color: AppColors.primary),
                    title: const Text('الاهتزاز اللمسي لهزات الألحان', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('نبضات لمسية خفيفة عند نقر وتتبع هزات الألحان لضبط إيقاع الترتيل', style: AppTypography.caption),
                    value: _hapticHazat,
                    onChanged: (val) {
                      setState(() => _hapticHazat = val);
                      PreferencesService.setHapticHazat(val);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ==========================================
            // القسم 5:  بيانات وعن التطبيق
            // ==========================================
            _buildSectionHeader('٥. بيانات وعن التطبيق'),
            Card(
              elevation: 0,
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.upload_file_rounded, color: AppColors.primary),
                    title: const Text('تصدير المحفوظات والمفضلة', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('نسخ الآيات والصلوات المحفوظة للحافظة كنسخة احتياطية', style: AppTypography.caption),
                    trailing: const Icon(Icons.copy_rounded, size: 20),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _exportBookmarks();
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.download_rounded, color: AppColors.primary),
                    title: const Text('استيراد المفضلة', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('استرجاع المفضلة والملاحظات من نص الحافظة', style: AppTypography.caption),
                    trailing: const Icon(Icons.paste_rounded, size: 20),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _importBookmarks();
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded, color: AppColors.primary),
                    title: const Text('عن تطبيق نور والمراجع الكنسية', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('الإصدار 2.3.0 • عمل أوفلاين سيادي 100% • مصادر معتمدة', style: AppTypography.caption),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () => _showAboutDialog(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // توقيع المطور (بخط صغير وأنيق كما طلب المستخدم)
            Center(
              child: Column(
                children: [
                  Text(
                    'المطور: Geovany Elhawy',
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'geovanyelhawy64@gmail.com',
                    style: AppTypography.caption.copyWith(
                      fontSize: 11,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'صُنع بـ  لمجد الله • Noor v2.3.0',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
                    ),
                  ),
                ],
              ),
            ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الإعدادات'),
          actions: const [
            AppQuickMenu(),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        title,
        style: AppTypography.heading3.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
