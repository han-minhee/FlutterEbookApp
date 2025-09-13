# Requirements Document

## Introduction

This feature involves modernizing the Flutter ebook app by migrating to external Iridium library, updating dependencies, implementing search functionality, and migrating the UI to ForUI. The goal is to improve maintainability, performance, and user experience while leveraging modern Flutter libraries and best practices.

## Requirements

### Requirement 1

**User Story:** As a developer, I want to use the external Iridium library instead of the local package, so that I can benefit from community updates and reduce maintenance overhead.

#### Acceptance Criteria

1. WHEN the app is built THEN it SHALL use the han-minhee/iridium library from GitHub instead of the local packages/iridium
2. WHEN the external Iridium library is integrated THEN the app SHALL maintain all existing epub reading functionality
3. WHEN the migration is complete THEN the local packages/iridium directory SHALL be removed
4. IF the external library lacks required functionality THEN the system SHALL extend or fork the library appropriately

### Requirement 2

**User Story:** As a developer, I want all dependencies updated to their latest versions, so that the app benefits from security patches, performance improvements, and new features.

#### Acceptance Criteria

1. WHEN dependencies are updated THEN all packages in pubspec.yaml SHALL be upgraded to their latest compatible versions
2. WHEN dependency updates are applied THEN the app SHALL compile without errors
3. WHEN the app runs with updated dependencies THEN all existing functionality SHALL work correctly
4. IF breaking changes exist in updated dependencies THEN the code SHALL be refactored to maintain compatibility
5. WHEN dependency overrides exist THEN they SHALL be evaluated for removal or update

### Requirement 3

**User Story:** As a reader, I want to search for text within epub books and see highlighted results, so that I can quickly find specific content.

#### Acceptance Criteria

1. WHEN a user opens the search interface THEN they SHALL be able to enter search terms
2. WHEN a user performs a search THEN the system SHALL find all matching text within the current epub
3. WHEN search results are found THEN they SHALL be displayed with context and page/chapter information
4. WHEN a user selects a search result THEN the system SHALL navigate to that location and highlight the text
5. WHEN text is highlighted THEN it SHALL be visually distinct from regular text
6. WHEN no search results are found THEN the system SHALL display an appropriate message
7. IF the Iridium library lacks search functionality THEN it SHALL be extended or modified to support search

### Requirement 4

**User Story:** As a developer, I want the UI migrated to ForUI, so that the app uses a modern, consistent design system with better accessibility and theming.

#### Acceptance Criteria

1. WHEN the UI migration is complete THEN all screens SHALL use ForUI components instead of Material Design
2. WHEN ForUI components are implemented THEN they SHALL maintain the same functionality as existing UI elements
3. WHEN the app is themed THEN it SHALL use ForUI's theming system consistently
4. WHEN users interact with UI elements THEN they SHALL have the same or improved user experience
5. WHEN the migration is complete THEN no Material Design components SHALL remain except where ForUI equivalents don't exist
6. IF ForUI lacks equivalent components THEN custom components SHALL be created following ForUI design principles
7. WHEN the app supports dark/light themes THEN ForUI theming SHALL handle theme switching appropriately

### Requirement 5

**User Story:** As a developer, I want proper error handling and logging during the modernization process, so that issues can be quickly identified and resolved.

#### Acceptance Criteria

1. WHEN errors occur during library integration THEN they SHALL be logged with appropriate context
2. WHEN dependency conflicts arise THEN they SHALL be documented and resolved systematically
3. WHEN UI components are migrated THEN any rendering issues SHALL be caught and addressed
4. WHEN search functionality is implemented THEN search errors SHALL be handled gracefully
5. WHEN the app encounters epub parsing issues THEN appropriate fallback behavior SHALL be implemented

### Requirement 6

**User Story:** As a user, I want the app to maintain backward compatibility with existing epub files and user data, so that my reading progress and library are preserved.

#### Acceptance Criteria

1. WHEN the app is updated THEN existing epub files SHALL continue to open correctly
2. WHEN user data exists THEN reading progress, bookmarks, and preferences SHALL be preserved
3. WHEN the database schema changes THEN migration scripts SHALL handle existing data appropriately
4. WHEN the UI changes THEN user workflows SHALL remain intuitive and familiar
5. IF data migration is required THEN it SHALL happen automatically without user intervention