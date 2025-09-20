import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ebook_app/src/features/common/data/iridium/iridium_reader_interface.dart';

/// Simple EPUB reader implementation for local assets
class SimpleEpubReader implements IridiumReaderInterface {
  @override
  Widget createEpubReaderFromPath({
    Key? key,
    required String filePath,
    String? location,
    String? settings,
    String? theme,
    Function(Map<String, dynamic>)? onReturn,
  }) {
    return SimpleEpubReaderWidget(
      key: key,
      filePath: filePath,
      onReturn: onReturn,
    );
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
    return SimpleEpubReaderWidget(
      key: key,
      filePath: (file as File).path,
      onReturn: onReturn,
    );
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
    return SimpleEpubReaderWidget(
      key: key,
      filePath: rootHref,
      onReturn: onReturn,
    );
  }
}

class SimpleEpubReaderWidget extends StatefulWidget {
  final String filePath;
  final Function(Map<String, dynamic>)? onReturn;

  const SimpleEpubReaderWidget({
    super.key,
    required this.filePath,
    this.onReturn,
  });

  @override
  State<SimpleEpubReaderWidget> createState() => _SimpleEpubReaderWidgetState();
}

class _SimpleEpubReaderWidgetState extends State<SimpleEpubReaderWidget> {
  String? bookContent;
  bool isLoading = true;
  String? error;
  final PageController _pageController = PageController();
  List<String> pages = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  Future<void> _loadBook() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      String content;

      if (widget.filePath.startsWith('assets/')) {
        // Load from assets
        content = await rootBundle.loadString(widget.filePath);
      } else {
        // Load from file system
        final file = File(widget.filePath);
        if (await file.exists()) {
          content = await file.readAsString();
        } else {
          throw Exception('Book file not found');
        }
      }

      // For now, just split content into pages (simple implementation)
      pages = _splitIntoPages(content);

      setState(() {
        bookContent = content;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  List<String> _splitIntoPages(String content) {
    // Simple page splitting - in a real implementation, this would be more sophisticated
    const int wordsPerPage = 300;
    final words = content.split(' ');
    final List<String> pageList = [];

    for (int i = 0; i < words.length; i += wordsPerPage) {
      final endIndex =
          (i + wordsPerPage < words.length) ? i + wordsPerPage : words.length;
      pageList.add(words.sublist(i, endIndex).join(' '));
    }

    return pageList.isEmpty ? ['No content available'] : pageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Reader'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          if (pages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  '${currentPage + 1} / ${pages.length}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: pages.isNotEmpty ? _buildNavigationBar() : null,
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading book...'),
          ],
        ),
      );
    }

    if (error != null) {
      return Center(
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
              'Error loading book',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadBook,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (pages.isEmpty) {
      return const Center(
        child: Text('No content available'),
      );
    }

    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          currentPage = index;
        });
      },
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Text(
              pages[index],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    fontSize: 16,
                  ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: currentPage > 0 ? _previousPage : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: Slider(
              value: currentPage.toDouble(),
              min: 0,
              max: (pages.length - 1).toDouble(),
              divisions: pages.length - 1,
              onChanged: (value) {
                _goToPage(value.round());
              },
            ),
          ),
          IconButton(
            onPressed: currentPage < pages.length - 1 ? _nextPage : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  void _previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
