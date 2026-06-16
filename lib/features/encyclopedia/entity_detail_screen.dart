// lib/features/encyclopedia/entity_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/entity_badge.dart';
import '../../shared/widgets/mini_relation_graph.dart';
import '../home/surah_data.dart';
import 'encyclopedia_notifier.dart';

class EntityDetailScreen extends ConsumerStatefulWidget {
  final String entityId;

  const EntityDetailScreen({
    Key? key,
    required this.entityId,
  }) : super(key: key);

  @override
  ConsumerState<EntityDetailScreen> createState() => _EntityDetailScreenState();
}

class _EntityDetailScreenState extends ConsumerState<EntityDetailScreen> {
  bool _showAllTriggers = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = Theme.of(context).colorScheme.surface;
    final titleColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;
    final bodyColor = isDark ? QkaTheme.neutral200 : QkaTheme.neutral600;
    final dividerColor = isDark ? QkaTheme.neutral800 : QkaTheme.neutral100;
    final detailAsync = ref.watch(entityDetailProvider(widget.entityId));

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: isDark ? Colors.white : QkaTheme.neutral800,
            size: 28,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: detailAsync.when(
        data: (detail) {
          final entity = detail.entity;
          final isPlaceholder = entity.description.contains('// TODO: Tafsir') ||
              entity.description.contains('Tafsir');

          // Group triggers by Surah
          final Map<int, List<int>> groupedTriggers = {};
          final Map<int, Verse> firstVerses = {};
          for (final event in detail.triggers) {
            final s = event.trigger.surahNum;
            final a = event.trigger.ayahNum;
            groupedTriggers.putIfAbsent(s, () => []).add(a);
            firstVerses.putIfAbsent(s, () => event.verse);
          }

          final sortedSurahNums = groupedTriggers.keys.toList()..sort();
          final displayedSurahNums = _showAllTriggers
              ? sortedSurahNums
              : sortedSurahNums.take(5).toList();

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- HERO SECTION ---
                Text(
                  entity.name,
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: EntityBadge(
                    entityType: entity.type,
                    size: BadgeSize.lg,
                    isDiscovered: true,
                  ),
                ),
                const SizedBox(height: 24),
                Divider(height: 1, thickness: 0.5, color: dividerColor),
                const SizedBox(height: 24),

                // --- DESCRIPTION SECTION ---
                Text(
                  entity.description,
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 16,
                    height: 1.5,
                    fontStyle: isPlaceholder ? FontStyle.italic : FontStyle.normal,
                    color: isPlaceholder
                        ? QkaTheme.neutral400
                        : bodyColor,
                  ),
                ),
                const SizedBox(height: 32),

                // --- APPEARS IN SECTION ---
                if (sortedSurahNums.isNotEmpty) ...[
                  Text(
                    'Appears in',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...displayedSurahNums.map((surahNum) {
                    final ayahs = groupedTriggers[surahNum]!..sort();
                    final firstAyah = ayahs.first;
                    final surahName = allSurahsStaticData
                        .firstWhere(
                          (s) => s.number == surahNum,
                          orElse: () => SurahData(
                            number: surahNum,
                            transliteration: 'Surah $surahNum',
                            englishMeaning: '',
                            arabicName: '',
                            totalAyahs: 0,
                          ),
                        )
                        .transliteration;

                    String ayahsLabel;
                    if (ayahs.length == 1) {
                      ayahsLabel = 'Ayah ${ayahs.first}';
                    } else {
                      bool isContiguous = true;
                      for (int i = 0; i < ayahs.length - 1; i++) {
                        if (ayahs[i + 1] - ayahs[i] != 1) {
                          isContiguous = false;
                          break;
                        }
                      }
                      if (isContiguous) {
                        ayahsLabel = 'Ayahs ${ayahs.first}–${ayahs.last}';
                      } else {
                        ayahsLabel = 'Ayahs ${ayahs.join(", ")}';
                      }
                    }

                    final verse = firstVerses[surahNum];
                    final snippet = (verse != null && verse.isRead)
                        ? verse.textTranslation
                        : 'Keep reading to unlock context...';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDark ? QkaTheme.neutral800 : QkaTheme.neutral100,
                          width: 0.5,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          context.push('/reader/$surahNum', extra: {'startAyah': firstAyah});
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Surah $surahNum, $surahName',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: isDark ? QkaTheme.neutral100 : QkaTheme.neutral800,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      ayahsLabel,
                                      style: const TextStyle(
                                        fontFamily: 'SF Pro',
                                        fontSize: 13,
                                        color: QkaTheme.neutral400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  snippet,
                                  style: TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: (verse != null && verse.isRead)
                                        ? QkaTheme.neutral400
                                        : QkaTheme.neutral400.withOpacity(0.7),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.chevron_right,
                                color: QkaTheme.neutral400,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  if (sortedSurahNums.length > 5) ...[
                    const SizedBox(height: 4),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _showAllTriggers = !_showAllTriggers;
                          });
                        },
                        child: Text(
                          _showAllTriggers ? 'See less' : 'See all',
                          style: const TextStyle(
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w600,
                            color: QkaTheme.teal400,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                ],

                // --- CONNECTED TO SECTION ---
                if (detail.connectedEntities.isNotEmpty) ...[
                  Text(
                    'Connected to',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  MiniRelationGraph(
                    centerEntity: entity,
                    connectedEntities: detail.connectedEntities,
                  ),
                  const SizedBox(height: 32),
                ],

                // --- SEE IN CONSTELLATION BUTTON ---
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isDark ? QkaTheme.neutral600 : QkaTheme.neutral200,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(
                      Icons.hub_outlined,
                      size: 18,
                      color: isDark ? Colors.white : QkaTheme.neutral800,
                    ),
                    label: Text(
                      'See in Constellation',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : QkaTheme.neutral800,
                      ),
                    ),
                    onPressed: () {
                      ref.read(showEncyclopediaProvider.notifier).state = false;
                      ref.read(highlightedEntityIdProvider.notifier).highlight(entity.id);
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: QkaTheme.teal400),
        ),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Error loading entity details: $err',
              style: const TextStyle(fontFamily: 'SF Pro', color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
