<!-- Copilot / AI agent instructions for FlutterEbookApp -->

Purpose
- Help AI coding agents be immediately productive in this repository by describing the app architecture, developer workflows, and project-specific conventions.

Quick facts
- Language: Dart / Flutter (SDK >=3.0.0)
- State management: `flutter_riverpod` (generated Riverpod notifiers via `riverpod_annotation`)
- Routing: `auto_route` with generated router (`lib/src/common/router/app_router.gr.dart`)
- Local DB: `sembast` (see `lib/src/common/data/database/database_config.dart`)
- Custom reader widget: local package `packages/reader_widget` used via path dependency

What to know about architecture (big picture)
- App entry: `lib/main.dart` – initializes local storage and DB, sets URL strategy for web, and starts `ProviderScope` + `MyApp`.
- App shell: `lib/src/app.dart` – `MaterialApp.router` using `AppRouter` and Riverpod theme provider.
- Shared layer: `lib/src/common/` contains application services, data layer, presentation widgets, providers, and generated code examples. Treat `common` as the boundary between features and platform integration.
- Features: `lib/src/features/` contains UI screens and feature-specific logic; use providers and services in `common` to access shared resources.
- Platform adapters: `lib/src/common/data/remote/adapter/` uses conditional imports to pick the right HTTP adapter for web vs mobile (`web_adapter.dart` / `mobile_adapter.dart`). Use `getAdapter()` through `app_dio.dart`.

Project-specific conventions and patterns
- Riverpod: project uses `@riverpod` annotated classes that generate `.g.dart` files. Look for `part '...g.dart'` at top of notifier files (e.g. `current_app_theme_notifier.dart`). Regenerate with `build_runner` when changing annotations.
- Generated code: `auto_route` and `freezed`/`riverpod` code is generated. Do not hand-edit `*.gr.dart` or `*.g.dart` files.
- Local packages: `packages/reader_widget` is a local package referenced via `pubspec.yaml`. When changing it, run `flutter pub get` at repo root to pick up local changes.
- Database: `sembast` stores app data. Database instances are provided via Riverpod providers in `lib/src/common/presentation/providers/database_provider.dart`.
- Assets: ePub samples are under `assets/books/` and images under `assets/images/`. The app expects these asset paths as declared in `pubspec.yaml`.

Common developer workflows (commands)
- Install deps: `flutter pub get`
- Run on device/emulator: `flutter run` (or use platform-specific targets like `-d windows`, `-d chrome`)
- Run web locally: `flutter run -d chrome` (the app uses `usePathUrlStrategy()` in `main.dart` so routes are path-based)
- Regenerate code (auto_route / riverpod / freezed):
  - `flutter pub run build_runner build --delete-conflicting-outputs`
  - For incremental work, `--watch` can be used: `flutter pub run build_runner watch`
- Run tests: `flutter test`
- Analyze: `flutter analyze`

Files and locations to reference when changing parts of the app
- App bootstrap: `lib/main.dart`
- Router config: `lib/src/common/router/app_router.dart` and generated `app_router.gr.dart`
- Shared services & providers: `lib/src/common/application/` and `lib/src/common/presentation/providers/`
- Data layer + DB: `lib/src/common/data/database/` and `lib/src/common/data/local/`
- HTTP client: `lib/src/common/data/remote/app_dio.dart` and `lib/src/common/data/remote/adapter/`
- UI conventions and widgets: `lib/src/common/presentation/ui/widgets/`
- Local package: `packages/reader_widget/` (reader implementation used by features)

Examples (how to make common edits)
- Adding a Riverpod notifier method:
  - Edit the notifier (e.g. `lib/src/common/presentation/notifiers/...`)
  - Ensure `part '...g.dart'` remains present
  - Run build_runner to generate updated provider code
- Adding a route:
  - Update `lib/src/common/router/app_router.dart` to add an `AutoRoute`
  - Run build_runner to generate `app_router.gr.dart`
- Changing HTTP behavior per platform:
  - Edit or inspect `lib/src/common/data/remote/adapter/*` for platform-specific adapters
  - `app_dio.dart` chooses the adapter via `getAdapter()` and registers interceptors

Gotchas and small details
- Many files rely on generated code; build failures often mean a missing `g.dart` or `gr.dart` file. Run `build_runner` and check for `part` mismatches.
- Conditional imports are used for platform-specific behavior (see `adapter.dart`). When editing, keep conditional import shape intact to avoid cross-platform runtime issues.
- Database initialization: `LocalStorage.warmUp()` and `DatabaseConfig.init(...)` are called before `runApp` in `main.dart`. Avoid async side-effects that expect the DB to exist before these calls complete.
- Web routes: `usePathUrlStrategy()` flips behavior of the URL; tests or scripts that assume hash-based routing will fail.

If you change build or runtime scripts
- Update `pubspec.yaml` and mention any required `flutter` or platform flags in this file after discussion with maintainers.

When adding new files
- Place shared logic in `lib/src/common/` and feature UIs under `lib/src/features/`.
- Add exports to the relevant barrel files (e.g., `lib/src/common/common.dart`) when you add a new public module.

If you're unsure
- Inspect `lib/main.dart`, `lib/src/app.dart`, and `lib/src/common/` first.
- Run `flutter pub get` and `flutter pub run build_runner build` to reproduce common local build issues.

Contact / feedback
- After applying changes, run `flutter run` and `flutter test`. If something is failing, report the failing command and the short stack trace.
