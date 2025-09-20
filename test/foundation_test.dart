import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/src/common/presentation/theme/theme_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Foundation Tests - Dependencies and Configuration', () {
    test('Theme configuration should be valid', () {
      // Test that themes are properly configured
      expect(lightTheme, isNotNull);
      expect(darkTheme, isNotNull);

      // Test that TabBarThemeData is properly configured (this was the main fix)
      expect(lightTheme.tabBarTheme, isA<TabBarThemeData>());
      expect(darkTheme.tabBarTheme, isA<TabBarThemeData>());

      // Test theme properties
      expect(lightTheme.brightness, Brightness.light);
      expect(darkTheme.brightness, Brightness.dark);
    });

    test('Theme colors should be defined', () {
      expect(lightPrimary, isNotNull);
      expect(darkPrimary, isNotNull);
      expect(lightTheme.colorScheme, isNotNull);
      expect(darkTheme.colorScheme, isNotNull);
      expect(lightSurface, isNotNull);
      expect(darkSurface, isNotNull);
      expect(lightOnSurface, isNotNull);
      expect(darkOnSurface, isNotNull);
    });

    test('TabBarThemeData migration should be successful', () {
      // This test validates that the TabBarTheme -> TabBarThemeData migration worked
      final lightTabBarTheme = lightTheme.tabBarTheme;
      final darkTabBarTheme = darkTheme.tabBarTheme;

      expect(lightTabBarTheme, isNotNull);
      expect(darkTabBarTheme, isNotNull);

      // Verify specific properties that were migrated
      expect(lightTabBarTheme.labelColor, isNotNull);
      expect(lightTabBarTheme.unselectedLabelColor, isNotNull);
      expect(lightTabBarTheme.indicator, isNotNull);
      expect(darkTabBarTheme.indicator, isNotNull);
    });

    test('Color scheme should have proper contrast', () {
      // Test color contrast for accessibility
      expect(lightTheme.colorScheme.primary,
          isNot(equals(lightTheme.colorScheme.surface)));
      expect(darkTheme.colorScheme.primary,
          isNot(equals(darkTheme.colorScheme.surface)));

      // Test that surface colors are different between themes
      expect(lightTheme.colorScheme.surface,
          isNot(equals(darkTheme.colorScheme.surface)));
    });

    test('Card theme should be properly configured', () {
      // Test card theme configuration
      expect(lightTheme.cardTheme.elevation, equals(0));
      expect(darkTheme.cardTheme.elevation, equals(0));
      expect(lightTheme.cardTheme.surfaceTintColor, equals(Colors.transparent));
      expect(darkTheme.cardTheme.surfaceTintColor, equals(Colors.transparent));
    });
  });
}
