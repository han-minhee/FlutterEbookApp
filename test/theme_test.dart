import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/src/common/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Theme Tests', () {
    test('lightTheme should be properly configured', () {
      expect(lightTheme, isNotNull);
      expect(lightTheme.brightness, Brightness.light);
      expect(lightTheme.scaffoldBackgroundColor, lightSurface);
      expect(lightTheme.tabBarTheme, isA<TabBarThemeData>());
    });

    test('darkTheme should be properly configured', () {
      expect(darkTheme, isNotNull);
      expect(darkTheme.brightness, Brightness.dark);
      expect(darkTheme.scaffoldBackgroundColor, darkSurface);
      expect(darkTheme.tabBarTheme, isA<TabBarThemeData>());
    });

    test('Theme colors should be defined', () {
      expect(lightPrimary, isA<Color>());
      expect(darkPrimary, isA<Color>());
      expect(lightTheme.colorScheme, isA<ColorScheme>());
      expect(darkTheme.colorScheme, isA<ColorScheme>());
      expect(lightSurface, isA<Color>());
      expect(darkSurface, isA<Color>());
    });

    test('TabBarThemeData should be properly configured', () {
      expect(lightTheme.tabBarTheme.labelColor, isNotNull);
      expect(lightTheme.tabBarTheme.unselectedLabelColor, isNotNull);
      expect(lightTheme.tabBarTheme.indicator, isA<UnderlineTabIndicator>());
      
      expect(darkTheme.tabBarTheme.indicator, isA<UnderlineTabIndicator>());
    });
  });
}