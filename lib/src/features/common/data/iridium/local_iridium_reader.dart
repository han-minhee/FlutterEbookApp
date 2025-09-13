import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/iridium_reader_interface.dart';
import 'package:iridium_reader_widget/views/viewers/epub_screen.dart';

/// Local Iridium reader implementation using the local packages/iridium package
/// Currently using placeholder due to compilation issues with local package
class LocalIridiumReader implements IridiumReaderInterface {
  @override
  Widget createEpubReaderFromPath({
    Key? key,
    required String filePath,
    String? location,
    String? settings,
    String? theme,
    Function(Map<String, dynamic>)? onReturn,
  }) {
    try {
      return EpubScreen.fromPath(
        key: key,
        filePath: filePath,
        location: location,
        settings: settings,
        theme: theme,
        isTextInteractionEnabled: true,
      );
    } catch (e) {
      return _createErrorWidget('Failed to load local Iridium: $e', filePath);
    }
  }

  @override
  Widget createEpubReaderFromFile({
    Key? key,
    required dynamic file,
    String? location,
    String? settings,
    String? theme,
    Function(Map<String, dynamic>)? onReturn,
  }) {
    try {
      return EpubScreen.fromFile(
        key: key,
        file: file,
        location: location,
        settings: settings,
        theme: theme,
        isTextInteractionEnabled: true,
      );
    } catch (e) {
      return _createErrorWidget('Failed to load local Iridium: $e', file.toString());
    }
  }

  @override
  Widget createEpubReaderFromUri({
    Key? key,
    required String rootHref,
    String? location,
    String? settings,
    String? theme,
    Function(Map<String, dynamic>)? onReturn,
  }) {
    try {
      return EpubScreen.fromUri(
        key: key,
        rootHref: rootHref,
        location: location,
        settings: settings,
        theme: theme,
        isTextInteractionEnabled: true, // Enable text selection for highlighting
      );
    } catch (e) {
      return _createErrorWidget('Failed to load local Iridium: $e', rootHref);
    }
  }

  Widget _createErrorWidget(String error, String details) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reader Error'),
        backgroundColor: Colors.red.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to load book',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              details,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Could navigate back or try again
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createPlaceholderWidget(String message) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Iridium Reader'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.folder,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Local Iridium Implementation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'This placeholder demonstrates the abstraction layer. '
                'Replace with actual local Iridium implementation when compilation issues are resolved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}