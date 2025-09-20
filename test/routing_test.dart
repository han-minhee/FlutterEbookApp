import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/src/common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Auto Route Tests', () {
    testWidgets('AppRouter should be properly configured',
        (WidgetTester tester) async {
      final router = AppRouter();

      expect(router, isNotNull);
      expect(router.routes, isNotEmpty);
    });

    testWidgets('Router config should work with MaterialApp',
        (WidgetTester tester) async {
      LocalStorage();
      final router = AppRouter();

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router.config(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should not throw any exceptions
      expect(tester.takeException(), isNull);
    });

    testWidgets('Routes should be accessible', (WidgetTester tester) async {
      final router = AppRouter();
      final routes = router.routes;

      // Verify that we have the expected routes
      expect(routes.length, greaterThan(0));

      // Check for main routes
      final routePaths = routes.map((route) => route.path).toList();
      expect(routePaths, contains('/'));
      expect(routePaths, contains('/tabs-screen'));
    });
  });
}
