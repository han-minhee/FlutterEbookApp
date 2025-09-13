import 'package:flutter_ebook_app/src/common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreRepository {
  final BookRepository _bookRepository;

  ExploreRepository(this._bookRepository);

  Future<BookRepositoryData> getGenreFeed(String genre) {
    // For local repository, we'll just use the genre as the category
    return _bookRepository.getCategory(genre);
  }
}

final exploreRepositoryProvider =
    Provider.autoDispose<ExploreRepository>((ref) {
  // Use local book repository for now
  final localBookRepo = LocalBookRepository();
  return ExploreRepository(localBookRepo);
});
