import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../../../core/coptic_calendar/coptic_month.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class KatamerosReaderScreen extends StatefulWidget {
  final String sectionId;

  const KatamerosReaderScreen({super.key, required this.sectionId});

  @override
  State<KatamerosReaderScreen> createState() => _KatamerosReaderScreenState();
}

class _KatamerosReaderScreenState extends State<KatamerosReaderScreen> {
  late CopticDate _currentDate;
  late double _fontSize;
  String _selectedServiceFilter = 'all'; // all, liturgy, matins, vespers
  late Future<List<KatamerosReading>> _readingsFuture;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    _currentDate = CopticDate.fromDateTime(DateTime.now());
    _loadReadings();
  }

  void _loadReadings() {
    _readingsFuture = DatabaseService.instance.katamerosDao.getLiturgicalReadingsForDate(
      _currentDate.toDateTime(),
      _currentDate,
    );
  }

  void _nextDay() {
    setState(() {
      _currentDate = _currentDate.nextDay();
      _loadReadings();
    });
  }

  void _prevDay() {
    setState(() {
      _currentDate = _currentDate.previousDay();
      _loadReadings();
    });
  }

  void _increaseFont() {
    if (_fontSize < 36.0) {
      setState(() => _fontSize += 2.0);
      PreferencesService.setFontSize(_fontSize);
    }
  }

  void _decreaseFont() {
    if (_fontSize > 14.0) {
      setState(() => _fontSize -= 2.0);
      PreferencesService.setFontSize(_fontSize);
    }
  }

  void _copyReading(KatamerosReading reading) {
    final title = _getReadingTitle(reading);
    Clipboard.setData(ClipboardData(text: '$title\n${reading.reference}\n\n${reading.content}')).then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم نسخ القراءة إلى الحافظة')),
        );
      }
    });
  }

  String _getReadingTitle(KatamerosReading r) {
    final svcPrefix = r.serviceType == 'vespers'
        ? 'عشية'
        : r.serviceType == 'matins'
            ? 'باكر'
            : 'القداس الإلهي';

    switch (r.readingType) {
      case 'pauline':
        return 'البولس (رسالة بولس الرسول)';
      case 'catholic':
        return 'الكاثوليكون (رسالة جامعة)';
      case 'acts':
        return 'الإبركسيس (أعمال الرسل)';
      case 'psalm':
        return 'مزمور $svcPrefix';
      case 'gospel':
        return 'إنجيل $svcPrefix';
      case 'prophecy':
        return 'نبؤة $svcPrefix';
      default:
        return 'قراءة $svcPrefix';
    }
  }

  Color _getReadingColor(String readingType) {
    switch (readingType) {
      case 'pauline':
        return const Color(0xFF1565C0);
      case 'catholic':
        return const Color(0xFF6A1B9A);
      case 'acts':
        return const Color(0xFF2E7D32);
      case 'psalm':
        return const Color(0xFFE65100);
      case 'gospel':
        return AppColors.primary;
      default:
        return AppColors.primaryDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final monthName = CopticMonth.fromNumber(_currentDate.month).nameAr;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'قراءات ${_currentDate.day} $monthName',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_increase_rounded, size: 20),
            tooltip: 'تكبير الخط',
            onPressed: _increaseFont,
          ),
          IconButton(
            icon: const Icon(Icons.text_decrease_rounded, size: 20),
            tooltip: 'تصغير الخط',
            onPressed: _decreaseFont,
          ),
          const AppQuickMenu(),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // Date Switcher Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.primary.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    tooltip: 'اليوم السابق',
                    onPressed: _prevDay,
                  ),
                  Column(
                    children: [
                      Text(
                        _currentDate.formatArabic(),
                        style: AppTypography.heading3.copyWith(fontSize: 15, color: AppColors.primaryDark),
                      ),
                      Text('قطمارس الأيام السنوية', style: AppTypography.caption),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                    tooltip: 'اليوم التالي',
                    onPressed: _nextDay,
                  ),
                ],
              ),
            ),

            // Service Filter Chips (الكل، القداس، باكر، عشية)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('الكل', 'all'),
                    const SizedBox(width: 8),
                    _buildFilterChip('القداس الإلهي', 'liturgy'),
                    const SizedBox(width: 8),
                    _buildFilterChip('باكر', 'matins'),
                    const SizedBox(width: 8),
                    _buildFilterChip('عشية', 'vespers'),
                  ],
                ),
              ),
            ),

            // Main Readings List
            Expanded(
              child: FutureBuilder<List<KatamerosReading>>(
                future: _readingsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingView(message: 'جاري تحميل قراءات القطمارس...');
                  }

                  if (snapshot.hasError) {
                    return ErrorView(
                      message: 'حدث خطأ أثناء تحميل قراءات القطمارس',
                      onRetry: () => setState(() => _loadReadings()),
                    );
                  }

                  final allReadings = snapshot.data ?? [];
                  final filtered = _selectedServiceFilter == 'all'
                      ? allReadings
                      : allReadings.where((r) => r.serviceType == _selectedServiceFilter).toList();

                  if (filtered.isEmpty) {
                    return EmptyView(
                      message: 'لا توجد قراءات مسجلة لهذا اليوم بالخدمة المحددة',
                      subtitle: _currentDate.formatArabic(),
                      icon: Icons.auto_stories_rounded,
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async => setState(() => _loadReadings()),
                    child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final reading = filtered[index];
                      final title = _getReadingTitle(reading);
                      final accentColor = _getReadingColor(reading.readingType);

                      return Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Reading Header
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 4,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: AppTypography.heading3.copyWith(
                                        fontSize: 16,
                                        color: accentColor,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.copy_rounded, size: 18),
                                    tooltip: 'نسخ القراءة',
                                    onPressed: () => _copyReading(reading),
                                  ),
                                ],
                              ),

                              // Reference badge
                              if (reading.reference.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: accentColor.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    reading.reference,
                                    style: AppTypography.caption.copyWith(
                                      color: accentColor,
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],

                              const SizedBox(height: 12),
                              const Divider(height: 1),
                              const SizedBox(height: 12),

                              // Scripture Text with full tashkeel
                              SelectableText(
                                reading.content,
                                style: AppTypography.scripture.copyWith(
                                  fontSize: _fontSize,
                                  height: 2.0,
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final selected = _selectedServiceFilter == value;
    return ChoiceChip(
      label: Text(label, style: TextStyle(fontSize: 12, fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
      selected: selected,
      onSelected: (val) {
        if (val) setState(() => _selectedServiceFilter = value);
      },
      selectedColor: AppColors.primary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: selected ? AppColors.primary : AppColors.textSecondaryLight,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
