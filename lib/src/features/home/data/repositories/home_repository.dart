import 'package:flutter_ebook_app/src/common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeRepository {
  final BookRepository _bookRepository;

  HomeRepository(this._bookRepository);

  Future<BookRepositoryData> getPopularHomeFeed() {
    return _bookRepository.getCategory('popular');
  }

  Future<BookRepositoryData> getRecentHomeFeed() {
    return _bookRepository.getCategory('recent');
  }
}

final homeRepositoryProvider = Provider.autoDispose<HomeRepository>((ref) {
  // Use local book repository for now
  final localBookRepo = LocalBookRepository();
  return HomeRepository(localBookRepo);
});
