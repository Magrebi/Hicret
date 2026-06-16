// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';
import 'features/reader/reader_screen.dart';
import 'features/encyclopedia/entity_detail_screen.dart';
import 'features/encyclopedia/collection_detail_screen.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/reader/:surahNum',
      builder: (context, state) {
        final surahNum = int.parse(state.pathParameters['surahNum']!);
        final extra = state.extra as Map<String, dynamic>?;
        final startAyah = extra?['startAyah'] as int? ?? 1;
        return ReaderScreen(
          surahNumber: surahNum,
          startAyah: startAyah,
        );
      },
    ),
    GoRoute(
      path: '/encyclopedia/:entityId',
      builder: (context, state) {
        final entityId = state.pathParameters['entityId']!;
        return EntityDetailScreen(entityId: entityId);
      },
    ),
    GoRoute(
      path: '/encyclopedia/collection/:collectionId',
      builder: (context, state) {
        final collectionId = state.pathParameters['collectionId']!;
        final extra = state.extra as Map<String, dynamic>?;
        final isSet = extra?['isSet'] as bool? ?? false;
        final name = extra?['name'] as String? ?? 'Collection';
        return CollectionDetailScreen(
          collectionId: collectionId,
          isSet: isSet,
          name: name,
        );
      },
    ),
  ],
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quran Knowledge Atlas',
      theme: QkaTheme.lightTheme,
      darkTheme: QkaTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
