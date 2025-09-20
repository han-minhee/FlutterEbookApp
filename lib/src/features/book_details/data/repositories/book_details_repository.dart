import 'package:flutter_ebook_app/src/common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Local-only implementation: reuse [LocalBookRepository] to provide
/// a related feed without hitting the network.
class BookDetailsRepository extends LocalBookRepository {
  BookDetailsRepository();

  Future<BookRepositoryData> getRelatedFeed(String _ignoredUrl) {
    // We don't have remote author feeds locally. Just return the same
    // local catalog as a simple related list.
    return getCategory('related');
  }
}

final bookDetailsRepositoryProvider =
    Provider.autoDispose<BookDetailsRepository>((ref) {
  return BookDetailsRepository();
});
