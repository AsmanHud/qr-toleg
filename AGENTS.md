Use the emulator under the ID `flutter_emulator` when an Android emulator is needed.
Read `PRODUCT.md` before making product or UX decisions; it is the reference for what QR Töleg is intended to build.

## Project structure

- `lib/main.dart` - Application entry point and top-level app configuration.
- `lib/l10n/app_en.arb` - English source strings for user-facing UI copy.
- `lib/l10n/app_tk.arb` - Turkmen source strings and the app's default UI language.
- `lib/l10n/app_localizations*.dart` - Flutter-generated localization classes; do not edit these by hand.
- `lib/l10n/turkmen_framework_localizations.dart` - English fallback for Flutter framework labels that do not natively support Turkmen.
- `lib/qr_payload.dart` - Shared encoding and validation for versioned QR Töleg payloads.
- `lib/screens/` - Full-screen user flows and pages.
- `lib/widgets/` - Reusable UI components shared across screens.
- `test/` - Flutter widget and unit tests.
- `test/test_app.dart` - Shared localized widget-test harness and locale lookups.
- `android/` and `ios/` - Platform-specific runner projects and configuration.
- `PRODUCT.md` - Product intent, requirements, and UX direction.
- `pubspec.yaml` - Flutter dependencies, assets, and project metadata.
- `l10n.yaml` - Flutter localization code-generation configuration.
