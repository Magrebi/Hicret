// test/widget_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_knowledge_atlas/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app under ProviderScope and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Verify that the MaterialApp.router pumps successfully.
    expect(find.byType(MyApp), findsOneWidget);
  });
}
