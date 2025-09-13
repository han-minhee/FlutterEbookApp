# Design Document

## Overview

This design outlines the modernization of the Flutter ebook app through four major components: migrating to external Iridium library, updating dependencies, implementing search functionality, and migrating the UI to ForUI. The approach prioritizes incremental changes to minimize risk while achieving comprehensive modernization.

## Architecture

### Current Architecture
- **UI Layer**: Material Design components with responsive layouts (small/large screen variants)
- **State Management**: Flutter Riverpod with code generation
- **Routing**: Auto Route for navigation
- **Data Layer**: Sembast database with local storage
- **Ebook Rendering**: Local Iridium package with WebView-based rendering

### Target Architecture
- **UI Layer**: ForUI components with consistent theming and accessibility
- **State Management**: Updated Riverpod with latest patterns
- **Routing**: Updated Auto Route with latest features
- **Data Layer**: Updated Sembast with improved performance
- **Ebook Rendering**: External han-minhee/iridium with enhanced search capabilities

## Components and Interfaces

### 1. Iridium Library Migration

#### External Library Integration
```dart
// New dependency structure
dependencies:
  iridium_reader_widget:
    git:
      url: https://github.com/han-minhee/iridium.git
      path: packages/iridium_reader_widget
```

#### Migration Strategy
- **Phase 1**: Add external dependency alongside local package
- **Phase 2**: Update imports and verify functionality parity
- **Phase 3**: Remove local package and clean up references
- **Phase 4**: Extend external library for search functionality if needed

#### Interface Compatibility
```dart
abstract class IridiumReaderInterface {
  Widget buildReader({required String filePath});
  Future<void> navigateToLocation(String location);
  Stream<ReadingProgress> get progressStream;
  Future<List<SearchResult>> searchText(String query); // New method
}
```

### 2. Dependency Updates

#### Update Strategy
- **Automated Updates**: Use `flutter pub upgrade` for compatible updates
- **Manual Updates**: Handle breaking changes in major version updates
- **Testing**: Comprehensive testing after each batch of updates

#### Critical Dependencies
```yaml
# Target versions (latest as of design)
auto_route: ^8.0.0  # From 7.8.4
dio: ^5.4.0         # Already latest
flutter_riverpod: ^2.5.0  # From 2.3.6
cached_network_image: ^3.3.0  # Already latest
```

#### Breaking Changes Handling
- **Auto Route**: Update route generation and navigation patterns
- **Riverpod**: Migrate to latest code generation patterns
- **Flutter InAppWebView**: Update WebView integration in Iridium

### 3. Search and Highlighting Implementation

#### Search Architecture
```dart
class EpubSearchService {
  Future<List<SearchResult>> searchInEpub(String filePath, String query);
  Future<void> highlightText(String location, String text);
  void clearHighlights();
}

class SearchResult {
  final String text;
  final String context;
  final String location;
  final int chapterIndex;
  final String chapterTitle;
}
```

#### Implementation Approach
1. **Text Extraction**: Extract text content from EPUB chapters
2. **Search Algorithm**: Implement full-text search with context
3. **Highlighting**: Inject CSS/JavaScript for text highlighting
4. **Navigation**: Integrate with Iridium's navigation system

#### WebView Integration
```javascript
// Injected JavaScript for highlighting
function highlightText(searchTerm) {
  // Implementation for highlighting search results
  // Integration with Iridium's WebView rendering
}
```

### 4. ForUI Migration

#### Component Mapping
```dart
// Material -> ForUI component mapping
Scaffold -> FScaffold
AppBar -> FHeader
BottomNavigationBar -> FBottomNavigationBar
FloatingActionButton -> FButton (with appropriate styling)
Card -> FCard
ListTile -> FListTile
```

#### Theme Integration
```dart
class AppTheme {
  static FThemeData lightTheme = FThemeData(
    colorScheme: FColorScheme.light(),
    typography: FTypography.material(),
  );
  
  static FThemeData darkTheme = FThemeData(
    colorScheme: FColorScheme.dark(),
    typography: FTypography.material(),
  );
}
```

#### Migration Strategy
- **Screen-by-Screen**: Migrate one screen at a time
- **Component Library**: Create reusable ForUI-based components
- **Theme Consistency**: Ensure consistent theming across all screens
- **Accessibility**: Leverage ForUI's built-in accessibility features

## Data Models

### Search Data Models
```dart
@freezed
class SearchQuery with _$SearchQuery {
  const factory SearchQuery({
    required String term,
    required String bookPath,
    @Default(false) bool caseSensitive,
    @Default(false) bool wholeWords,
  }) = _SearchQuery;
}

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String matchedText,
    required String contextBefore,
    required String contextAfter,
    required String chapterTitle,
    required int chapterIndex,
    required String cfi, // Canonical Fragment Identifier
    required int startOffset,
    required int endOffset,
  }) = _SearchResult;
}
```

### Enhanced Book Models
```dart
@freezed
class BookMetadata with _$BookMetadata {
  const factory BookMetadata({
    required String title,
    required String author,
    required String filePath,
    @Default([]) List<String> searchableContent,
    @Default(false) bool isSearchIndexed,
    DateTime? lastSearchIndexUpdate,
  }) = _BookMetadata;
}
```

## Error Handling

### Migration Error Handling
```dart
class MigrationException implements Exception {
  final String message;
  final String component;
  final Exception? originalException;
  
  const MigrationException(this.message, this.component, [this.originalException]);
}

class ErrorHandler {
  static void handleMigrationError(MigrationException error) {
    // Log error with context
    // Provide fallback behavior
    // Notify user if necessary
  }
}
```

### Search Error Handling
```dart
sealed class SearchState {
  const SearchState();
}

class SearchLoading extends SearchState {}
class SearchSuccess extends SearchState {
  final List<SearchResult> results;
  const SearchSuccess(this.results);
}
class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);
}
```

### UI Error Handling
```dart
class ForUIErrorBoundary extends StatelessWidget {
  final Widget child;
  final Widget Function(Object error)? errorBuilder;
  
  const ForUIErrorBoundary({
    required this.child,
    this.errorBuilder,
  });
  
  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      child: child,
      onError: (error, stackTrace) {
        // Log error and show ForUI error component
      },
    );
  }
}
```

## Testing Strategy

### Unit Testing
- **Service Layer**: Test search functionality, data models, and business logic
- **Widget Testing**: Test individual ForUI components and their behavior
- **Integration Testing**: Test Iridium integration and navigation flows

### Migration Testing
```dart
group('Iridium Migration Tests', () {
  testWidgets('External Iridium maintains reading functionality', (tester) async {
    // Test that external library works identically to local package
  });
  
  testWidgets('Search functionality works with external Iridium', (tester) async {
    // Test search integration
  });
});

group('ForUI Migration Tests', () {
  testWidgets('ForUI components render correctly', (tester) async {
    // Test UI component migration
  });
  
  testWidgets('Theme switching works with ForUI', (tester) async {
    // Test theming functionality
  });
});
```

### Performance Testing
- **Memory Usage**: Monitor memory consumption with updated dependencies
- **Rendering Performance**: Ensure ForUI components perform well
- **Search Performance**: Benchmark search functionality across different book sizes

## Implementation Phases

### Phase 1: Foundation (Dependencies & Iridium)
1. Update all dependencies to latest versions
2. Resolve any breaking changes
3. Integrate external Iridium library
4. Remove local Iridium package
5. Verify all existing functionality works

### Phase 2: Search Implementation
1. Implement text extraction from EPUB files
2. Create search service and data models
3. Integrate search with Iridium WebView
4. Implement highlighting functionality
5. Create search UI components

### Phase 3: ForUI Migration
1. Add ForUI dependency and setup theming
2. Create component mapping and reusable widgets
3. Migrate screens one by one (starting with simplest)
4. Update navigation and routing for ForUI
5. Implement comprehensive theming

### Phase 4: Integration & Polish
1. Integrate search functionality with ForUI components
2. Comprehensive testing and bug fixes
3. Performance optimization
4. Documentation updates
5. Final validation and cleanup

## Risk Mitigation

### Dependency Conflicts
- **Strategy**: Update dependencies in small batches
- **Fallback**: Maintain dependency overrides for critical conflicts
- **Testing**: Comprehensive testing after each update batch

### Iridium Integration Issues
- **Strategy**: Maintain local package during transition
- **Fallback**: Fork external library if modifications needed
- **Testing**: Side-by-side comparison testing

### ForUI Compatibility
- **Strategy**: Gradual migration with fallback to Material components
- **Fallback**: Custom components following ForUI patterns
- **Testing**: Visual regression testing for UI consistency

### Performance Degradation
- **Strategy**: Continuous performance monitoring
- **Fallback**: Optimize or revert problematic changes
- **Testing**: Benchmark testing throughout migration