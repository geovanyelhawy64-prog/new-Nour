import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../../../core/coptic_calendar/coptic_month.dart';
import '../../../../core/services/database_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class SynaxariumHomeScreen extends StatefulWidget {
  const SynaxariumHomeScreen({super.key});

  @override
  State<SynaxariumHomeScreen> createState() => _SynaxariumHomeScreenState();
}

class _SynaxariumHomeScreenState extends State<SynaxariumHomeScreen> {
  late CopticDate _selectedDate;
  late Future<List<SynaxariumEntry>> _entriesFuture;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<SynaxariumEntry>? _searchResults;

  @override
  void initState() {
    super.initState();
    _selectedDate = CopticDate.fromDateTime(DateTime.now());
    _loadEntries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadEntries() {
    _entriesFuture = DatabaseService.instance.synaxariumDao.getEntriesForDay(
      _selectedDate.month,
      _selectedDate.day,
    );
  }

  void _nextDay() {
    setState(() {
      _selectedDate = _selectedDate.nextDay();
      _isSearching = false;
      _loadEntries();
    });
  }

  void _prevDay() {
    setState(() {
      _selectedDate = _selectedDate.previousDay();
      _isSearching = false;
      _loadEntries();
    });
  }

  void _goToToday() {
    setState(() {
      _selectedDate = CopticDate.fromDateTime(DateTime.now());
      _isSearching = false;
      _loadEntries();
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() => _searchResults = null);
      return;
    }
    final results = await DatabaseService.instance.synaxariumDao.searchEntries(query.trim());
    setState(() {
      _searchResults = results;
    });
  }

  void _showDatePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        int tempMonth = _selectedDate.month;
        int tempDay = _selectedDate.day;

        return StatefulBuilder(
          builder: (context, setModalState) {
            final maxDays = tempMonth <= 12 ? 30 : 6;
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'اختر يوماً قبطياً',
                    style: AppTypography.heading3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Month Dropdown
                      DropdownButton<int>(
                        value: tempMonth,
                        items: List.generate(13, (idx) {
                          final m = idx + 1;
                          final name = CopticMonth.fromNumber(m).nameAr;
                          return DropdownMenuItem(value: m, child: Text(name));
                        }),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() {
                              tempMonth = val;
                              if (tempDay > (tempMonth <= 12 ? 30 : 6)) {
                                tempDay = 1;
                              }
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 24),
                      // Day Dropdown
                      DropdownButton<int>(
                        value: tempDay.clamp(1, maxDays),
                        items: List.generate(maxDays, (idx) {
                          final d = idx + 1;
                          return DropdownMenuItem(value: d, child: Text('$d'));
                        }),
                        onChanged: (val) {
                          if (val != null) setModalState(() => tempDay = val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    onPressed: () {
                      Navigator.pop(ctx);
                      setState(() {
                        _selectedDate = CopticDate(
                          year: _selectedDate.year,
                          month: tempMonth,
                          day: tempDay,
                        );
                        _loadEntries();
                      });
                    },
                    child: const Text('عرض السنكسار', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'feast':
        return Icons.celebration_rounded;
      case 'martyr':
        return Icons.shield_rounded;
      case 'patriarch':
        return Icons.account_balance_rounded;
      case 'bishop':
        return Icons.person_rounded;
      case 'monk':
        return Icons.church_rounded;
      case 'event':
        return Icons.event_note_rounded;
      case 'saint':
      default:
        return Icons.star_rounded;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'feast':
        return const Color(0xFFE65100);
      case 'martyr':
        return const Color(0xFFC62828);
      case 'patriarch':
        return const Color(0xFF6A1B9A);
      case 'bishop':
        return const Color(0xFF1565C0);
      case 'monk':
        return const Color(0xFF00695C);
      case 'event':
        return const Color(0xFF2E7D32);
      case 'saint':
      default:
        return const Color(0xFFB8952E);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'ابحث في السنكسار والقديسين...',
                  border: InputBorder.none,
                ),
                onChanged: _performSearch,
              )
            : const Text('التذكارات (السنكسار القبطي)'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded),
            tooltip: _isSearching ? 'إغلاق البحث' : 'بحث',
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _searchResults = null;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.today_rounded),
            tooltip: 'اليوم',
            onPressed: _goToToday,
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month_rounded),
            tooltip: 'اختر يوماً',
            onPressed: _showDatePicker,
          ),
          const AppQuickMenu(),
        ],
      ),
      body:  Column(
          children: [
            // Coptic Date Navigation Bar
            if (!_isSearching)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: AppColors.primary.withValues(alpha: 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      tooltip: 'اليوم السابق',
                      onPressed: _prevDay,
                    ),
                    InkWell(
                      onTap: _showDatePicker,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Column(
                          children: [
                            Text(
                              _selectedDate.formatArabic(),
                              style: AppTypography.heading3.copyWith(color: AppColors.primaryDark),
                            ),
                            Text(
                              'اضغط لاختيار يوم آخر',
                              style: AppTypography.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                      tooltip: 'اليوم التالي',
                      onPressed: _nextDay,
                    ),
                  ],
                ),
              ),

            // Content List
            Expanded(
              child: _isSearching
                  ? _buildSearchResults()
                  : FutureBuilder<List<SynaxariumEntry>>(
                      future: _entriesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const LoadingView(message: 'جاري تحميل سير السنكسار...');
                        }

                        if (snapshot.hasError) {
                          return ErrorView(
                            message: 'حدث خطأ أثناء تحميل سير السنكسار',
                            onRetry: () => setState(() => _loadEntries()),
                          );
                        }

                        final entries = snapshot.data ?? [];
                        if (entries.isEmpty) {
                          return EmptyView(
                            message: 'لا توجد تذكارات مسجلة لهذا اليوم',
                            subtitle: _selectedDate.formatArabic(),
                            icon: Icons.auto_stories_rounded,
                          );
                        }

                        return RefreshIndicator(
                          onRefresh: () async => setState(() => _loadEntries()),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: entries.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final entry = entries[index];
                            final color = _getColorForType(entry.type);
                            final icon = _getIconForType(entry.type);

                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () => context.push(
                                  '/synaxarium/story/${_selectedDate.month}/${_selectedDate.day}',
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Icon(icon, color: color, size: 26),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              entry.title,
                                              style: AppTypography.heading3.copyWith(fontSize: 16),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              entry.shortText,
                                              style: AppTypography.caption.copyWith(fontSize: 13),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 14,
                                        color: AppColors.textSecondaryLight,
                                      ),
                                    ],
                                  ),
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
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults == null) {
      return const Center(child: Text('اكتب كلمة للبحث في السنكسار...'));
    }
    if (_searchResults!.isEmpty) {
      return const Center(child: Text('لا توجد نتائج مطابقة لبحثك'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults!.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, idx) {
        final entry = _searchResults![idx];
        final monthName = CopticMonth.fromNumber(entry.copticMonth).nameAr;
        return ListTile(
          tileColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(entry.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('${entry.copticDay} $monthName - ${entry.shortText}', maxLines: 2),
          onTap: () => context.push('/synaxarium/story/${entry.copticMonth}/${entry.copticDay}'),
        );
      },
    );
  }
}
