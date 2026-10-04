import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/monastery.dart';
import '../../../data/repositories/monasteries_repository.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class MonasteriesScreen extends StatefulWidget {
  const MonasteriesScreen({super.key});

  @override
  State<MonasteriesScreen> createState() => _MonasteriesScreenState();
}

class _MonasteriesScreenState extends State<MonasteriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final MonasteriesRepository _repo = MonasteriesRepository();
  String _searchQuery = '';
  List<Monastery> _monasteries = [];
  List<Monastery> _churches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    final monasteries = await _repo.getMonasteries();
    final churches = await _repo.getChurches();
    if (mounted) {
      setState(() {
        _monasteries = monasteries;
        _churches = churches;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Monastery> _filterSites(List<Monastery> sites) {
    if (_searchQuery.trim().isEmpty) return sites;
    final q = _searchQuery.trim().toLowerCase();
    return sites.where((s) {
      return s.nameAr.toLowerCase().contains(q) ||
          s.location.toLowerCase().contains(q) ||
          s.founder.toLowerCase().contains(q) ||
          s.patronSaints.toLowerCase().contains(q) ||
          s.historySummary.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    const accentGold = Color(0xFFD4AF37);
    final allMonasteries = _filterSites(_monasteries);
    final allChurches = _filterSites(_churches);

    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل الأديرة والكنائس الأثرية'),
        actions: const [
          AppQuickMenu(),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: accentGold,
          labelColor: accentGold,
          tabs: [
            Tab(
              icon: const Icon(Icons.castle_rounded, size: 20),
              text: 'الأديرة العامرة (${allMonasteries.length})',
            ),
            Tab(
              icon: const Icon(Icons.church_rounded, size: 20),
              text: 'الكنائس الأثرية (${allChurches.length})',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث باسم الدير، الكنيسة، القديس أو الموقع...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),

          // محتوى التبويبات
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSitesList(allMonasteries, theme, accentGold, 'لم يتم العثور على أديرة مطابقة للبحث.'),
                _buildSitesList(allChurches, theme, accentGold, 'لم يتم العثور على كنائس مطابقة للبحث.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSitesList(
    List<Monastery> sites,
    ThemeData theme,
    Color accentGold,
    String emptyMessage,
  ) {
    if (sites.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            emptyMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      itemCount: sites.length,
      itemBuilder: (context, index) {
        final site = sites[index];
        return _buildSiteCard(site, theme, accentGold);
      },
    );
  }

  Widget _buildSiteCard(Monastery site, ThemeData theme, Color accentGold) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          context.push('/monasteries/${site.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentGold.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      site.isMonastery ? Icons.castle_rounded : Icons.church_rounded,
                      color: accentGold,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          site.nameAr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        if (site.nameCoptic != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            site.nameCoptic!,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontFamily: 'Coptic',
                              fontSize: 13,
                              color: Color(0xFFD4AF37),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      site.century.split('(').first.trim(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // الموقع
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_rounded, size: 15, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      site.location,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // الشفيع والعيد
              Row(
                children: [
                  Icon(Icons.celebration_rounded, size: 15, color: accentGold),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'العيد: ${site.feastDate}',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
