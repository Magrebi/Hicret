// lib/features/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column;

import '../../core/local_db/database_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../../shared/widgets/continue_reading_card.dart';
import '../../shared/widgets/surah_list_row.dart';
import '../constellation/constellation_screen.dart';
import '../library/library_screen.dart';
import '../profile/profile_screen.dart';
import '../reader/reader_notifier.dart';
import '../search/search_screen.dart';
import 'home_notifier.dart';
import 'surah_data.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentTab = 0;
  
  // Track visited tabs to lazily load tab views (specifically ConstellationScreen)
  final Map<int, bool> _visitedTabs = {0: true};

  Widget _buildTabBody(int index) {
    switch (index) {
      case 0:
        return const HomeBody();
      case 1:
        return const SearchScreen();
      case 2:
        return const ConstellationScreen();
      case 3:
        return const LibraryScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const HomeBody();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentTab,
        children: List.generate(5, (index) {
          final isVisited = _visitedTabs[index] ?? false;
          if (!isVisited) {
            return const SizedBox.shrink(); // Lazily loaded, not initialized yet
          }
          return _buildTabBody(index);
        }),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
            _visitedTabs[index] = true;
          });
        },
        isDarkTheme: isDark,
      ),
    );
  }
}

/// The actual landing page content (Tab 0)
class HomeBody extends ConsumerStatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends ConsumerState<HomeBody> {
  String _searchQuery = '';
  bool _sortByJuz = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSortSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final sheetBgColor = isDark ? QkaTheme.neutral900 : QkaTheme.lightSurface;
        
        return Container(
          decoration: BoxDecoration(
            color: sheetBgColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sort Preferences',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : QkaTheme.neutral800,
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: Text(
                  'Sort by Juz Number',
                  style: TextStyle(
                    color: isDark ? Colors.white : QkaTheme.neutral800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: const Text('Group and display surahs by Juz sections'),
                value: _sortByJuz,
                activeColor: QkaTheme.teal400,
                onChanged: (val) {
                  setState(() {
                    _sortByJuz = val;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Evaluates and navigates to the reader screen for a given surah.
  /// Start ayah defaults to the user's maximum read verse index or 1.
  Future<void> _handleSurahTap(int surahNumber) async {
    final db = ref.read(appDatabaseProvider);
    
    // Query maximum read ayah for this surah from the database
    final readVerses = await (db.select(db.verses)
          ..where((t) => t.surahNum.equals(surahNumber) & t.isRead.equals(true))
          ..orderBy([(t) => OrderingTerm(expression: t.ayahNum, mode: OrderingMode.desc)]))
        .get();

    final int startAyah = readVerses.isNotEmpty ? readVerses.first.ayahNum : 1;
    
    if (mounted) {
      context.push('/reader/$surahNumber', extra: {'startAyah': startAyah});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Watching reactive progress and surah list providers
    final progressAsync = ref.watch(userProgressProvider);
    final surahsAsync = ref.watch(surahListProvider);
    final readerState = ref.watch(readerStateNotifierProvider);

    final scaffoldBg = Theme.of(context).colorScheme.surface;
    final titleColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;
    final subtitleColor = QkaTheme.neutral400;

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: progressAsync.when(
        data: (progress) {
          final isStateA = progress.totalAyahsRead == 0;

          return surahsAsync.when(
            data: (surahList) {
              // 1. Filter the Surah List based on search query (State A only)
              var filteredList = isStateA
                  ? surahList.where((item) {
                      final query = _searchQuery.toLowerCase();
                      return item.number.toString().contains(query) ||
                             item.transliteration.toLowerCase().contains(query) ||
                             item.englishMeaning.toLowerCase().contains(query) ||
                             item.arabicName.contains(query);
                    }).toList()
                  : List<SurahListItem>.from(surahList);

              // 2. Sort the Surah List
              filteredList.sort((a, b) {
                if (_sortByJuz) {
                  final juzA = getJuzForSurah(a.number);
                  final juzB = getJuzForSurah(b.number);
                  final cmp = juzA.compareTo(juzB);
                  if (cmp != 0) return cmp;
                }
                return a.number.compareTo(b.number);
              });

              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    // Header Block depending on STATE A or STATE B
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                        child: isStateA
                            ? _buildStateAHeader(titleColor, subtitleColor)
                            : _buildStateBHeader(titleColor, readerState.isPremium, progress),
                      ),
                    ),

                    // Search Bar only in STATE A (Welcome State)
                    if (isStateA)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                          child: _buildSearchBar(isDark),
                        ),
                      ),

                    // "Surahs" Section Label in STATE B
                    if (!isStateA)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 12.0),
                          child: Text(
                            'Surahs',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: titleColor,
                            ),
                          ),
                        ),
                      ),

                    // Surah List or Empty Search Results State
                    filteredList.isEmpty
                        ? const SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: Text(
                                  'No surahs match your search',
                                  style: TextStyle(color: QkaTheme.neutral400),
                                ),
                              ),
                            ),
                          )
                        : SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final item = filteredList[index];
                                  return SurahListRow(
                                    number: item.number,
                                    transliteration: item.transliteration,
                                    englishMeaning: item.englishMeaning,
                                    arabicName: item.arabicName,
                                    totalAyahs: item.totalAyahs,
                                    ayahsRead: item.ayahsRead,
                                    onTap: () => _handleSurahTap(item.number),
                                  );
                                },
                                childCount: filteredList.length,
                              ),
                            ),
                          ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: QkaTheme.teal400)),
            error: (err, stack) => Center(child: Text('Error loading surahs: $err')),
          );
        },
        loading: () {
          // While user progress is loading, show skeletons
          return surahsAsync.when(
            data: (surahList) {
              return _buildSkeletonBody(context, surahList, isDark, titleColor);
            },
            loading: () => const Center(child: CircularProgressIndicator(color: QkaTheme.teal400)),
            error: (err, stack) => Center(child: Text('Error loading surahs: $err')),
          );
        },
        error: (err, stack) => Center(child: Text('Error loading user progress: $err')),
      ),
    );
  }

  /// Builds the top bar with small serif QKA and avatar icon
  Widget _buildInlineTopBar(Color titleColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'QKA',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: 40,
              height: 2,
              color: QkaTheme.teal400, // teal-400 accent glow
            ),
          ],
        ),
        
        // Profile icon. Switches active tab to Profile
        IconButton(
          icon: Icon(Icons.account_circle_outlined, size: 24, color: QkaTheme.neutral400),
          onPressed: () {
            // Find parent HomeScreenState and switch active tab to 4 (Profile)
            final parentState = context.findAncestorStateOfType<_HomeScreenState>();
            if (parentState != null) {
              parentState.setState(() {
                parentState._currentTab = 4;
                parentState._visitedTabs[4] = true;
              });
            }
          },
        ),
      ],
    );
  }

  /// Builds the header layout for returning users (STATE B)
  Widget _buildStateBHeader(Color titleColor, bool isPremium, UserProgressState progress) {
    final nextSurahObj = allSurahsStaticData.firstWhere(
      (s) => s.number == progress.nextUnreadSurah,
      orElse: () => allSurahsStaticData[0],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Inline Top Bar
        _buildInlineTopBar(titleColor),
        const SizedBox(height: 24),

        // Continue Reading Card
        ContinueReadingCard(
          surahName: nextSurahObj.transliteration,
          ayahsRead: progress.lastReadAyah,
          totalAyahs: nextSurahObj.totalAyahs,
          arabicSnippet: progress.nextUnreadSnippet,
          arabicFont: ref.watch(readerStateNotifierProvider).arabicFont,
          onTap: () {
            context.push('/reader/${progress.nextUnreadSurah}', extra: {'startAyah': progress.nextUnreadAyah});
          },
        ),
      ],
    );
  }

  /// Builds the header layout for new users (STATE A)
  Widget _buildStateAHeader(Color titleColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'QKA',
            style: TextStyle(
              fontFamily: 'Serif',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Welcome',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: titleColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Begin your journey by exploring the Quran.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: subtitleColor,
          ),
        ),
      ],
    );
  }

  /// Builds the Search bar with filter/sliders icon (STATE A only)
  Widget _buildSearchBar(bool isDark) {
    final searchBg = isDark ? QkaTheme.neutral800 : QkaTheme.neutral50;
    final borderColor = isDark ? QkaTheme.neutral600 : QkaTheme.neutral200;
    
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: searchBg,
        borderRadius: BorderRadius.circular(8), // radius-md
        border: Border.all(
          color: borderColor,
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(Icons.search, size: 20, color: QkaTheme.neutral400),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search surahs...',
                hintStyle: TextStyle(color: QkaTheme.neutral400, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
              ),
              style: TextStyle(
                color: isDark ? Colors.white : QkaTheme.neutral800,
                fontSize: 14,
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
          ),
          
          // Tune / adjustments sliders icon on the right
          IconButton(
            icon: Icon(Icons.tune, size: 20, color: QkaTheme.neutral400),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => _showSortSheet(context),
          ),
        ],
      ),
    );
  }

  /// Helper to build State B layout structure but with ContinueReadingSkeleton
  Widget _buildSkeletonBody(
    BuildContext context,
    List<SurahListItem> surahList,
    bool isDark,
    Color titleColor,
  ) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Inline Top Bar + Skeleton Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInlineTopBar(titleColor),
                  const SizedBox(height: 24),
                  const ContinueReadingSkeleton(),
                ],
              ),
            ),
          ),

          // "Surahs" label
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 12.0),
              child: Text(
                'Surahs',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: titleColor,
                ),
              ),
            ),
          ),

          // Surah List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = surahList[index];
                  return SurahListRow(
                    number: item.number,
                    transliteration: item.transliteration,
                    englishMeaning: item.englishMeaning,
                    arabicName: item.arabicName,
                    totalAyahs: item.totalAyahs,
                    ayahsRead: item.ayahsRead,
                    onTap: () => _handleSurahTap(item.number),
                  );
                },
                childCount: surahList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmer skeleton block matching ContinueReadingCard layout and design specs
class ContinueReadingSkeleton extends StatelessWidget {
  const ContinueReadingSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? QkaTheme.neutral800 : QkaTheme.neutral50;
    final highlightColor = isDark ? QkaTheme.neutral600 : QkaTheme.neutral100;
    final cardBgColor = isDark ? QkaTheme.darkSurface : QkaTheme.lightSurface;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: QkaTheme.teal400,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Continue reading" label
          Text(
            'CONTINUE READING',
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              color: QkaTheme.neutral400,
            ),
          ),
          const SizedBox(height: 8),

          // Surah name skeleton block
          Container(
            width: 180,
            height: 24,
            decoration: BoxDecoration(
              color: highlightColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),

          // Arabic snippet skeleton blocks (RTL, right-aligned)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 220,
              height: 18,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 140,
              height: 18,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Progress bar skeleton
          Container(
            width: double.infinity,
            height: 3,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ],
      ),
    );
  }
}
