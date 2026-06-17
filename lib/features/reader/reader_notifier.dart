// lib/features/reader/reader_notifier.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/repositories/quran_repository.dart';

import '../../core/local_db/database_provider.dart';
import 'package:drift/drift.dart';
import '../../core/local_db/database_seeder.dart';
import '../../core/network/quran_api_service.dart';
import '../home/surah_data.dart';

part 'reader_notifier.g.dart';

const _fatihahArabic = [
  'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
  'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ',
  'ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
  'مَـٰلِكِ يَوْمِ ٱلدِّينِ',
  'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
  'ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ',
  'صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ'
];

const _fatihahEnglish = [
  'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
  'All praise is due to Allah, Lord of the worlds.',
  'The Entirely Merciful, the Especially Merciful.',
  'Sovereign of the Day of Recompense.',
  'It is You we worship and You we ask for help.',
  'Guide us to the straight path.',
  'The path of those upon whom You have bestowed favor, not of those who have evoked [Your] anger or of those who are astray.'
];

const _baqarahArabic = [
  'الم',
  'ذَٰلِكَ ٱلْكِتَـٰبُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًى لِّلْمُتَّقِينَ',
  'ٱلَّذِينَ يُؤْمِنُونَ بِٱلْغَيْبِ وَيُقِيمُونَ ٱلصَّلَوٰةَ وَمِمَّا رَزَقْنَـٰهُمْ يُنفِقُونَ',
  'وَٱلَّذِينَ يُؤْمِنُونَ بِمَآ أُنزِلَ إِلَيْكَ وَمَآ أُنزِلَ مِن قَبْلِكَ وَبِٱلْـَٔاخِرَةِ هُمْ يُوقِنُونَ',
  'أُو۟لَـٰٓئِكَ عَلَىٰ هُدًى مِّن رَّبِّهِمْ ۖ وَأُو۟لَـٰٓئِكَ هُمُ ٱلْمُفْلِحُونَ',
  'إِنَّ ٱلَّذِينَ كَفَرُوا۟ سَوَآءٌ عَلَيْهِمْ ءَأَنذَرْتَهُمْ أَمْ لَمْ تُنذِرْهُمْ لَا يُؤْمِنُونَ',
  'خَتَمَ ٱللَّهُ عَلَىٰ قُلُوبِهِمْ وَعَلَىٰ سَمْعِهِمْ ۖ وَعَلَىٰٓ أَبْصَـٰرِهِمْ غِشَـٰوَةٌ ۖ وَلَهُمْ عَذَابٌ عَظِيمٌ',
  'وَمِنَ ٱلنَّاسِ مَن يَقُولُ ءَامَنَّا بِٱللَّهِ وَبِٱلْيَوْمِ ٱلْـَٔاخِرِ وَمَا هُم بِمُؤْمِنِينَ',
  'يُخَـٰدِعُونَ ٱللَّهَ وَٱلَّذِينَ ءَامَنُوا۟ وَمَا يَخْدَعُونَ إِلَّآ أَنفُسَهُمْ وَمَا يَشْعُرُونَ',
  'فِى قُلُوبِهِم مَّرَضٌ فَزَادَهُمُ ٱللَّهُ مَرَضًا ۖ وَلَهُمْ عَذَابٌ أَلِيمٌۢ بِمَا كَانُوا۟ يَكْذِبُونَ',
];

const _baqarahEnglish = [
  'Alif, Lam, Meem.',
  'This is the Book about which there is no doubt, a guidance for those conscious of Allah.',
  'Who believe in the unseen, establish prayer, and spend out of what We have provided for them.',
  'And who believe in what has been revealed to you, [O Muhammad], and what was revealed before you, and of the Hereafter they are certain [in faith].',
  'Those are upon [right] guidance from their Lord, and it is those who are the successful.',
  'Indeed, those who disbelieve - it is all the same for them whether you warn them or do not warn them - they will not believe.',
  'Allah has set a seal upon their hearts and upon their hearing, and over their vision is a barrier, and they will have a great punishment.',
  'And of the people are some who say, "We believe in Allah and the Last Day," but they are not believers.',
  'They [think to] deceive Allah and those who believe, but they deceive not except themselves and perceive [it] not.',
  'In their hearts is disease, so Allah has increased their disease; and for them is a painful punishment because they [habitually] used to lie.',
];

/// Exposes the list of verses fetched from the database for a specific Surah chapter.
@riverpod
Future<List<Verse>> verseList(VerseListRef ref, int surahNum) async {
  final repository = ref.watch(quranRepositoryProvider);
  final list = await repository.getVersesForSurah(surahNum);
  if (list.isNotEmpty) {
    return list;
  }

  final db = ref.read(appDatabaseProvider);
  final apiService = ref.read(quranApiServiceProvider);
  
  // Seed the main entities and metadata if they haven't been seeded yet
  final existingEntities = await db.select(db.entities).get();
  if (existingEntities.isEmpty) {
    await seedDatabaseFromJson(db);
  }

  // First, try to fetch the real verses from the API
  bool seededFromApi = false;
  try {
    final liveVerses = await apiService.fetchSurahVerses(surahNum);
    if (liveVerses.isNotEmpty) {
      await db.transaction(() async {
        for (final v in liveVerses) {
          await db.into(db.verses).insert(
            VersesCompanion.insert(
              surahNum: surahNum,
              ayahNum: v['ayahNum'] as int,
              textArabic: v['arabic'] as String,
              textTranslation: v['english'] as String,
              textTranslationTr: Value(v['turkish'] as String?),
              textTranslationDe: Value(v['german'] as String?),
              textTranslationFr: Value(v['french'] as String?),
              isRead: const Value(false),
            ),
          );
        }
      });
      seededFromApi = true;
    }
  } catch (e) {
    // Fail silently to fall back to mock offline seeding
  }

  // If API fetch failed or was empty, fall back to offline mock seeding
  if (!seededFromApi) {
    await db.transaction(() async {
      final surahData = allSurahsStaticData.firstWhere(
        (s) => s.number == surahNum,
        orElse: () => allSurahsStaticData[0],
      );
      final totalCount = surahData.totalAyahs;

      for (int i = 1; i <= totalCount; i++) {
        String arabic = '';
        String english = '';
        
        if (surahNum == 1) {
          arabic = _fatihahArabic[i - 1];
          english = _fatihahEnglish[i - 1];
        } else if (surahNum == 2) {
          if (i <= _baqarahArabic.length) {
            arabic = _baqarahArabic[i - 1];
            english = _baqarahEnglish[i - 1];
          } else {
            arabic = 'ذَٰلِكَ ٱلْكِتَـٰبُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًى لِّلْمُتَّقِينَ ($i)';
            english = 'This is verse $i of Surah Al-Baqarah (Mock English translation text for editorial and reading spacing evaluation).';
          }
        } else {
          arabic = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ ($i)';
          english = 'This is mock translation for surah $surahNum verse $i.';
        }
        
        await db.into(db.verses).insert(
          VersesCompanion.insert(
            surahNum: surahNum,
            ayahNum: i,
            textArabic: arabic,
            textTranslation: english,
            isRead: const Value(false),
          ),
        );
      }
    });
  }

  return repository.getVersesForSurah(surahNum);
}

/// State model managing ephemeral UI settings for the reader screen.
class ReaderState {
  final int? activeAyahNum; // The 1-indexed number of the tapped active Ayah
  final bool isPremium; // Stub for checking premium-tier entitlements
  final String arabicFont; // Amiri Quran / KFGQPC Uthmanic selection
  final double arabicFontSize; // Arabic text scale size
  final String translationLanguage; // 'en', 'tr', 'de', 'fr' preferred translation language
  final Set<int> readAyahs; // Set of Ayah numbers marked as read in this session

  ReaderState({
    this.activeAyahNum,
    this.isPremium = false,
    this.arabicFont = 'Amiri Quran',
    this.arabicFontSize = 24.0,
    this.translationLanguage = 'en',
    Set<int>? readAyahs,
  }) : readAyahs = readAyahs ?? {};

  ReaderState copyWith({
    int? activeAyahNum,
    bool? isPremium,
    String? arabicFont,
    double? arabicFontSize,
    String? translationLanguage,
    Set<int>? readAyahs,
  }) {
    return ReaderState(
      activeAyahNum: activeAyahNum ?? this.activeAyahNum,
      isPremium: isPremium ?? this.isPremium,
      arabicFont: arabicFont ?? this.arabicFont,
      arabicFontSize: arabicFontSize ?? this.arabicFontSize,
      translationLanguage: translationLanguage ?? this.translationLanguage,
      readAyahs: readAyahs ?? this.readAyahs,
    );
  }
}

/// State notifier managing ephemeral settings on the reader screen.
@riverpod
class ReaderStateNotifier extends _$ReaderStateNotifier {
  @override
  ReaderState build() {
    return ReaderState(
      activeAyahNum: null,
      isPremium: false,
      arabicFont: 'Amiri Quran',
      arabicFontSize: 24.0,
      translationLanguage: 'en',
      readAyahs: {},
    );
  }

  /// Change the selected/active Ayah index (highlighting it and updating translation display)
  void setActiveAyah(int? ayahNum) {
    state = state.copyWith(activeAyahNum: ayahNum);
  }

  /// Mark an Ayah as read locally to update read badges in real-time
  void markLocalAsRead(int ayahNum) {
    final updated = Set<int>.from(state.readAyahs)..add(ayahNum);
    state = state.copyWith(readAyahs: updated);
  }

  /// Populate initialized read verses from local DB to prevent redundant unlocks
  void loadReadAyahs(List<int> ayahs) {
    state = state.copyWith(readAyahs: ayahs.toSet());
  }

  /// Set user premium state manually (mock config)
  void setPremium(bool isPremium) {
    state = state.copyWith(isPremium: isPremium);
  }

  /// Set the preferred Arabic font family
  void setArabicFont(String font) {
    state = state.copyWith(arabicFont: font);
  }

  /// Set the preferred Arabic font size
  void setArabicFontSize(double size) {
    state = state.copyWith(arabicFontSize: size);
  }

  /// Set the preferred translation language
  void setTranslationLanguage(String lang) {
    state = state.copyWith(translationLanguage: lang);
  }
}
