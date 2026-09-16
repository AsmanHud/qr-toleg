# QR Töleg

QR Töleg is a Flutter mobile app that simplifies TMcell balance transfers. It
uses QR codes to share recipient phone numbers and prepares the transfer SMS for
the sender to review and send.

## Prerequisites

- Flutter with Dart 3.13.2 or newer
- Android Studio with the Android SDK and an Android emulator
- Flutter's `bin` directory on your `PATH`

Development on this repository is set up for Windows. Building the iOS app
requires macOS, Xcode, and CocoaPods.

## Setup

Verify your Flutter installation and accept the Android SDK licenses:

```powershell
flutter doctor
flutter doctor --android-licenses
```

From the project directory, install the locked dependencies:

```powershell
flutter pub get
```

Localization classes are generated automatically. To regenerate them manually,
run:

```powershell
flutter gen-l10n
```

Android emulators are local to each development machine and are not included in
the repository. Create one through Flutter before running the app:

```powershell
flutter emulators --create
flutter emulators
```

Confirm that `flutter_emulator` appears in the emulator list.

## Run

Start the emulator and run the app:

```powershell
flutter emulators --launch flutter_emulator
flutter devices
flutter run
```

For QR scanning and SMS handoff, testing on a physical Android phone is
recommended. Enable USB or Wireless debugging, connect the phone, and run:

```powershell
flutter run -d <device-id>
```

## Checks

Run static analysis and the test suite before submitting changes:

```powershell
flutter analyze
flutter test
```

See [PRODUCT.md](PRODUCT.md) for the product goals, transfer assumptions, QR
payload format, and scope.
