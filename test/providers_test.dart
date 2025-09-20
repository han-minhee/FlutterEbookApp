import 'package:flutter_ebook_app/src/common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Provider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('dioProvider should provide Dio instance', () {
      final dio = container.read(dioProvider);
      expect(dio, isNotNull);
      expect(dio.runtimeType.toString(), contains('Dio'));
    });

    test('storeRefProvider should provide StoreRef instance', () {
      final storeRef = container.read(storeRefProvider);
      expect(storeRef, isNotNull);
    });

    test('database providers should provide Database instances', () {
      final downloadsDb = container.read(downloadsDatabaseProvider);
      final favoritesDb = container.read(favoritesDatabaseProvider);

      expect(downloadsDb, isNotNull);
      expect(favoritesDb, isNotNull);
    });

    test('currentAppThemeNotifierProvider should be available', () {
      expect(() => container.read(currentAppThemeNotifierProvider),
          returnsNormally);
    });
  });
}
