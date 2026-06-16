// lib/features/library/library_screen.dart

import 'package:flutter/material.dart' hide Theme;
import 'package:flutter/material.dart' as material show Theme;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/repositories/gamification_repository.dart';
import '../../core/theme/app_theme.dart';
import '../home/surah_data.dart';

/// Segment modeling within a reading route
class RouteSegment {
  final int surahNum;
  final int ayahStart;
  final int ayahEnd;
  const RouteSegment(this.surahNum, this.ayahStart, this.ayahEnd);
}

/// Static map defining the verse ranges for the 10 reading routes
final Map<String, List<RouteSegment>> routeSegments = {
  'exp_exodus': [
    const RouteSegment(28, 3, 46),
    const RouteSegment(20, 9, 98),
  ],
  'exp_wisdom_luqman': [
    const RouteSegment(31, 12, 19),
  ],
  'exp_covenant_abraham': [
    const RouteSegment(6, 74, 83),
    const RouteSegment(2, 124, 128),
    const RouteSegment(37, 99, 113),
  ],
  'exp_patience_triumph': [
    const RouteSegment(12, 4, 101),
  ],
  'exp_sleepers_signs': [
    const RouteSegment(18, 9, 26),
    const RouteSegment(18, 60, 82),
    const RouteSegment(18, 83, 98),
  ],
  'exp_creation_garden': [
    const RouteSegment(2, 30, 39),
    const RouteSegment(7, 11, 25),
  ],
  'exp_ark_salvation': [
    const RouteSegment(11, 25, 49),
    const RouteSegment(71, 1, 28),
  ],
  'exp_kingdom_grace': [
    const RouteSegment(27, 15, 44),
    const RouteSegment(38, 17, 40),
  ],
  'exp_pure_birth': [
    const RouteSegment(19, 1, 36),
    const RouteSegment(3, 33, 47),
  ],
  'exp_call_monotheism': [
    const RouteSegment(96, 1, 5),
    const RouteSegment(73, 1, 10),
    const RouteSegment(68, 1, 4),
  ],
};

/// StreamProvider exposing the list of reading routes reactively
final expeditionsListProvider = StreamProvider<List<Expedition>>((ref) {
  final repo = ref.watch(gamificationRepositoryProvider);
  return repo.watchAllExpeditions();
});

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  void _showRouteDetailsSheet(BuildContext context, Expedition exp, List<RouteSegment> segments) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final isDark = material.Theme.of(context).brightness == Brightness.dark;
        final sheetBgColor = isDark ? QkaTheme.neutral900 : QkaTheme.lightSurface;
        final titleColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;

        return Container(
          decoration: BoxDecoration(
            color: sheetBgColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Drag Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: QkaTheme.neutral200.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Expedition Title
              Text(
                exp.name,
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 8),
              
              // Expedition Description
              Text(
                exp.description,
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 14,
                  color: QkaTheme.neutral400,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              
              // Segments Header
              Text(
                'ROUTE SEGMENTS',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: isDark ? QkaTheme.neutral400 : QkaTheme.neutral600,
                ),
              ),
              const SizedBox(height: 12),
              
              // List of Segments
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: segments.length,
                  itemBuilder: (context, idx) {
                    final segment = segments[idx];
                    final surahItem = allSurahsStaticData.firstWhere(
                      (s) => s.number == segment.surahNum,
                      orElse: () => allSurahsStaticData[0],
                    );

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? QkaTheme.darkSurface : QkaTheme.neutral50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDark ? QkaTheme.neutral600 : QkaTheme.neutral200,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Segment ${idx + 1}: ${surahItem.transliteration}',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: titleColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Surah ${segment.surahNum}, Verses ${segment.ayahStart}–${segment.ayahEnd}',
                                style: const TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 12,
                                  color: QkaTheme.neutral400,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: QkaTheme.teal400,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            onPressed: () {
                              Navigator.pop(context); // Close sheet
                              context.push('/reader/${segment.surahNum}', extra: {'startAyah': segment.ayahStart});
                            },
                            child: const Text(
                              'Read',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = material.Theme.of(context).brightness == Brightness.dark;
    final expeditionsAsync = ref.watch(expeditionsListProvider);
    final titleColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;

    return Scaffold(
      backgroundColor: material.Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Reading Routes',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: expeditionsAsync.when(
        data: (expeditions) {
          if (expeditions.isEmpty) {
            return const Center(
              child: Text(
                'No reading routes available.',
                style: TextStyle(color: QkaTheme.neutral400),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: expeditions.length,
            itemBuilder: (context, index) {
              final exp = expeditions[index];
              final progressPct = (exp.progress * 100).round();
              final isCompleted = exp.isCompleted;
              final segments = routeSegments[exp.id] ?? [];

              // Style based on state
              final cardBorderColor = isCompleted
                  ? QkaTheme.teal400
                  : (isDark ? QkaTheme.neutral600 : QkaTheme.neutral200);

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isDark ? QkaTheme.darkSurface : QkaTheme.lightSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: cardBorderColor,
                    width: isCompleted ? 1.5 : 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _showRouteDetailsSheet(context, exp, segments),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon Badge
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? QkaTheme.teal400.withOpacity(0.1)
                                    : (isDark ? QkaTheme.neutral800 : QkaTheme.neutral50),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                isCompleted ? Icons.check_circle : Icons.explore_outlined,
                                color: isCompleted ? QkaTheme.teal400 : QkaTheme.neutral400,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            
                            // Title and status
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exp.name,
                                    style: TextStyle(
                                      fontFamily: 'SF Pro',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: titleColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    exp.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'SF Pro',
                                      fontSize: 13,
                                      color: QkaTheme.neutral400,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Progress bar block
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(99),
                                child: LinearProgressIndicator(
                                  value: exp.progress,
                                  minHeight: 4,
                                  backgroundColor: isDark ? QkaTheme.neutral800 : QkaTheme.neutral100,
                                  valueColor: AlwaysStoppedAnimation<Color>(QkaTheme.teal400),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              isCompleted ? 'Complete' : '$progressPct%',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isCompleted ? QkaTheme.teal400 : QkaTheme.neutral400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: QkaTheme.teal400),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Error loading routes: $err',
            style: const TextStyle(color: QkaTheme.teal400),
          ),
        ),
      ),
    );
  }
}
