Use the emulator under the ID `flutter_emulator` when an Android emulator is needed.
Read `PRODUCT.md` before making product or UX decisions; it is the reference for what QR Töleg is intended to build.

## Project structure

- `lib/main.dart` - Application entry point and top-level app configuration.
- `lib/qr_payload.dart` - Shared encoding and validation for versioned QR Töleg payloads.
- `lib/screens/` - Full-screen user flows and pages.
- `lib/widgets/` - Reusable UI components shared across screens.
- `test/` - Flutter widget and unit tests.
- `android/` and `ios/` - Platform-specific runner projects and configuration.
- `PRODUCT.md` - Product intent, requirements, and UX direction.
- `pubspec.yaml` - Flutter dependencies, assets, and project metadata.
