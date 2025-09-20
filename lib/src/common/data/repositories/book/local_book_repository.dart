import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_ebook_app/src/common/common.dart';

class LocalBookRepository implements BookRepository {
  static const String booksAssetPath = 'assets/books/';

  @override
  Future<BookRepositoryData> getCategory(String category) async {
    try {
      // Get list of book files from assets
      final assetManifest = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(assetManifest);
      final bookAssets = manifestMap.keys
          .where((String key) => key.startsWith(booksAssetPath))
          .where((String key) => key.endsWith('.epub'))
          .toList();

      // Create entries from file paths (simplified without EPUB parsing)
      final entries = <Entry>[];
      for (final assetPath in bookAssets) {
        final entry = _createEntryFromPath(assetPath);
        entries.add(entry);
      }

      // Create a CategoryFeed with the parsed entries
      final categoryFeed = _createCategoryFeed(category, entries);

      return (feed: categoryFeed, failure: null);
    } catch (e) {
      return (feed: null, failure: HttpFailure.unknown);
    }
  }

  Entry _createEntryFromPath(String assetPath) {
    // Extract filename from path
    final fileName = assetPath.split('/').last;
    final title = _extractTitleFromFilename(fileName);

    return Entry(
      title: Id(t: title),
      id: Id(t: assetPath),
      author: Author1(
        name: Id(t: 'Unknown Author'), // Could be enhanced with metadata
      ),
      summary: Id(t: 'Local book from library'),
      published: Id(t: DateTime.now().toIso8601String()),
      updated: Id(t: DateTime.now().toIso8601String()),
      dctermsLanguage: Id(t: 'en'),
      link: [
        Link1(
          type: 'application/epub+zip',
          rel: 'http://opds-spec.org/acquisition',
          title: 'Download',
          href: assetPath,
        ),
      ],
    );
  }

  String _extractTitleFromFilename(String filename) {
    // Remove .epub extension and convert underscores/hyphens to spaces
    return filename
        .replaceAll('.epub', '')
        .replaceAll('_', ' ')
        .replaceAll('-', ' ')
        .split(' ')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : word)
        .join(' ');
  }

  CategoryFeed _createCategoryFeed(String category, List<Entry> entries) {
    return CategoryFeed(
      version: '1.0',
      encoding: 'UTF-8',
      feed: Feed(
        xmlLang: 'en',
        xmlns: 'http://www.w3.org/2005/Atom',
        xmlnsDcterms: 'http://purl.org/dc/terms/',
        xmlnsThr: 'http://purl.org/syndication/thread/1.0',
        xmlnsApp: 'http://www.w3.org/2007/app',
        xmlnsOpensearch: 'http://a9.com/-/spec/opensearch/1.1/',
        xmlnsOpds: 'http://opds-spec.org/2010/catalog',
        xmlnsXsi: 'http://www.w3.org/2001/XMLSchema-instance',
        xmlnsOdl: 'http://opds-spec.org/odl',
        xmlnsSchema: 'http://schema.org/',
        id: Id(t: 'urn:uuid:${DateTime.now().millisecondsSinceEpoch}'),
        title: Id(t: 'Local Library - $category'),
        updated: Id(t: DateTime.now().toIso8601String()),
        author: Author(name: Id(t: 'Local Library')),
        link: [
          Link(
            rel: 'self',
            type: 'application/atom+xml;profile=opds-catalog',
            href: '/local/$category',
          ),
        ],
        opensearchTotalResults: Id(t: entries.length.toString()),
        opensearchItemsPerPage: Id(t: entries.length.toString()),
        opensearchStartIndex: Id(t: '1'),
        entry: entries,
      ),
    );
  }
}
