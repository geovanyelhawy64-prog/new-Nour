import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/holy_place.dart';
import '../providers/holy_places_providers.dart';

class HolyPlacesHomeScreen extends ConsumerStatefulWidget {
  const HolyPlacesHomeScreen({super.key});

  @override
  ConsumerState<HolyPlacesHomeScreen> createState() => _HolyPlacesHomeScreenState();
}

class _HolyPlacesHomeScreenState extends ConsumerState<HolyPlacesHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedGov;

  final _tabs = [
    {'title': 'الكل', 'type': null},
    {'title': 'أديرة الرهبان', 'type': 'monasteryMen'},
    {'title': 'أديرة الراهبات', 'type': 'monasteryWomen'},
    {'title': 'العائلة المقدسة', 'type': 'holyFamily'},
    {'title': 'كنائس أثرية', 'type': 'historicChurch'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final goldColor = isDark ? const Color(0xFFD4A843) : const Color(0xFFC49B3C);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الأماكن المقدسة والأديرة'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: goldColor,
          labelColor: goldColor,
          unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[700],
          tabs: _tabs.map((t) => Tab(text: t['title'] as String)).toList(),
          onTap: (_) => setState(() {}),
        ),
      ),
      body: Column(
        children: [
          // Search & Filter Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث عن دير، كنيسة، قديس، أو محافظة...',
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val.trim()),
            ),
          ),

          // Governorate chips
          Consumer(
            builder: (context, ref, _) {
              final govsAsync = ref.watch(holyPlaceGovernoratesProvider);
              return govsAsync.maybeWhen(
                data: (govs) {
                  if (govs.isEmpty) return const SizedBox.shrink();
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Row(
                      children: [
                        FilterChip(
                          label: const Text('جميع المحافظات'),
                          selected: _selectedGov == null,
                          onSelected: (_) => setState(() => _selectedGov = null),
                        ),
                        const SizedBox(width: 8),
                        ...govs.map(
                          (g) => Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: FilterChip(
                              label: Text(g),
                              selected: _selectedGov == g,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedGov = selected ? g : null;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),

          // Places List
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final currentType = _tabs[_tabController.index]['type'];
                final allAsync = ref.watch(allHolyPlacesProvider);

                return allAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('خطأ: $e')),
                  data: (places) {
                    var filtered = places;

                    if (currentType != null) {
                      filtered = filtered.where((p) => p.type.name == currentType).toList();
                    }

                    if (_selectedGov != null) {
                      filtered = filtered.where((p) => p.governorate == _selectedGov).toList();
                    }

                    if (_searchQuery.isNotEmpty) {
                      final q = _searchQuery.toLowerCase();
                      filtered = filtered.where((p) =>
                          p.nameAr.toLowerCase().contains(q) ||
                          p.governorate.toLowerCase().contains(q) ||
                          (p.patronSaint?.toLowerCase().contains(q) ?? false) ||
                          p.history.toLowerCase().contains(q)).toList();
                    }

                    if (filtered.isEmpty) {
                      return const Center(
                        child: Text(
                          'لا توجد نتائج مطابقة',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final p = filtered[index];
                        return _HolyPlaceCard(place: p);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HolyPlaceCard extends StatelessWidget {
  final HolyPlace place;
  const _HolyPlaceCard({required this.place});

  IconData _getTypeIcon(HolyPlaceType type) {
    switch (type) {
      case HolyPlaceType.monasteryMen:
      case HolyPlaceType.monasteryWomen:
        return Icons.castle_rounded;
      case HolyPlaceType.holyFamily:
        return Icons.explore_rounded;
      case HolyPlaceType.historicChurch:
        return Icons.church_rounded;
      case HolyPlaceType.shrine:
        return Icons.auto_awesome;
    }
  }

  Color _getTypeColor(HolyPlaceType type) {
    switch (type) {
      case HolyPlaceType.monasteryMen:
        return const Color(0xFFC49B3C);
      case HolyPlaceType.monasteryWomen:
        return const Color(0xFF8E44AD);
      case HolyPlaceType.holyFamily:
        return const Color(0xFF2E7D32);
      case HolyPlaceType.historicChurch:
        return const Color(0xFF1565C0);
      case HolyPlaceType.shrine:
        return const Color(0xFFD84315);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _getTypeColor(place.type);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: color.withValues(alpha: 0.3)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => context.push('/holy-places/${place.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isDark ? 0.25 : 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(_getTypeIcon(place.type), color: color, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            place.nameAr,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            place.type.labelAr,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 15, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          place.governorate,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.grey[400] : Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (place.century != null) ...[
                          const SizedBox(width: 10),
                          Icon(Icons.history_toggle_off, size: 15, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            place.century!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.grey[400] : Colors.grey[700],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      place.locationDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
