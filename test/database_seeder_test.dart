// test/database_seeder_test.dart

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:quran_knowledge_atlas/core/local_db/app_database.dart' hide Theme;
import 'package:quran_knowledge_atlas/core/local_db/database_seeder.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
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

  test('Database Seeder Test - Seeds all entities and collections', () async {
    final db = AppDatabase(NativeDatabase.memory());

    // Call seeder
    await seedDatabaseFromJson(db);

    // Verify entities are loaded (38 characters + 13 locations + 10 animals + 6 plants + 2 foods + 5 stories = 74)
    final allEntities = await db.select(db.entities).get();
    expect(allEntities.length, equals(74));

    // Verify collections
    final allCollections = await db.select(db.collections).get();
    expect(allCollections.length, equals(3)); // col_animals, col_plants, col_foods

    final allCollectionEntities = await db.select(db.collectionEntities).get();
    expect(allCollectionEntities.length, equals(18)); // 10 animals + 6 plants + 2 foods = 18

    // Verify stories
    final allStories = await db.select(db.stories).get();
    expect(allStories.length, equals(5));

    // Verify themes
    final allThemes = await db.select(db.themes).get();
    expect(allThemes.length, equals(8));

    // Verify sets
    final allSets = await db.select(db.sets).get();
    expect(allSets.length, equals(10));

    await db.close();
  });
}
