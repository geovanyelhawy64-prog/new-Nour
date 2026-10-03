import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LibraryPortalsScreen extends StatelessWidget {
  const LibraryPortalsScreen({super.key});

  static const portals = <LibraryPortal>[
    LibraryPortal(
      id: 'prayer',
      title: 'الصلوات والطقوس',
      description: 'الأجبية والقداسات والبصخة والأسرار',
      icon: Icons.church_outlined,
      items: [
        LibraryItem('الأجبية', Icons.schedule_outlined, '/agpeya'),
        LibraryItem('القداسات', Icons.church_outlined, '/liturgy'),
        LibraryItem('البصخة', Icons.menu_book_outlined, '/pascha'),
        LibraryItem('الأسرار والطقوس', Icons.water_drop_outlined, '/sacraments'),
        LibraryItem('صلوات المناسبات', Icons.volunteer_activism_outlined, '/prayers'),
      ],
    ),
    LibraryPortal(
      id: 'word',
      title: 'الكلمة',
      description: 'الكتاب المقدس والقراءات والعقيدة',
      icon: Icons.menu_book_outlined,
      items: [
        LibraryItem('الكتاب المقدس والتفاسير', Icons.menu_book_outlined, '/bible'),
        LibraryItem('قراءات اليوم', Icons.today_outlined, '/katameros'),
        LibraryItem('خطة القراءة', Icons.checklist_outlined, '/reading-plan'),
        LibraryItem('العقيدة', Icons.school_outlined, '/theology'),
      ],
    ),
    LibraryPortal(
      id: 'heritage',
      title: 'التراث والألحان',
      description: 'التسبحة والألحان وسير الكنيسة',
      icon: Icons.library_music_outlined,
      items: [
        LibraryItem('التسبحة', Icons.nightlight_outlined, '/psali'),
        LibraryItem('الألحان', Icons.library_music_outlined, '/hymns'),
        LibraryItem('السنكسار', Icons.auto_stories_outlined, '/synaxarium'),
        LibraryItem('الدفنار', Icons.collections_bookmark_outlined, '/difnar'),
        LibraryItem('سير الآباء والقاموس القبطي', Icons.people_outline, '/saints'),
      ],
    ),
    LibraryPortal(
      id: 'spiritual',
      title: 'الحياة الروحية',
      description: 'التعزية والتقويم وسجل الصلاة والأديرة',
      icon: Icons.spa_outlined,
      items: [
        LibraryItem('التعزية الروحية', Icons.favorite_border, '/prayers/feelings'),
        LibraryItem('التقويم والأصوام', Icons.calendar_month_outlined, '/feasts'),
        LibraryItem('سجل الصلاة', Icons.fact_check_outlined, '/prayer-tracker'),
        LibraryItem('الأديرة والمزارات', Icons.place_outlined, '/holy-places'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المكتبة')),
      body: ListView.separated(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 32),
        itemCount: portals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final portal = portals[index];
          return Semantics(
            button: true,
            label: '${portal.title}، ${portal.description}',
            child: Card(
              margin: EdgeInsets.zero,
              child: InkWell(
                onTap: () => context.push('/library/${portal.id}'),
                borderRadius: BorderRadius.circular(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 96),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(16),
                    child: Row(
                      children: [
                        Icon(portal.icon, size: 32),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(portal.title, style: Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 4),
                              Text(portal.description),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LibraryPortalScreen extends StatelessWidget {
  const LibraryPortalScreen({super.key, required this.portalId});

  final String portalId;

  @override
  Widget build(BuildContext context) {
    final portal = LibraryPortalsScreen.portals.firstWhere(
      (candidate) => candidate.id == portalId,
      orElse: () => LibraryPortalsScreen.portals.first,
    );
    return Scaffold(
      appBar: AppBar(title: Text(portal.title)),
      body: ListView.separated(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 32),
        itemCount: portal.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = portal.items[index];
          return ListTile(
            minTileHeight: 64,
            leading: Icon(item.icon),
            title: Text(item.title),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () => context.push(item.route),
          );
        },
      ),
    );
  }
}

class LibraryPortal {
  const LibraryPortal({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.items,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final List<LibraryItem> items;
}

class LibraryItem {
  const LibraryItem(this.title, this.icon, this.route);

  final String title;
  final IconData icon;
  final String route;
}
