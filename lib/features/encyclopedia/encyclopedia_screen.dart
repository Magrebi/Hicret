// lib/features/encyclopedia/encyclopedia_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/collection_set_card.dart';
import '../../shared/widgets/entity_badge.dart';
import '../../shared/widgets/entity_card.dart';
import 'encyclopedia_notifier.dart';

class EncyclopediaScreen extends ConsumerStatefulWidget {
  const EncyclopediaScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends ConsumerState<EncyclopediaScreen> {
  int _activeTab = 0; // 0 = Figures, 1 = Places, 2 = Collections

  static const Map<String, Offset> _regionCoordinates = {
    'North Africa': Offset(0.2, 0.5),
    'Egypt': Offset(0.35, 0.48),
    'Levant': Offset(0.45, 0.35),
    'Middle East': Offset(0.52, 0.38),
    'Arabian Peninsula': Offset(0.55, 0.62),
    'Hejaz': Offset(0.48, 0.58),
    'Mesopotamia': Offset(0.58, 0.34),
    'Persia': Offset(0.70, 0.42),
    'East': Offset(0.82, 0.50),
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = Theme.of(context).colorScheme.surface;
    final titleColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;

    final dataAsync = ref.watch(encyclopediaProvider);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: const Text('Encyclopedia'),
        automaticallyImplyLeading: false, // No back arrow (tab root)
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: titleColor,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.hub_outlined, color: isDark ? Colors.white : QkaTheme.neutral800),
            tooltip: 'Open Constellation Map',
            onPressed: () {
              ref.read(showEncyclopediaProvider.notifier).state = false;
            },
          ),
        ],
      ),
      body: dataAsync.when(
        data: (state) {
          return Column(
            children: [
              const SizedBox(height: 8),
              _buildSegmentedControl(context),
              const SizedBox(height: 16),
              Expanded(
                child: IndexedStack(
                  index: _activeTab,
                  children: [
                    _buildFiguresTab(state.figures),
                    _buildPlacesTab(state.places),
                    _buildCollectionsTab(state.collectionsAndSets),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: QkaTheme.teal400),
        ),
        error: (err, stack) => Center(
          child: Text('Error loading encyclopedia: $err'),
        ),
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? QkaTheme.neutral900 : QkaTheme.neutral50;
    final borderColor = isDark ? QkaTheme.neutral600 : QkaTheme.neutral200;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 36,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Row(
        children: List.generate(3, (index) {
          final label = ['Figures', 'Places', 'Collections'][index];
          final isActive = index == _activeTab;
          final activeColor = QkaTheme.teal400;
          final inactiveTextColor = isDark ? QkaTheme.neutral400 : QkaTheme.neutral600;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _activeTab = index;
                });
              },
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: isActive ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isActive ? Colors.white : inactiveTextColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFiguresTab(List<Entity> figures) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0, // Square cards
      ),
      itemCount: figures.length,
      itemBuilder: (context, index) {
        return EntityCard(entity: figures[index]);
      },
    );
  }

  Widget _buildPlacesTab(List<Entity> places) {
    final discoveredPlaces = places.where((p) => p.isDiscovered).toList();

    return CustomScrollView(
      slivers: [
        // Section A: Map Placeholder
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildMapPlaceholder(context, discoveredPlaces),
          ),
        ),

        // Section B: Location list below map
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final loc = discoveredPlaces[index];
                return _buildLocationRow(context, loc);
              },
              childCount: discoveredPlaces.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapPlaceholder(BuildContext context, List<Entity> unlockedLocations) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? QkaTheme.neutral800 : QkaTheme.neutral100;

    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          // Track regions to prevent overlaps
          final regionCounts = <String, int>{};

          return Stack(
            children: [
              // Stylized Map Icon & Label
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map_outlined,
                      size: 48,
                      color: isDark ? QkaTheme.neutral600 : QkaTheme.neutral200,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'World map coming soon',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 12,
                        color: isDark ? QkaTheme.neutral400 : QkaTheme.neutral600,
                      ),
                    ),
                  ],
                ),
              ),

              // Small teal pills for regions
              ...unlockedLocations.map((loc) {
                if (loc.region == null || loc.region!.isEmpty) return const SizedBox.shrink();

                final count = regionCounts[loc.region!] ?? 0;
                regionCounts[loc.region!] = count + 1;

                final offset = _regionCoordinates[loc.region] ?? const Offset(0.5, 0.5);

                // Offset slightly based on count to prevent exact overlap
                final double offsetX = (count % 2 == 0 ? 1 : -1) * (count ~/ 2) * 16.0;
                final double offsetY = (count % 2 == 0 ? -1 : 1) * (count ~/ 2) * 12.0;

                final left = (offset.dx * w + offsetX).clamp(20.0, w - 80.0);
                final top = (offset.dy * h + offsetY).clamp(20.0, h - 30.0);

                return Positioned(
                  left: left,
                  top: top,
                  width: 70,
                  height: 22,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: QkaTheme.teal400.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        loc.name,
                        style: const TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLocationRow(BuildContext context, Entity loc) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;
    final dividerColor = isDark ? QkaTheme.neutral800 : QkaTheme.neutral100;

    return InkWell(
      onTap: () => context.push('/encyclopedia/${loc.id}'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                const EntityBadge(
                  entityType: 'location',
                  size: BadgeSize.sm,
                  isDiscovered: true,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    loc.name,
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: nameColor,
                    ),
                  ),
                ),
                if (loc.region != null && loc.region!.isNotEmpty)
                  Text(
                    loc.region!,
                    style: const TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 12,
                      color: QkaTheme.neutral400,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: dividerColor,
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionsTab(List<CollectionSetItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: CollectionSetCard(
            id: item.id,
            name: item.name,
            discoveredCount: item.discoveredCount,
            totalCount: item.totalCount,
            isSet: item.isSet,
            isComplete: item.isComplete,
            rewardTitle: item.rewardTitle,
            onTap: () {
              context.push(
                '/encyclopedia/collection/${item.id}',
                extra: {
                  'isSet': item.isSet,
                  'name': item.name,
                },
              );
            },
          ),
        );
      },
    );
  }
}
