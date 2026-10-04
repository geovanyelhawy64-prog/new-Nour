import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<Bookmark> _allBookmarks = [];
  List<Bookmark> _filteredBookmarks = [];
  bool _isLoading = true;
  String? _selectedType;

  final _typeFilters = [
    {'id': null, 'label': 'الكل'},
    {'id': 'bible', 'label': 'الكتاب المقدس'},
    {'id': 'agpeya', 'label': 'الأجبية'},
    {'id': 'liturgy', 'label': 'الخولاجي'},
    {'id': 'saints', 'label': 'القديسين'},
    {'id': 'prayers', 'label': 'الصلوات'},
    {'id': 'theology', 'label': 'العقيدة'},
  ];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    setState(() => _isLoading = true);
    final items = await DatabaseService.bookmarksDao.getAllBookmarks();
    if (mounted) {
      setState(() {
        _allBookmarks = items;
        _applyFilter();
        _isLoading = false;
      });
    }
  }

  void _applyFilter() {
    if (_selectedType == null) {
      _filteredBookmarks = _allBookmarks;
    } else {
      _filteredBookmarks = _allBookmarks.where((b) => b.contentType == _selectedType).toList();
    }
  }

  void _navigateToBookmark(Bookmark item) {
    switch (item.contentType) {
      case 'bible':
        final parts = item.contentId.split(RegExp(r'[/_]'));
        if (parts.length >= 2) {
          context.push('/bible/read/${parts[0]}/${parts[1]}');
        } else if (parts.isNotEmpty) {
          context.push('/bible/chapters/${parts[0]}');
        }
        break;
      case 'agpeya':
        context.push('/agpeya/hour/${item.contentId}');
        break;
      case 'liturgy':
        context.push('/liturgy/read/${item.contentId}');
        break;
      case 'saints':
        context.push('/saints/detail/${item.contentId}');
        break;
      case 'prayers':
        context.push('/prayers/category/${item.contentId}');
        break;
      case 'theology':
        context.push('/theology/article/${item.contentId}');
        break;
      default:
        break;
    }
  }

  Future<void> _deleteBookmark(int id) async {
    HapticFeedback.lightImpact();
    await DatabaseService.bookmarksDao.removeBookmark(id);
    _loadBookmarks();
  }

  Future<void> _exportBackup() async {
    HapticFeedback.selectionClick();
    final list = _allBookmarks.map((b) => {
      'contentType': b.contentType,
      'contentId': b.contentId,
      'displayTitle': b.displayTitle,
      'note': b.note,
      'createdAt': b.createdAt.toIso8601String(),
    }).toList();

    final jsonStr = jsonEncode(list);
    Clipboard.setData(ClipboardData(text: jsonStr));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نسخ النسخة الاحتياطية للمحفوظات (JSON) إلى الحافظة بنجاح')),
      );
    }
  }

  Future<void> _importBackup() async {
    HapticFeedback.selectionClick();
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text?.trim() ?? '';
    if (text.isEmpty) {
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
        final exists = await DatabaseService.bookmarksDao.isBookmarked(cType, cId);
        if (!exists) {
          await DatabaseService.bookmarksDao.addBookmark(
            contentType: cType,
            contentId: cId,
            displayTitle: map['displayTitle'] as String,
            note: map['note'] as String?,
          );
          added++;
        }
      }
      _loadBookmarks();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم استرجاع $added عنصر من النسخة الاحتياطية')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('خطأ في تنسيق النسخة الاحتياطية')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('المحفوظات والمفضلة'),
          actions: [
            IconButton(
              icon: const Icon(Icons.upload_file_rounded),
              tooltip: 'نسخ احتياطي للحافظة',
              onPressed: _allBookmarks.isNotEmpty ? _exportBackup : null,
            ),
            IconButton(
              icon: const Icon(Icons.download_rounded),
              tooltip: 'استرجاع من الحافظة',
              onPressed: _importBackup,
            ),
            const AppQuickMenu(),
          ],
        ),
        body: Column(
          children: [
            // فلتر نوع المحتوى
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                itemCount: _typeFilters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filter = _typeFilters[index];
                  final isSelected = _selectedType == filter['id'];
                  return ChoiceChip(
                    label: Text(filter['label'] as String),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        _selectedType = filter['id'];
                        _applyFilter();
                      });
                    },
                  );
                },
              ),
            ),
            const Divider(height: 1),

            // قائمة المحفوظات
            Expanded(
              child: _isLoading
                  ? const LoadingView(message: 'جاري تحميل المحفوظات...')
                  : _filteredBookmarks.isEmpty
                      ? const EmptyView(
                          message: 'لا توجد محفوظات حتى الآن',
                          subtitle: 'يمكنك حفظ الآيات والصلوات بالضغط على أيقونة الإشارة المرجعية',
                          icon: Icons.bookmark_border_rounded,
                        )
                      : RefreshIndicator(
                          onRefresh: _loadBookmarks,
                          child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredBookmarks.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final item = _filteredBookmarks[index];
                            return Dismissible(
                              key: Key('bm_${item.id}'),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 20),
                                child: const Icon(Icons.delete_rounded, color: Colors.white),
                              ),
                              onDismissed: (_) => _deleteBookmark(item.id),
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                child: ListTile(
                                  leading: const Icon(Icons.bookmark_rounded, color: AppColors.primary),
                                  title: Text(
                                    item.displayTitle,
                                    style: AppTypography.heading3.copyWith(fontSize: 16),
                                  ),
                                  subtitle: item.note != null && item.note!.isNotEmpty
                                      ? Text(item.note!, style: AppTypography.bodySmall)
                                      : null,
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete_outline_rounded, size: 20, color: Colors.red),
                                    onPressed: () => _deleteBookmark(item.id),
                                  ),
                                  onTap: () => _navigateToBookmark(item),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
            ),
          ],
        ),
      );
  }
}
