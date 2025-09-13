import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/external_iridium_reader.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/iridium_reader_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Iridium Abstraction Layer Tests', () {
    testWidgets('External Iridium reader creates widget from path', (WidgetTester tester) async {
      const testPath = '/test/path/book.epub';
      
      final reader = IridiumReaderFactory.createExternalReader();
      final widget = reader.createEpubReaderFromPath(
        filePath: testPath,
      );

      expect(widget, isA<Widget>());
      
      await tester.pumpWidget(MaterialApp(home: widget));
      await tester.pumpAndSettle();
      
      // Verify the widget is rendered without errors
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('External Iridium Implementation'), findsOneWidget);
    });

    testWidgets('Factory creates external reader', (WidgetTester tester) async {
      final externalReader = IridiumReaderFactory.createExternalReader();
      expect(externalReader, isA<ExternalIridiumReader>());
    });

    testWidgets('External reader supports all interface methods', (WidgetTester tester) async {
      final reader = IridiumReaderFactory.createExternalReader();
      
      // Test createEpubReaderFromPath
      final pathWidget = reader.createEpubReaderFromPath(filePath: '/test/path');
      expect(pathWidget, isA<Widget>());
      
      // Test createEpubReaderFromFile
      final fileWidget = reader.createEpubReaderFromFile(file: MockFile());
      expect(fileWidget, isA<Widget>());
      
      // Test createEpubReaderFromUri
      final uriWidget = reader.createEpubReaderFromUri(rootHref: 'https://example.com');
      expect(uriWidget, isA<Widget>());
    });

    testWidgets('Interface methods accept all expected parameters', (WidgetTester tester) async {
      final reader = IridiumReaderFactory.createExternalReader();
      
      final widget = reader.createEpubReaderFromPath(
        key: const Key('test'),
        filePath: '/test/path',
        location: 'chapter1',
        settings: '100',
        theme: '{"backgroundColor": "#ffffff"}',
        onReturn: (data) => {},
      );
      
      expect(widget, isA<Widget>());
    });
  });
}

// Mock file class for testing
class MockFile {
  @override
  String toString() => 'MockFile(test.epub)';
}