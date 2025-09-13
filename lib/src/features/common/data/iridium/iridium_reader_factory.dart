import 'package:flutter_ebook_app/src/features/common/data/iridium/external_iridium_reader.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/iridium_reader_interface.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/local_iridium_reader.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/simple_epub_reader.dart';

/// Factory for creating Iridium reader instances
class IridiumReaderFactory {
  static const bool _useSimpleReader = false; // Use local iridium reader for text selection support

  /// Creates an Iridium reader instance based on configuration
  static IridiumReaderInterface createReader() {
    if (_useSimpleReader) {
      return SimpleEpubReader();
    } else {
      // Use the included local Iridium implementation by default
      return LocalIridiumReader();
    }
  }

  /// Creates a local Iridium reader instance (for testing)
  static IridiumReaderInterface createLocalReader() {
    return LocalIridiumReader();
  }

  /// Creates an external Iridium reader instance (for testing)
  static IridiumReaderInterface createExternalReader() {
    return ExternalIridiumReader();
  }

  /// Creates a simple reader instance
  static IridiumReaderInterface createSimpleReader() {
    return SimpleEpubReader();
  }
}