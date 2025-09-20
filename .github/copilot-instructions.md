# AI Coding Agent Guide for FlutterEbookApp

This document orients AI agents to be productive quickly in this repo. Keep answers concise and actionable. Link to concrete files and follow existing patterns.

## Architecture Overview
- App: `lib/main.dart` initializes SharedPreferences (`LocalStorage.warmUp()`), Sembast DBs (`DatabaseConfig.init()`), enables path URL strategy on web, then runs `ProviderScope` with `RiverpodObserver` and `MyApp`.
- Composition: `lib/src/app.dart` wires theme, routing, and Riverpod. Fonts via `GoogleFonts.sourceSansProTextTheme`.
- Routing: AutoRoute v8 in `lib/src/common/router/app_router.dart` with generated `app_router.gr.dart`. Tabs shell hosts nested stacks (Home, Settings; Explore partially disabled). Use `@AutoRouterConfig` and `CustomRoute/CupertinoRoute`.
- State: Riverpod 2 with codegen (`riverpod_annotation`). Notifiers live under `lib/src/**/presentation/notifiers`. Generated files: `*.g.dart`.
- Data: Clean-ish layers under `lib/src/common/{data,domain,application}`.
  - Persistence: Sembast (`DatabaseConfig`) creates two DBs: `download.db`, `favorites11.db`. Access via providers in `presentation/providers/database_provider.dart`.
  - Preferences: `LocalStorage` singleton wraps `SharedPreferences`, exposed by `shared_preferences_provider.dart`.
  - Books: `BookRepository` abstraction with a local implementation (`local_book_repository.dart`) that builds OPDS-like `CategoryFeed` from `assets/books/*.epub`. A remote impl exists (`book_repository.dart` using `Dio` + `xml2json`) but UI currently uses local repo.
- UI patterns:
  - Theme constants in `presentation/theme/theme_config.dart`. Access theme via extension `context.theme` from `lib/src/common/extensions/context_extensions.dart`.
  - Reusable widgets in `lib/src/common/presentation/ui/widgets` (e.g., `DescriptionTextWidget`, loading/error dialogs).
  - Reader: embedded via local package `packages/reader_widget` and `packages/components/navigator` (mno_navigator) for EPUB rendering.

## Key Conventions
- Barrel exports: Most folders expose an `index` via `.../common.dart`, `.../data.dart`, `.../domain.dart`, `.../presentation.dart`, `features.dart`.
- Riverpod codegen: Annotate with `@riverpod`, include `part 'xxx.g.dart';`, run build_runner after changes. Providers often declared in `presentation/providers` and feature-specific `presentation/notifiers`.
- Navigation: Prefer defining routes in `AppRouter.routes`. Use nested routes for tab stacks. Generated types like `HomeRoute`, `BookDetailsRoute` come from `app_router.gr.dart`.
- Theming: Use `context.theme` and color scheme from `theme_config.dart`. App title from `src/common/constants/strings.dart` (`appName`). Dark mode preference stored as `isDarkMode` key.
- Assets: EPUB files live in `assets/books/` and are discovered via `AssetManifest.json`. When adding books, update `pubspec.yaml` assets if new folders are added.

## Typical Workflows
- Install deps:
  - `flutter pub get`
- Generate code (after changing `@riverpod` or AutoRoute):
  - `dart run build_runner build --delete-conflicting-outputs`
- Run app:
  - `flutter run` (desktop/mobile/web supported)
- Run tests:
  - `flutter test`
- Lint/format:
  - `flutter analyze`
  - `dart format .`

## Cross-Cutting Details
- Databases: Call `DatabaseConfig.getDatabaseInstance(name)` via providers; do not open your own DB connections. Names are in `DatabaseConfig.databaseNames`.
- Home/Explore data: `HomeRepository` and `ExploreRepository` currently construct with `LocalBookRepository` (local asset feed). Expect `getCategory('popular'|'recent'|<genre>)` to return `({feed, failure})`.
- Error handling: Repositories return `HttpFailure` enums in the tuple when failures occur; UI notifiers use `AsyncValue.guard` and throw `failure.description` strings.
- UI text: Long descriptions are handled by `DescriptionTextWidget` which splits >300 chars and toggles show more/less.

## Where To Start
- Add a new screen: define a `@RoutePage()` in feature, register in `AppRouter.routes`, run codegen, then navigate using generated `...Route` types.
- Add new setting or theme toggle: use `CurrentAppThemeNotifier` (`presentation/notifiers/current_app_theme`) and `CurrentAppThemeService` to persist; prefer `context.isPlatformDarkThemed` for defaults.
- Extend local library: drop new `.epub` under `assets/books/` and it will appear in feeds after rebuild; titles are derived from filenames by `LocalBookRepository._extractTitleFromFilename`.

## External Packages/Modules
- Routing: `auto_route` (+ generator)
- State: `flutter_riverpod`, `riverpod_annotation` (+ generator)
- Storage: `sembast`, `sembast_web`, `shared_preferences`
- Networking/XML: `dio`, `xml2json` (only if using remote repo)
- Reader: `packages/components/navigator` (mno_navigator), `packages/reader_widget`

## Gotchas
- Always run build_runner after modifying `@riverpod` notifiers or routes.
- `DatabaseConfig.init()` must be called before any DB access (already in `main.dart`).
- On web, `usePathUrlStrategy()` is enabled; ensure route paths are correct when deep-linking.
- Many features of Explore are trimmed in router; verify route existence before navigating.
