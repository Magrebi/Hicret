// lib/features/encyclopedia/collection_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/entity_card.dart';
import 'encyclopedia_notifier.dart';

class CollectionDetailScreen extends ConsumerWidget {
  final String collectionId;
  final bool isSet;
  final String name;

  const CollectionDetailScreen({
    Key? key,
    required this.collectionId,
    required this.isSet,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = Theme.of(context).colorScheme.surface;
    final titleColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;

    final entitiesAsync = ref.watch(collectionEntitiesProvider(collectionId, isSet));

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(name),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : QkaTheme.neutral800,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: titleColor,
        ),
      ),
      body: entitiesAsync.when(
        data: (entities) {
          if (entities.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(
                  'No entities discovered in this collection yet.',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: QkaTheme.neutral400,
                  ),
                ),
              ),
            );
          }

          // Sort entities: discovered first, then undiscovered
          final sortedEntities = List<Entity>.from(entities)
            ..sort((a, b) {
              if (a.isDiscovered && !b.isDiscovered) return -1;
              if (!a.isDiscovered && b.isDiscovered) return 1;
              return a.name.compareTo(b.name);
            });

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0, // Square cards
            ),
            itemCount: sortedEntities.length,
            itemBuilder: (context, index) {
              return EntityCard(entity: sortedEntities[index]);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: QkaTheme.teal400),
        ),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Error loading collection details: $err',
              style: const TextStyle(fontFamily: 'SF Pro', color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
