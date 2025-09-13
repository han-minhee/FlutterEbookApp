import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Copies an EPUB from bundled assets to a temporary file and returns its path.
/// This is needed because the reader expects a filesystem path, not an asset URI.
Future<String> copyAssetEpubToTemp(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  final tempDir = await getTemporaryDirectory();
  final fileName = p.basename(assetPath);
  final outPath = p.join(tempDir.path, 'assets_epub', fileName);

  final outFile = File(outPath);
  await outFile.create(recursive: true);
  await outFile.writeAsBytes(byteData.buffer.asUint8List());
  return outFile.path;
}



