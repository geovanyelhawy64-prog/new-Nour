import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_calendar_engine.dart';
import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class DifnarHomeScreen extends StatefulWidget {
  const DifnarHomeScreen({super.key});

  @override
  State<DifnarHomeScreen> createState() => _DifnarHomeScreenState();
}

class _DifnarHomeScreenState extends State<DifnarHomeScreen> {
  late int _selectedMonth;
  late int _selectedDay;
  late Future<List<DifnarEntry>> _difnarFuture;
  late double _fontSize;
  bool _showAllForMonth = false;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    final today = CopticCalendarEngine.getLiturgicalDayInfo(DateTime.now()).copticDate;
    _selectedMonth = today.month;
    _selectedDay = today.day;
    _loadDifnar();
  }

  void _loadDifnar() {
    final dao = DatabaseService.instance.difnarDao;
    if (_showAllForMonth) {
      _difnarFuture = dao.getEntriesForMonth(_selectedMonth);
    } else {
      _difnarFuture = dao.getEntriesForDay(_selectedMonth, _selectedDay);
    }
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

  void _nextDay() {
    setState(() {
      _showAllForMonth = false;
      if (_selectedDay < 30) {
        _selectedDay++;
      } else {
        _selectedDay = 1;
        _selectedMonth = (_selectedMonth % 13) + 1;
      }
      _loadDifnar();
    });
  }

  void _prevDay() {
    setState(() {
      _showAllForMonth = false;
      if (_selectedDay > 1) {
        _selectedDay--;
      } else {
        _selectedMonth = _selectedMonth > 1 ? _selectedMonth - 1 : 13;
        _selectedDay = 30;
      }
      _loadDifnar();
    });
  }

  void _copyEntry(DifnarEntry entry) {
    final buffer = StringBuffer();
    buffer.writeln(entry.textCoptic);
    buffer.writeln();
    buffer.writeln(entry.textPhonetic);
    buffer.writeln();
    buffer.writeln(entry.textAr);
    Clipboard.setData(ClipboardData(text: buffer.toString()));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نسخ مديح الدفنار إلى الحافظة')),
      );
    }
  }

  void _openSearchDialog() {
    showSearch(
      context: context,
      delegate: _DifnarSearchDelegate(
        onSelect: (entry) {
          setState(() {
            _selectedMonth = entry.copticMonth;
            _selectedDay = entry.copticDay;
            _showAllForMonth = false;
            _loadDifnar();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdam = [DateTime.sunday, DateTime.monday, DateTime.tuesday].contains(DateTime.now().weekday);
    final tuneTitle = isAdam ? 'نغمة آدام' : 'نغمة واطس';
    final tuneSub = isAdam ? 'الأيام: الأحد، الاثنين، الثلاثاء' : 'الأيام: الأربعاء، الخميس، الجمعة، السبت';
    final monthName = CopticDate.monthNames[_selectedMonth - 1];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('كتاب الدفنار والمدائح'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded),
              tooltip: 'بحث في المدائح',
              onPressed: _openSearchDialog,
            ),
            IconButton(
              icon: const Icon(Icons.text_decrease_rounded),
              tooltip: 'تصغير الخط',
              onPressed: _decreaseFont,
            ),
            IconButton(
              icon: const Icon(Icons.text_increase_rounded),
              tooltip: 'تكبير الخط',
              onPressed: _increaseFont,
            ),
            const AppQuickMenu(),
          ],
        ),
        body: FutureBuilder<List<DifnarEntry>>(
          future: _difnarFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildDateHeader(monthName, tuneTitle, tuneSub),
                  const SizedBox(height: 32),
                  const LoadingView(message: 'جاري تحميل مدائح الدفنار...'),
                ],
              );
            }

            if (snapshot.hasError) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildDateHeader(monthName, tuneTitle, tuneSub),
                  const SizedBox(height: 16),
                  ErrorView(
                    message: 'حدث خطأ أثناء تحميل الدفنار',
                    onRetry: () => setState(() => _loadDifnar()),
                  ),
                ],
              );
            }

            final entries = snapshot.data ?? [];

            if (entries.isEmpty) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildDateHeader(monthName, tuneTitle, tuneSub),
                  const SizedBox(height: 16),
                  _buildEmptyCard(monthName),
                ],
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      _buildDateHeader(monthName, tuneTitle, tuneSub),
                      const SizedBox(height: 16),
                    ],
                  );
                }
                final entry = entries[index - 1];
                return _buildEntryCard(entry, context);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildDateHeader(String monthName, String tuneTitle, String tuneSub) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_right_rounded, size: 28),
                  tooltip: 'اليوم السابق',
                  onPressed: _prevDay,
                ),
                Column(
                  children: [
                    Text(
                      '$_selectedDay $monthName',
                      style: AppTypography.heading2.copyWith(color: AppColors.primary, fontSize: 20),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'كتاب الدفنار الطقسي',
                      style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded, size: 28),
                  tooltip: 'اليوم التالي',
                  onPressed: _nextDay,
                ),
              ],
            ),
            const Divider(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(Icons.music_note_rounded, size: 18, color: AppColors.gold),
                    const SizedBox(width: 6),
                    Text('$tuneTitle ($tuneSub)', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCard(String monthName) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.auto_stories_rounded, size: 54, color: AppColors.textSecondaryLight),
            const SizedBox(height: 16),
            Text(
              'لا يوجد مدائح مخصصة بالتحديد ليوم $_selectedDay $monthName',
              style: AppTypography.heading3.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'يمكنك استعراض كافة مدائح شهر $monthName أو البحث في المدائح.',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_month_rounded),
              label: Text('عرض مدائح شهر $monthName كاملة'),
              onPressed: () {
                setState(() {
                  _showAllForMonth = true;
                  _loadDifnar();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntryCard(DifnarEntry entry, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // شريط علوي مع زر النسخ
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.church_rounded, size: 20, color: AppColors.primary),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'طرح / مديح الدفنار',
                      style: AppTypography.heading3.copyWith(color: AppColors.primary, fontSize: 16),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.copy_rounded, size: 20, color: AppColors.textSecondaryLight),
                  tooltip: 'نسخ المديح',
                  onPressed: () => _copyEntry(entry),
                ),
              ],
            ),
            const Divider(height: 20),

            // النص القبطي
            if (entry.textCoptic.isNotEmpty) ...[
              Directionality(
                textDirection: TextDirection.ltr,
                child: SelectableText(
                  entry.textCoptic,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilyCoptic,
                    fontSize: _fontSize,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],

            // النطق القبطي المعرب
            if (entry.textPhonetic.isNotEmpty) ...[
              SelectableText(
                entry.textPhonetic,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: _fontSize * 0.95,
                  color: AppColors.accent,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
            ],

            // النص العربي المنظوم
            SelectableText(
              entry.textAr,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: _fontSize,
                height: 1.75,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DifnarSearchDelegate extends SearchDelegate<DifnarEntry?> {
  final Function(DifnarEntry) onSelect;

  _DifnarSearchDelegate({required this.onSelect});

  @override
  String get searchFieldLabel => 'ابحث في نصوص ومدائح الدفنار...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear_rounded),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_forward_rounded),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    if (query.trim().isEmpty) {
      return const Center(
        child: Text('اكتب كلمة للبحث في ٢٧٩ مديح وطرح بالدفنار'),
      );
    }

    return FutureBuilder<List<DifnarEntry>>(
      future: DatabaseService.instance.difnarDao.searchDifnar(query.trim()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final results = snapshot.data ?? [];
        if (results.isEmpty) {
          return const Center(child: Text('لم يتم العثور على نتائج'));
        }

        return Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: results.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final entry = results[index];
              final mName = (entry.copticMonth >= 1 && entry.copticMonth <= 13)
                  ? CopticDate.monthNames[entry.copticMonth - 1]
                  : '';

              return ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                tileColor: Theme.of(context).cardColor,
                title: Text(
                  entry.textAr.split('\n').first,
                  style: AppTypography.heading3.copyWith(fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${entry.copticDay} $mName',
                  style: AppTypography.caption.copyWith(color: AppColors.gold, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                onTap: () {
                  close(context, entry);
                  onSelect(entry);
                },
              );
            },
          ),
        );
      },
    );
  }
}
