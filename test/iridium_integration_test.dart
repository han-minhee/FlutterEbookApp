import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/external_iridium_reader.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/iridium_reader_factory.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/iridium_reader_interface.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/local_iridium_reader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Iridium Integration Tests', () {
    late IridiumReaderInterface localReader;
    late IridiumReaderInterface externalReader;

    setUp(() {
      localReader = IridiumReaderFactory.createLocalReader();
      externalReader = IridiumReaderFactory.createExternalReader();
    });

    testWidgets('Local Iridium reader creates widget from path',
        (WidgetTester tester) async {
      const testPath = '/test/path/book.epub';

      final widget = localReader.createEpubReaderFromPath(
        filePath: testPath,
      );

      expect(widget, isA<Widget>());

      await tester.pumpWidget(MaterialApp(home: widget));
      await tester.pumpAndSettle();

      // Verify the widget is rendered without errors
      expect(find.byType(Widget), findsWidgets);
    });

    testWidgets('External Iridium reader creates widget from path',
        (WidgetTester tester) async {
      const testPath = '/test/path/book.epub';

      final widget = externalReader.createEpubReaderFromPath(
        filePath: testPath,
      );

      expect(widget, isA<Widget>());

      await tester.pumpWidget(MaterialApp(home: widget));
      await tester.pumpAndSettle();

      // Verify the widget is rendered without errors
      expect(find.byType(Widget), findsWidgets);
      // For external reader, verify placeholder content
      expect(find.text('External Iridium Implementation'), findsOneWidget);
    });

    testWidgets('Both implementations have same interface',
        (WidgetTester tester) async {
      const testPath = '/test/path/book.epub';

      // Test that both implementations can create widgets with same parameters
      final localWidget = localReader.createEpubReaderFromPath(
        filePath: testPath,
        location: 'chapter1',
        settings: '100',
        theme: '{"backgroundColor": "#ffffff"}',
      );

      final externalWidget = externalReader.createEpubReaderFromPath(
        filePath: testPath,
        location: 'chapter1',
        settings: '100',
        theme: '{"backgroundColor": "#ffffff"}',
      );

      expect(localWidget, isA<Widget>());
      expect(externalWidget, isA<Widget>());
    });

    testWidgets('Factory creates correct reader based on configuration',
        (WidgetTester tester) async {
      final defaultReader = IridiumReaderFactory.createReader();
      expect(defaultReader, isA<LocalIridiumReader>());

      final localReader = IridiumReaderFactory.createLocalReader();
      expect(localReader, isA<LocalIridiumReader>());

      final externalReader = IridiumReaderFactory.createExternalReader();
      expect(externalReader, isA<ExternalIridiumReader>());
    });

    group('Feature Parity Tests', () {
      testWidgets('Both readers support createEpubReaderFromPath',
          (WidgetTester tester) async {
        const testPath = '/test/path/book.epub';

        final localWidget =
            localReader.createEpubReaderFromPath(filePath: testPath);
        final externalWidget =
            externalReader.createEpubReaderFromPath(filePath: testPath);

        expect(localWidget, isA<Widget>());
        expect(externalWidget, isA<Widget>());
      });

      testWidgets('Both readers support createEpubReaderFromFile',
          (WidgetTester tester) async {
        // Mock file object for testing
        final mockFile = MockFile();

        final localWidget =
            localReader.createEpubReaderFromFile(file: mockFile);
        final externalWidget =
            externalReader.createEpubReaderFromFile(file: mockFile);

        expect(localWidget, isA<Widget>());
        expect(externalWidget, isA<Widget>());
      });

      testWidgets('Both readers support createEpubReaderFromUri',
          (WidgetTester tester) async {
        const testUri = 'https://example.com/book.epub';

        final localWidget =
            localReader.createEpubReaderFromUri(rootHref: testUri);
        final externalWidget =
            externalReader.createEpubReaderFromUri(rootHref: testUri);

        expect(localWidget, isA<Widget>());
        expect(externalWidget, isA<Widget>());
      });
    });
  });
}

// Mock file class for testing
class MockFile {
  @override
  String toString() => 'MockFile(test.epub)';
}
