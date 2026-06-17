// lib/features/reader/reader_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/repositories/quran_repository.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../../shared/widgets/discovery_sheet.dart';
import '../../shared/widgets/verse_block.dart';
import '../../shared/widgets/verse_skeleton.dart';
import '../discovery/discovery_service.dart';
import 'reader_notifier.dart';
import '../../core/services/audio_service.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  final int surahNumber;
  final int startAyah;

  const ReaderScreen({
    Key? key,
    required this.surahNumber,
    required this.startAyah,
  }) : super(key: key);

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  final ScrollController _scrollController = ScrollController();
  
  double _appBarOpacity = 1.0;
  double _lastScrollOffset = 0.0;
  bool _showBottomBar = true;
  bool _isProcessingUnlock = false;
  bool _firstScrollRestored = false;
  int _visibleCount = 20;
  AudioService? _audioServiceNotifier;
  
  // Surah names list mapping for UI display
  static const Map<int, String> _surahNames = {
    1: 'Al-Fatihah',
    2: 'Al-Baqarah',
    9: 'At-Tawbah',
    12: 'Yusuf',
    18: 'Al-Kahf',
    114: 'An-Nas',
  };

  static const Map<int, String> _surahMeanings = {
    1: 'The Opening',
    2: 'The Cow',
    9: 'The Repentance',
    12: 'Joseph',
    18: 'The Cave',
    114: 'Mankind',
  };

  static const Map<int, String> _surahArabicCalligraphy = {
    1: 'الفاتحة',
    2: 'البقرة',
    9: 'التوبة',
    12: 'يوسف',
    18: 'الكهف',
    114: 'الناس',
  };

  @override
  void initState() {
    super.initState();
    _audioServiceNotifier = ref.read(audioServiceProvider.notifier);
    // Initialize visible count to comfortably fit startAyah
    _visibleCount = ((widget.startAyah ~/ 20 + 1) * 20).clamp(20, 286);
    _scrollController.addListener(_scrollListener);
    
    // Restore scroll position after list renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _restoreScrollPosition();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    // Stop audio playback when leaving the screen
    _audioServiceNotifier?.stop();
    super.dispose();
  }

  /// Restoration offset algorithm mapping starting Ayah index
  void _restoreScrollPosition() {
    if (_firstScrollRestored) return;
    _firstScrollRestored = true;
    
    if (widget.startAyah > 1) {
      // Estimate each block average height around 220px to jump near start_ayah
      final double targetOffset = (widget.startAyah - 1) * 220.0;
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: AlignmentHelper._easeDefault,
      );
    }
  }

  /// App bar and pagination bottom navigation bar scroll transition checks
  void _scrollListener() {
    if (!_scrollController.hasClients) return;
    
    final currentOffset = _scrollController.offset;
    final delta = currentOffset - _lastScrollOffset;

    // 1. Pagination bottom bar visibility toggles
    if (delta > 4 && _showBottomBar) {
      setState(() => _showBottomBar = false); // Hide on downward scroll
    } else if (delta < -4 && !_showBottomBar) {
      setState(() => _showBottomBar = true); // Reappear on upward scroll or pause
    }

    // 2. Chunk loading: load next 20 verses when user scrolls within 500px of bottom
    if (_scrollController.position.extentAfter < 500) {
      final versesAsync = ref.read(verseListProvider(widget.surahNumber));
      versesAsync.whenData((verseList) {
        final total = verseList.length;
        if (_visibleCount < total) {
          setState(() {
            _visibleCount = (_visibleCount + 20).clamp(0, total);
          });
        }
      });
    }

    // 3. Top bar fade calculations (opacity 0 at 100px)
    double newOpacity = _appBarOpacity;
    if (currentOffset <= 0) {
      newOpacity = 1.0;
    } else if (delta > 0) {
      newOpacity = (1.0 - (currentOffset / 100.0)).clamp(0.0, 1.0);
    } else {
      newOpacity = 1.0;
    }

    if (newOpacity != _appBarOpacity) {
      setState(() => _appBarOpacity = newOpacity);
    }
    
    _lastScrollOffset = currentOffset;
  }

  /// Tap action triggering verse read confirmations and discovery
  Future<void> _handleVerseTap(Verse verse, int lastAyahNum) async {
    final notifier = ref.read(readerStateNotifierProvider.notifier);
    final state = ref.read(readerStateNotifierProvider);

    // 1. Mark verse active in local UI state
    notifier.setActiveAyah(verse.ayahNum);

    // 2. Protect already-read verses from re-triggering discovery
    if (state.readAyahs.contains(verse.ayahNum)) {
      return; 
    }

    if (_isProcessingUnlock) return; // Blocker

    setState(() => _isProcessingUnlock = true);

    try {
      final service = ref.read(discoveryServiceProvider);
      
      // 3. Mark as read inside transactional db constraints
      final result = await service.processAyahRead(verse.surahNum, verse.ayahNum);

      // 4. Update UI state locally
      notifier.markLocalAsRead(verse.ayahNum);

      // 5. Open discovery sheet only after commit resolves (no optimistic UI)
      if (result.unlocks.isNotEmpty) {
        if (mounted) {
          if (result.hasRareUnlock) {
            await DiscoverySheet.rareSheet(context, result);
          } else {
            await DiscoverySheet.standardSheet(context, result);
          }
        }
      }

      // 6. Check for set completions to push celebration screen after sheet dismisses
      if (result.setCompletions.isNotEmpty) {
        if (mounted) {
          context.push('/celebration', extra: result.setCompletions.first);
        }
      }

      // 7. Check if last verse and trigger milestones / ads
      if (verse.ayahNum == lastAyahNum) {
        _handleSurahCompletion();
      }
    } catch (e) {
      // Fail safely
    } finally {
      if (mounted) {
        setState(() => _isProcessingUnlock = false);
      }
    }
  }

  /// Triggers milestones and interstitial ads post-Surah
  void _handleSurahCompletion() {
    // 1. Check for Expedition milestones (Stub)
    // TODO: Expedition milestone trigger check

    // 2. Free tier AdMob interstitial check
    final state = ref.read(readerStateNotifierProvider);
    if (!state.isPremium) {
      // Show AdMob Interstitial (Stub)
      // TODO: google_mobile_ads InterstitialAd.load() and show()
    }
  }

  /// Shows the font size, font family, and premium audio switch dialog
  void _showSettingsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(readerStateNotifierProvider);
            final notifier = ref.read(readerStateNotifierProvider.notifier);
            final isDark = Theme.of(context).brightness == Brightness.dark;
            final sheetBgColor = isDark ? const Color(0xFF252220) : const Color(0xFFFDFCFA);

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
                    'Reading Preferences',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF2C2A25),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Font Size Settings
                  Text(
                    'Arabic Font Size',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFFC9C6BE) : const Color(0xFF5A574F),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.format_size, size: 16, color: Color(0xFF8C8880)),
                      Expanded(
                        child: Slider(
                          value: state.arabicFontSize,
                          min: 18.0,
                          max: 30.0,
                          divisions: 6,
                          activeColor: const Color(0xFF1D9E75),
                          inactiveColor: isDark ? const Color(0xFF2C2A25) : const Color(0xFFE8E5DF),
                          onChanged: (val) {
                            notifier.setArabicFontSize(val);
                          },
                        ),
                      ),
                      Text(
                        '${state.arabicFontSize.round()}px',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF8C8880)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Font Family Settings
                  Text(
                    'Arabic Script Type',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFFC9C6BE) : const Color(0xFF5A574F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Text('Amiri'),
                          selected: state.arabicFont == 'Amiri Quran',
                          selectedColor: const Color(0xFF1D9E75).withOpacity(0.2),
                          onSelected: (selected) {
                            if (selected) {
                              notifier.setArabicFont('Amiri Quran');
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ChoiceChip(
                          label: const Text('Uthmanic'),
                          selected: state.arabicFont == 'KFGQPC Uthmanic',
                          selectedColor: const Color(0xFF1D9E75).withOpacity(0.2),
                          onSelected: (selected) {
                            if (selected) {
                              notifier.setArabicFont('KFGQPC Uthmanic');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Translation Language Settings
                  Text(
                    'Translation Language',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFFC9C6BE) : const Color(0xFF5A574F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('English'),
                        selected: state.translationLanguage == 'en',
                        selectedColor: const Color(0xFF1D9E75).withOpacity(0.2),
                        onSelected: (selected) {
                          if (selected) {
                            notifier.setTranslationLanguage('en');
                          }
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Türkçe'),
                        selected: state.translationLanguage == 'tr',
                        selectedColor: const Color(0xFF1D9E75).withOpacity(0.2),
                        onSelected: (selected) {
                          if (selected) {
                            notifier.setTranslationLanguage('tr');
                          }
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Deutsch'),
                        selected: state.translationLanguage == 'de',
                        selectedColor: const Color(0xFF1D9E75).withOpacity(0.2),
                        onSelected: (selected) {
                          if (selected) {
                            notifier.setTranslationLanguage('de');
                          }
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Français'),
                        selected: state.translationLanguage == 'fr',
                        selectedColor: const Color(0xFF1D9E75).withOpacity(0.2),
                        onSelected: (selected) {
                          if (selected) {
                            notifier.setTranslationLanguage('fr');
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Premium Tier Toggle (for testing audio stubs)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Premium Reading Audio',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : const Color(0xFF2C2A25),
                            ),
                          ),
                          Text(
                            'Enable audio recitation play buttons',
                            style: const TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 11,
                              color: Color(0xFF8C8880),
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: state.isPremium,
                        activeColor: const Color(0xFF1D9E75),
                        onChanged: (val) {
                          notifier.setPremium(val);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final prefState = ref.watch(readerStateNotifierProvider);
    final audioState = ref.watch(audioServiceProvider);

    // Handle audio errors and completions dynamically
    ref.listen<AudioState>(audioServiceProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Audio Error: ${next.error}'),
            backgroundColor: Colors.red,
          ),
        );
      }

      if (next.hasCompleted && next.surahNum == widget.surahNumber && next.ayahNum != null) {
        final verseListAsync = ref.read(verseListProvider(widget.surahNumber));
        verseListAsync.whenData((verseList) {
          final matches = verseList.where((v) => v.ayahNum == next.ayahNum);
          if (matches.isNotEmpty) {
            _handleVerseTap(matches.first, verseList.length);
          }
        });
      }
    });

    // Load verses asynchronously
    final versesAsync = ref.watch(verseListProvider(widget.surahNumber));

    // Warm colors from tokens
    final scaffoldBgColor = isDark ? const Color(0xFF1A1815) : const Color(0xFFFDFCFA);

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Stack(
        children: [
          // Primary scrolling list
          versesAsync.when(
            data: (verseList) {
              if (verseList.isEmpty) {
                return const Center(child: Text('No verses found.'));
              }

              // Load already read verses into notifier once, guarding against redundant updates causing infinite loops
              final readSet = verseList.where((v) => v.isRead).map((v) => v.ayahNum).toList();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  final currentRead = ref.read(readerStateNotifierProvider).readAyahs;
                  if (currentRead.length != readSet.length || !currentRead.containsAll(readSet)) {
                    ref.read(readerStateNotifierProvider.notifier).loadReadAyahs(readSet);
                  }
                }
              });

              final totalAyahs = verseList.length;
              final currentVisible = _visibleCount.clamp(0, totalAyahs);

              return ListView.builder(
                key: PageStorageKey('reader_list_${widget.surahNumber}'),
                controller: _scrollController,
                cacheExtent: 2000.0, // Pre-renders off-screen verses for O(1) performance
                itemCount: currentVisible + 2, // Surah header/Bismillah + visible verses + complete banner
                itemBuilder: (context, index) {
                  // Index 0: Header space / Bismillah block
                  if (index == 0) {
                    return _buildHeaderSpace(context, totalAyahs, isDark);
                  }

                  // Index currentVisible + 1: Complete banner at the end of the list
                  if (index == currentVisible + 1) {
                    final allRead = prefState.readAyahs.length == totalAyahs;
                    return _buildInlineCompleteBanner(context, allRead, isDark);
                  }

                  // Verse items (1-indexed offset)
                  final verse = verseList[index - 1];
                  final isVerseActive = prefState.activeAyahNum == verse.ayahNum;
                  final isVerseRead = prefState.readAyahs.contains(verse.ayahNum);

                  String getTranslationText(Verse v, String lang) {
                    switch (lang) {
                      case 'tr':
                        return v.textTranslationTr ?? v.textTranslation;
                      case 'de':
                        return v.textTranslationDe ?? v.textTranslation;
                      case 'fr':
                        return v.textTranslationFr ?? v.textTranslation;
                      default:
                        return v.textTranslation;
                    }
                  }

                   return VerseBlock(
                    surahNum: verse.surahNum,
                    ayahNum: verse.ayahNum,
                    arabicText: verse.textArabic,
                    translationText: getTranslationText(verse, prefState.translationLanguage),
                    isRead: isVerseRead,
                    isActive: isVerseActive,
                    isDark: isDark,
                    isPremium: prefState.isPremium,
                    arabicFont: prefState.arabicFont,
                    arabicFontSize: isDark ? 22.0 : prefState.arabicFontSize,
                    onTap: () => _handleVerseTap(verse, totalAyahs),
                    isAudioPlaying: audioState.surahNum == verse.surahNum &&
                        audioState.ayahNum == verse.ayahNum &&
                        audioState.isPlaying,
                    isAudioLoading: audioState.surahNum == verse.surahNum &&
                        audioState.ayahNum == verse.ayahNum &&
                        audioState.isLoading,
                    onPlayAudio: () {
                      ref.read(audioServiceProvider.notifier).playVerse(verse.surahNum, verse.ayahNum);
                    },
                    onBookmark: () async {
                      final repo = ref.read(quranRepositoryProvider);
                      final isBookmarked = await repo.isBookmarked(verse.surahNum, verse.ayahNum);
                      if (isBookmarked) {
                        await repo.removeBookmark(verse.surahNum, verse.ayahNum);
                      } else {
                        await repo.addBookmark(verse.surahNum, verse.ayahNum);
                      }
                    },
                  );
                },
              );
            },
            loading: () => ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => const VerseSkeleton(),
            ),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),

          // Custom floating Top Bar with opacity fades
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: _appBarOpacity,
              child: _buildTopAppBar(context, scaffoldBgColor, isDark),
            ),
          ),

          // Floating Pagination bottom bar above BottomNavBar
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              offset: _showBottomBar ? Offset.zero : const Offset(0, 1.5),
              duration: const Duration(milliseconds: 200),
              curve: AlignmentHelper._easeDefault,
              child: AnimatedOpacity(
                opacity: _showBottomBar ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 150),
                child: _buildFloatingPaginationBar(context, isDark),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Maps to Library tab
        onTap: (tabIndex) {
          // Navigate via tab indexes
        },
        isDarkTheme: isDark,
      ),
    );
  }

  /// Top app bar widget
  Widget _buildTopAppBar(BuildContext context, Color bgColor, bool isDark) {
    final state = ref.watch(readerStateNotifierProvider);
    final currentAyah = state.activeAyahNum ?? widget.startAyah;
    final nameTransliterated = _surahNames[widget.surahNumber] ?? 'Surah';

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 8,
        left: 20,
        right: 20,
      ),
      color: bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: back arrow (chevron)
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            color: isDark ? Colors.white70 : const Color(0xFF2C2A25),
            onPressed: () => context.pop(),
          ),
          
          // Centre: Surah title + Ayah progression counters
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                nameTransliterated,
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF2C2A25),
                ),
              ),
              const SizedBox(height: 2),
              Consumer(
                builder: (context, ref, _) {
                  final versesAsync = ref.watch(verseListProvider(widget.surahNumber));
                  final total = versesAsync.valueOrNull?.length ?? 286;
                  return Text(
                    '$currentAyah / $total',
                    style: const TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 11,
                      color: Color(0xFF8C8880), // neutral-400
                    ),
                  );
                },
              ),
            ],
          ),

          // Right: options sliders
          IconButton(
            icon: const Icon(Icons.tune, size: 20),
            color: isDark ? Colors.white70 : const Color(0xFF2C2A25),
            onPressed: () => _showSettingsSheet(context),
          ),
        ],
      ),
    );
  }

  /// Spacer and Bismillah formatting above verse list
  Widget _buildHeaderSpace(BuildContext context, int totalAyahs, bool isDark) {
    final topPaddingHeight = MediaQuery.of(context).padding.top + 72.0;
    final showBismillah = widget.surahNumber != 9; // Suppressed for surah 9

    return Column(
      children: [
        SizedBox(height: topPaddingHeight),
        // Dark Mode Header layout
        if (isDark) _buildDarkSurahHeader(totalAyahs),
        
        if (showBismillah) ...[
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
              style: TextStyle(
                fontFamily: 'Amiri Quran',
                fontSize: 20,
                color: Color(0xFF8C8880), // neutral-400
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
      ],
    );
  }

  /// Dark mode calligraphic header card
  Widget _buildDarkSurahHeader(int totalAyahs) {
    final nameArabic = _surahArabicCalligraphy[widget.surahNumber] ?? '';
    final nameTransliterated = _surahNames[widget.surahNumber] ?? '';
    final meaning = _surahMeanings[widget.surahNumber] ?? '';
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 32),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF252220), // neutral-900 equivalent tint
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Large Calligraphy Title
          Text(
            nameArabic,
            style: const TextStyle(
              fontFamily: 'Amiri Quran',
              fontSize: 36,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            nameTransliterated,
            style: const TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            meaning,
            style: const TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 13,
              color: Color(0xFF8C8880), // neutral-400
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Verses 1–$totalAyahs',
            style: const TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 11,
              color: Color(0xFF8C8880),
            ),
          ),
        ],
      ),
    );
  }

  /// Inline completion banner displayed at the end of the scroll list
  Widget _buildInlineCompleteBanner(BuildContext context, bool isCompleted, bool isDark) {
    if (!isCompleted) {
      return const SizedBox(height: 80); // Bottom list spacer
    }
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 80),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252220) : const Color(0xFFE1F5EE),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF1D9E75),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.stars, color: Color(0xFF1D9E75), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Surah Complete. Re-read to explore other entities or view the constellation map.',
              style: TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 13,
                color: isDark ? Colors.white70 : const Color(0xFF085041),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Floating pagination navigation bar above BottomNavBar
  Widget _buildFloatingPaginationBar(BuildContext context, bool isDark) {
    final hasNext = widget.surahNumber < 114;
    final cardBgColor = isDark ? const Color(0xFF252220) : const Color(0xFFF4F2EE);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Previous Surah Button
            TextButton(
              onPressed: widget.surahNumber > 1
                  ? () => context.pushReplacement('/reader/${widget.surahNumber - 1}')
                  : null,
              style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.chevron_left, size: 16, color: Color(0xFF1D9E75)),
                  SizedBox(width: 4),
                  Text(
                    'Previous Surah',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1D9E75),
                    ),
                  ),
                ],
              ),
            ),
            
            if (hasNext) ...[
              const SizedBox(width: 16),
              Container(
                width: 1,
                height: 16,
                color: isDark ? const Color(0xFF2C2A25) : const Color(0xFFE8E5DF),
              ),
              const SizedBox(width: 16),
              
              // Next Surah Button (hidden if last surah)
              TextButton(
                onPressed: () => context.pushReplacement('/reader/${widget.surahNumber + 1}'),
                style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Next Surah',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D9E75),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 16, color: Color(0xFF1D9E75)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Helper container holding standard curve tokens
class AlignmentHelper {
  static const _easeDefault = Cubic(0.4, 0.0, 0.2, 1.0);
}
