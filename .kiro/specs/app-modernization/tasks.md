# Implementation Plan

- [x] 1. Setup foundation and dependency updates
  - Update pubspec.yaml with latest dependency versions, resolving any version conflicts
  - Run flutter pub upgrade and fix any immediate compilation errors
  - Update auto_route configuration for latest version compatibility
  - Update riverpod code generation patterns to match latest version
  - Create comprehensive test suite to validate existing functionality still works
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_

- [-] 2. Integrate external Iridium library
  - Add han-minhee/iridium dependency to pubspec.yaml alongside existing local package
  - Create abstraction layer for Iridium reader to support both implementations
  - Update all imports from local iridium package to use abstraction layer
  - Implement feature parity testing between local and external Iridium implementations
  - Remove local packages/iridium directory and update all references
  - _Requirements: 1.1, 1.2, 1.3_

- [ ] 3. Implement search data models and services
  - Create SearchQuery and SearchResult data models using freezed
  - Implement EpubSearchService class with text extraction capabilities
  - Create search state management using Riverpod providers
  - Write unit tests for search data models and service methods
  - Implement EPUB content parsing for searchable text extraction
  - _Requirements: 3.1, 3.2, 3.6_

- [ ] 4. Implement search functionality in Iridium integration
  - Extend Iridium reader interface to support search operations
  - Implement JavaScript injection for text highlighting in WebView
  - Create search result navigation integration with Iridium's positioning system
  - Implement search result highlighting with visual distinction
  - Add search error handling and fallback behaviors
  - _Requirements: 3.2, 3.3, 3.4, 3.5, 1.4_

- [ ] 5. Create search UI components with Material Design (temporary)
  - Implement search input interface with Material Design components
  - Create search results display with context and navigation
  - Implement search result selection and navigation functionality
  - Add search loading states and error message displays
  - Create search history and recent searches functionality
  - _Requirements: 3.1, 3.3, 3.6_

- [ ] 6. Setup ForUI foundation and theming
  - Add ForUI dependency to pubspec.yaml
  - Create AppTheme class with light and dark ForUI themes
  - Implement theme switching mechanism using ForUI theming system
  - Create ForUI error boundary component for error handling
  - Setup ForUI app-wide configuration and theme provider
  - _Requirements: 4.3, 4.7_

- [ ] 7. Create ForUI component library and mapping utilities
  - Create reusable ForUI wrapper components for common UI patterns
  - Implement component mapping utilities (Scaffold -> FScaffold, etc.)
  - Create custom ForUI components for app-specific needs
  - Implement ForUI-based navigation components
  - Write widget tests for all custom ForUI components
  - _Requirements: 4.1, 4.2, 4.6_

- [ ] 8. Migrate core screens to ForUI
- [ ] 8.1 Migrate splash screen to ForUI components
  - Replace Material Scaffold with FScaffold in splash screen
  - Update splash screen styling to use ForUI theming
  - Test splash screen functionality and visual consistency
  - _Requirements: 4.1, 4.2, 4.4_

- [ ] 8.2 Migrate home screens (small and large) to ForUI
  - Replace Material AppBar with FHeader in home screens
  - Convert Material Scaffold to FScaffold with proper ForUI styling
  - Update home screen layouts to use ForUI spacing and typography
  - Test responsive behavior with ForUI components
  - _Requirements: 4.1, 4.2, 4.4_

- [ ] 8.3 Migrate navigation and tabs to ForUI
  - Replace BottomNavigationBar with FBottomNavigationBar
  - Update tab navigation styling to match ForUI design system
  - Implement ForUI-based navigation drawer for large screens
  - Test navigation functionality across all screen sizes
  - _Requirements: 4.1, 4.2, 4.4_

- [ ] 9. Migrate remaining screens to ForUI
- [ ] 9.1 Migrate book details screen to ForUI
  - Replace Material components with ForUI equivalents in book details
  - Update book cover display and metadata styling with ForUI
  - Convert action buttons to ForUI button components
  - Test book details functionality and visual consistency
  - _Requirements: 4.1, 4.2, 4.4_

- [ ] 9.2 Migrate settings and preferences screens to ForUI
  - Replace Material list components with ForUI list tiles
  - Update settings toggles and inputs to use ForUI form components
  - Implement ForUI-based preference categories and sections
  - Test settings functionality and theme switching
  - _Requirements: 4.1, 4.2, 4.4, 4.7_

- [ ] 9.3 Migrate explore and genre screens to ForUI
  - Convert Material cards to FCard components for book listings
  - Update grid and list layouts to use ForUI spacing system
  - Replace Material search components with ForUI equivalents
  - Test explore functionality and book discovery features
  - _Requirements: 4.1, 4.2, 4.4_

- [ ] 10. Integrate search functionality with ForUI components
  - Replace temporary Material search UI with ForUI search components
  - Implement ForUI-based search input with proper styling and accessibility
  - Create ForUI search results display with highlighting support
  - Update search navigation to work seamlessly with ForUI theming
  - Test complete search workflow with ForUI integration
  - _Requirements: 3.1, 3.3, 3.4, 4.1, 4.2_

- [ ] 11. Implement comprehensive error handling and logging
  - Add error logging for Iridium integration issues
  - Implement ForUI error displays for search and navigation failures
  - Create user-friendly error messages for dependency conflicts
  - Add error recovery mechanisms for EPUB parsing failures
  - Test error scenarios and ensure graceful degradation
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [ ] 12. Ensure backward compatibility and data migration
  - Implement database migration scripts for any schema changes
  - Test existing EPUB file compatibility with updated Iridium
  - Verify user data preservation (bookmarks, progress, preferences)
  - Create data validation and repair utilities for corrupted data
  - Test upgrade scenarios from previous app versions
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [ ] 13. Performance optimization and final testing
  - Profile memory usage with updated dependencies and ForUI components
  - Optimize search performance for large EPUB files
  - Implement lazy loading for search results and UI components
  - Run comprehensive integration tests across all features
  - Perform visual regression testing for UI consistency
  - _Requirements: 2.3, 3.2, 4.4_

- [ ] 14. Final integration and cleanup
  - Remove all Material Design component references except where ForUI equivalents don't exist
  - Clean up unused dependencies and imports
  - Update documentation and code comments for new architecture
  - Verify all requirements are met through final acceptance testing
  - Create deployment checklist and rollback procedures
  - _Requirements: 4.5, 2.4, 1.3_