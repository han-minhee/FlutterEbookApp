import 'package:flutter/material.dart';

/// Abstract interface for Iridium reader implementations
abstract class IridiumReaderInterface {
  /// Optional callbacks to integrate reader-side actions into the host app.
  /// If provided, the reader will invoke these when the user taps corresponding
  /// actions in the floating panel.
  static void Function(String text)? onTranslate;
  static void Function(String text)? onExtraInfo;
  static void Function(String text)? onTts;
  /// Creates an EPUB reader widget from a file path
  Widget createEpubReaderFromPath({
    Key? key,
    required String filePath,
    String? location,
    String? settings,
    String? theme,
    Function(Map<String, dynamic>)? onReturn,
  });

  /// Creates an EPUB reader widget from a file
  Widget createEpubReaderFromFile({
    Key? key,
    required dynamic file,
    String? location,
    String? settings,
    String? theme,
    Function(Map<String, dynamic>)? onReturn,
  });

  /// Creates an EPUB reader widget from a URI
  Widget createEpubReaderFromUri({
    Key? key,
    required String rootHref,
    String? location,
    String? settings,
    String? theme,
    Function(Map<String, dynamic>)? onReturn,
  });
}
