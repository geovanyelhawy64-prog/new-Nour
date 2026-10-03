import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class PaschaReaderScreen extends StatefulWidget {
  final String dayId;

  const PaschaReaderScreen({super.key, required this.dayId});

  @override
  State<PaschaReaderScreen> createState() => _PaschaReaderScreenState();
}

class _PaschaReaderScreenState extends State<PaschaReaderScreen> {
  late String _activeDayId;
  late int _selectedHour;
  String _selectedService = 'all'; // For Lazarus and Palm Sunday (katameros-based)
  late double _fontSize;
  Future<List<PaschaReading>>? _readingsFuture;
  int _thokRecitationCount = 0;

  static const _availableHours = [
    _HourItem(1, 'باكر'),
    _HourItem(3, 'الثالثة'),
    _HourItem(6, 'السادسة'),
    _HourItem(9, 'التاسعة'),
    _HourItem(11, 'الحادية عشر'),
    _HourItem(12, 'الثانية عشر'),
  ];

  bool get _isKatamerosDay => _activeDayId == 'lazarus' || _activeDayId == 'hosanna';

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    _activeDayId = _normalizeDayId(widget.dayId);
    _selectedHour = _activeDayId == 'joyous_saturday' ? 3 : 1;
    _loadReadings();
  }

  String _normalizeDayId(String id) {
    switch (id) {
      case 'monday':
        return 'monday_day';
      case 'tuesday':
        return 'tuesday_day';
      case 'wednesday':
        return 'wednesday_day';
      case 'thursday':
      case 'covenant_thursday':
        return 'covenant_thursday';
      case 'friday':
      case 'good_friday':
        return 'good_friday';
      case 'saturday':
      case 'bright_saturday':
      case 'joyous_saturday':
        return 'joyous_saturday';
      default:
        return id;
    }
  }

  void _loadReadings() {
    if (_isKatamerosDay) {
      final dayNumber = _activeDayId == 'lazarus' ? 50 : 51;
      _readingsFuture = DatabaseService.instance.katamerosDao
          .getGreatLentReadings(dayNumber)
          .then((items) {
        var filtered = items;
        if (_selectedService != 'all') {
          filtered = items.where((k) => k.serviceType == _selectedService).toList();
        }
        return filtered.map((k) {
          return PaschaReading(
            id: k.id,
            dayId: _activeDayId,
            dayNameAr: _getDayTitle(_activeDayId),
            hourNumber: _serviceToNumber(k.serviceType),
            hourNameAr: _serviceToNameAr(k.serviceType),
            readingType: k.readingType,
            reference: k.reference,
            content: k.content,
            readingOrder: k.id,
          );
        }).toList();
      });
    } else {
      _readingsFuture = DatabaseService.instance.paschaDao.getReadingsForHour(
        _activeDayId,
        _selectedHour,
      );
    }
  }

  int _serviceToNumber(String service) {
    switch (service) {
      case 'vespers':
        return 1;
      case 'matins':
        return 2;
      case 'liturgy':
        return 3;
      default:
        return 0;
    }
  }

  String _serviceToNameAr(String service) {
    switch (service) {
      case 'vespers':
        return 'العشية';
      case 'matins':
        return 'باكر';
      case 'liturgy':
        return 'القداس الإلهي';
      default:
        return 'القراءة الكنسية';
    }
  }

  void _selectHour(int hour) {
    setState(() {
      _selectedHour = hour;
      _thokRecitationCount = 0;
      _loadReadings();
    });
  }

  void _selectService(String service) {
    setState(() {
      _selectedService = service;
      _loadReadings();
    });
  }

  void _togglePeriod() {
    setState(() {
      if (_activeDayId == 'covenant_thursday') {
        _activeDayId = 'thursday_night';
      } else if (_activeDayId == 'thursday_night') {
        _activeDayId = 'covenant_thursday';
      } else if (_activeDayId == 'good_friday') {
        _activeDayId = 'good_friday_night';
      } else if (_activeDayId == 'good_friday_night') {
        _activeDayId = 'good_friday';
      } else if (_activeDayId.endsWith('_day')) {
        _activeDayId = _activeDayId.replaceAll('_day', '_night');
      } else if (_activeDayId.endsWith('_night')) {
        _activeDayId = _activeDayId.replaceAll('_night', '_day');
      }
      _selectedHour = 1;
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

  void _copySection(String title, String content) {
    Clipboard.setData(ClipboardData(text: '$title\n\n$content')).then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم نسخ النص إلى الحافظة')),
        );
      }
    });
  }

  String _getDayTitle(String dayId) {
    switch (dayId) {
      case 'lazarus':
        return 'سبت لعازر الصديق';
      case 'hosanna':
        return 'أحد الشعانين المجيد (السعف)';
      case 'monday_night':
        return 'ليلة الإثنين من البصخة المقدسة';
      case 'monday_day':
        return 'يوم الإثنين من البصخة المقدسة';
      case 'tuesday_night':
        return 'ليلة الثلاثاء من البصخة المقدسة';
      case 'tuesday_day':
        return 'يوم الثلاثاء من البصخة المقدسة';
      case 'wednesday_night':
        return 'ليلة الأربعاء من البصخة المقدسة';
      case 'wednesday_day':
        return 'يوم الأربعاء من البصخة المقدسة';
      case 'thursday_night':
        return 'ليلة الخميس من البصخة المقدسة';
      case 'covenant_thursday':
        return 'خميس العهد المجيد';
      case 'good_friday_night':
        return 'ليلة الجمعة العظيمة';
      case 'good_friday':
        return 'يوم الجمعة العظيمة';
      case 'joyous_saturday':
        return 'سبت الفرح (أبو غلمسيس)';
      default:
        return 'صلوات البصخة المقدسة';
    }
  }

  Color _getSectionColor(String readingType) {
    switch (readingType) {
      case 'prophecy':
        return const Color(0xFF5C6BC0);
      case 'hymn':
        return const Color(0xFFC8A94E);
      case 'psalm':
      case 'psalm_coptic':
        return const Color(0xFFEF6C00);
      case 'gospel':
      case 'gospel_coptic':
        return const Color(0xFFC62828);
      case 'pauline':
        return const Color(0xFF1E88E5);
      case 'catholic':
        return const Color(0xFF43A047);
      case 'acts':
        return const Color(0xFF8E24AA);
      case 'tarh':
      case 'commentary':
      default:
        return const Color(0xFF7B1FA2);
    }
  }

  String _getSectionTitle(PaschaReading r) {
    switch (r.readingType) {
      case 'prophecy':
        return 'النبوات المقدسة';
      case 'hymn':
        return 'تسبحة البصخة (ثوك تى تى جوم)';
      case 'psalm_coptic':
        return 'المزمور القبطي';
      case 'psalm':
        return 'المزمور العربي';
      case 'gospel_coptic':
        return 'الإنجيل المقدس القبطي';
      case 'gospel':
        return 'الإنجيل المقدس العربي';
      case 'pauline':
        return 'البولس (رسالة بولس الرسول)';
      case 'catholic':
        return 'الكاثوليكون (الرسائل الجامعة)';
      case 'acts':
        return 'الإبركسيس (أعمال الرسل)';
      case 'tarh':
        return 'الطرح';
      case 'commentary':
        return 'البيان الكنسي';
      default:
        return 'قراءة مقدسة';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGoodFriday = _activeDayId == 'good_friday';
    final hasNightOption = _activeDayId.contains('_day') ||
        _activeDayId.contains('_night') ||
        _activeDayId == 'covenant_thursday' ||
        _activeDayId == 'good_friday';
    final isNight = _activeDayId.contains('_night');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getDayTitle(_activeDayId),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (hasNightOption)
            IconButton(
              icon: Icon(isNight ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
              tooltip: isNight ? 'التبديل إلى صلوات النهار' : 'التبديل إلى صلوات الليل',
              onPressed: _togglePeriod,
            ),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            height: 48,
            color: Colors.black.withValues(alpha: 0.15),
            child: _isKatamerosDay
                ? _buildKatamerosServiceChips()
                : _buildPaschaHourChips(isGoodFriday),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder<List<PaschaReading>>(
          future: _readingsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingView(message: 'جاري تحميل الصلوات...');
            }

            if (snapshot.hasError) {
              return ErrorView(
                message: 'حدث خطأ أثناء تحميل الصلوات',
                onRetry: () => setState(() => _loadReadings()),
              );
            }

            final readings = snapshot.data ?? [];
            final showRevelationBanner = _activeDayId == 'joyous_saturday';

            if (readings.isEmpty && !showRevelationBanner) {
              return const EmptyView(
                message: 'لا توجد صلوات مسجلة لهذه الخدمة',
                subtitle: 'اختر خدمة أو ساعة أخرى',
                icon: Icons.dark_mode_rounded,
              );
            }

            return RefreshIndicator(
              onRefresh: () async => setState(() => _loadReadings()),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: readings.length + (showRevelationBanner ? 1 : 0),
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  // Revelation banner for Joyous Saturday
                  if (showRevelationBanner && index == 0) {
                    return _buildRevelationBanner();
                  }

                  final rIndex = showRevelationBanner ? index - 1 : index;
                  final r = readings[rIndex];
                  final sectionColor = _getSectionColor(r.readingType);
                  final title = _getSectionTitle(r);

                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: sectionColor.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: sectionColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  title,
                                  style: AppTypography.heading3.copyWith(
                                    fontSize: 16,
                                    color: sectionColor,
                                  ),
                                ),
                              ),
                              if (r.hourNameAr.isNotEmpty) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: sectionColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    r.hourNameAr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: sectionColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                              IconButton(
                                icon: const Icon(Icons.copy_rounded, size: 18),
                                tooltip: 'نسخ',
                                onPressed: () => _copySection(title, r.content),
                              ),
                            ],
                          ),

                          // Reference badge if present
                          if (r.reference != null && r.reference!.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: sectionColor.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                r.reference!,
                                style: AppTypography.caption.copyWith(
                                  color: sectionColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],

                          // Interactive counter for Thok Te Ti Gom
                          if (r.readingType == 'hymn') ...[
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _thokRecitationCount == 12 ? 'تمت التسبحة بالكامل ' : 'عداد الترتيل (١٢ مرة):',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: _thokRecitationCount == 12 ? AppColors.success : null,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle_outline_rounded, size: 22),
                                        onPressed: () {
                                          if (_thokRecitationCount > 0) {
                                            HapticFeedback.selectionClick();
                                            setState(() => _thokRecitationCount--);
                                          }
                                        },
                                      ),
                                      AnimatedScale(
                                        scale: _thokRecitationCount == 12 ? 1.2 : 1.0,
                                        duration: const Duration(milliseconds: 200),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: _thokRecitationCount == 12
                                                ? AppColors.primary.withValues(alpha: 0.15)
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '$_thokRecitationCount / 12',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle_outline_rounded, size: 22),
                                        onPressed: () {
                                          if (_thokRecitationCount < 12) {
                                            HapticFeedback.lightImpact();
                                            setState(() => _thokRecitationCount++);
                                            if (_thokRecitationCount == 12) {
                                              HapticFeedback.heavyImpact();
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],

                          const SizedBox(height: 12),
                          const Divider(height: 1),
                          const SizedBox(height: 12),

                          // Scripture / Liturgical Text
                          SelectableText(
                            r.content,
                            style: (r.readingType == 'psalm_coptic' || r.readingType == 'gospel_coptic')
                                ? AppTypography.coptic.copyWith(fontSize: _fontSize, height: 1.8)
                                : AppTypography.scripture.copyWith(fontSize: _fontSize, height: 1.9),
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
    );
  }

  Widget _buildPaschaHourChips(bool isGoodFriday) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      itemCount: isGoodFriday ? _availableHours.length : _availableHours.length - 1,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (context, idx) {
        final h = _availableHours[idx];
        final isSelected = h.number == _selectedHour;
        return ChoiceChip(
          label: Text(
            h.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => _selectHour(h.number),
          selectedColor: AppColors.primary.withValues(alpha: 0.25),
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : null,
          ),
        );
      },
    );
  }

  Widget _buildKatamerosServiceChips() {
    final services = _activeDayId == 'lazarus'
        ? [
            const _ServiceFilterItem('all', 'الكل'),
            const _ServiceFilterItem('matins', 'باكر'),
            const _ServiceFilterItem('liturgy', 'القداس الإلهي'),
          ]
        : [
            const _ServiceFilterItem('all', 'الكل'),
            const _ServiceFilterItem('vespers', 'العشية'),
            const _ServiceFilterItem('matins', 'باكر'),
            const _ServiceFilterItem('liturgy', 'قداس الشعانين'),
          ];

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      itemCount: services.length,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (context, idx) {
        final item = services[idx];
        final isSelected = item.id == _selectedService;
        return ChoiceChip(
          label: Text(
            item.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => _selectService(item.id),
          selectedColor: AppColors.primary.withValues(alpha: 0.25),
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : null,
          ),
        );
      },
    );
  }

  Widget _buildRevelationBanner() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFFFB300), width: 1.5),
      ),
      color: const Color(0xFFFFF8E1),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/bible/read/73/1'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8F00).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_stories_rounded, color: Color(0xFFE65100), size: 26),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'سفر الرؤيا كاملاً (أبو غلمسيس)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBF360C),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'فتح السفر كاملاً (٢٢ أصحاحاً) لقراءته في سهرة سبت النور',
                      style: TextStyle(fontSize: 12, color: Color(0xFF5D4037)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFFE65100)),
            ],
          ),
        ),
      ),
    );
  }
}

class _HourItem {
  final int number;
  final String label;

  const _HourItem(this.number, this.label);
}

class _ServiceFilterItem {
  final String id;
  final String label;

  const _ServiceFilterItem(this.id, this.label);
}
