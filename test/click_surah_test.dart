// test/click_surah_test.dart

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';

import 'package:quran_knowledge_atlas/main.dart';
import 'package:quran_knowledge_atlas/core/local_db/app_database.dart' hide Theme;
import 'package:quran_knowledge_atlas/core/local_db/database_provider.dart';
import 'package:quran_knowledge_atlas/core/services/audio_service.dart';
import 'package:quran_knowledge_atlas/core/network/quran_api_service.dart';

class FakeAudioService extends AudioService {
  @override
  AudioState build() {
    return AudioState();
  }

  @override
  Future<void> playVerse(int surahNum, int ayahNum) async {}

  @override
  Future<void> pause() async {}

  @override
  Future<void> resume() async {}

  @override
  Future<void> stop() async {}
}

class FakeQuranApiService extends QuranApiService {
  @override
  Future<List<Map<String, dynamic>>> fetchSurahVerses(int surahNum) async {
    if (surahNum == 1) {
      return [
        {
          'ayahNum': 1,
          'arabic': 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ (API)',
          'english': 'In the name of Allah, the Entirely Merciful, the Especially Merciful. (API)',
          'turkish': 'Rahman ve Rahim olan Allah\'ın adıyla. (API)',
          'german': 'Im Namen Allahs, des Allerbarmers, des Barmherzigen. (API)',
          'french': 'Au nom d\'Allah, le Tout Miséricordieux, le Très Miséricordieux. (API)'
        },
        {
          'ayahNum': 2,
          'arabic': 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ (API)',
          'english': 'All praise is due to Allah, Lord of the worlds. (API)',
          'turkish': 'Hamd, alemlerin Rabbi olan Allah\'a mahsustur. (API)',
          'german': 'Alles Lob gebührt Allah, dem Herrn der Welten. (API)',
          'french': 'Louange à Allah, Seigneur de l\'univers. (API)'
        },
      ];
    }
    return [];
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());

    // Mock asset loading
    final file = File('assets/data/entities.json');
    final jsonContent = file.readAsStringSync();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
      if (message == null) return null;
      final String key = utf8.decode(message.buffer.asUint8List());
      if (key.contains('entities.json')) {
        final bytes = utf8.encode(jsonContent);
        final buffer = Uint8List.fromList(bytes).buffer;
        return ByteData.view(buffer);
      }
      return null;
    });
  });

  testWidgets('Clicking surah test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            audioServiceProvider.overrideWith(() => FakeAudioService()),
            quranApiServiceProvider.overrideWith((ref) => FakeQuranApiService()),
          ],
          child: const MyApp(),
        ),
      );

      // Wait for initial load
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pump();

      // Tap first surah (Al-Fatihah)
      final surahRow = find.text('Al-Fatihah');
      expect(surahRow, findsOneWidget);
      await tester.tap(surahRow);

      // Wait for navigation and database seeding
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pump();

      // Verify that the verses were seeded from our FakeQuranApiService
      final seededVerses = await (db.select(db.verses)..where((t) => t.surahNum.equals(1))).get();
      expect(seededVerses.length, equals(2));
      expect(seededVerses.first.textArabic, contains('(API)'));
      expect(seededVerses.first.textTranslation, contains('(API)'));
      expect(seededVerses.first.textTranslationTr, contains('adıyla. (API)'));
      expect(seededVerses.first.textTranslationDe, contains('Barmherzigen. (API)'));
      expect(seededVerses.first.textTranslationFr, contains('Miséricordieux. (API)'));

      // Close database and pump to let clean up timers run
      await db.close();
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 100));
      await tester.pump();
    });
  });
}
