Use the emulator under the ID `flutter_emulator` when an Android emulator is needed.
Read `PRODUCT.md` before making product or UX decisions; it is the reference for what QR Töleg is intended to build.

## Project structure

- `lib/main.dart` - Application entry point and top-level app configuration.
- `lib/l10n/app_en.arb` - Canonical English source for all user-facing UI copy.
- `lib/l10n/app_localizations*.dart` - Flutter-generated localization classes; do not edit these by hand.
- `lib/qr_payload.dart` - Shared encoding and validation for versioned QR Töleg payloads.
- `lib/screens/` - Full-screen user flows and pages.
- `lib/widgets/` - Reusable UI components shared across screens.
- `test/` - Flutter widget and unit tests.
- `android/` and `ios/` - Platform-specific runner projects and configuration.
- `PRODUCT.md` - Product intent, requirements, and UX direction.
- `pubspec.yaml` - Flutter dependencies, assets, and project metadata.
- `l10n.yaml` - Flutter localization code-generation configuration.
