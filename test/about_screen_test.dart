import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qrtoleg/main.dart';
import 'package:qrtoleg/screens/about_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

void main() {
  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'QR Töleg',
      packageName: 'com.example.qrtoleg',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
  });

  testWidgets('opens the About screen with app details', (tester) async {
    SharedPreferences.setMockInitialValues({
      QrTolegApp.phoneNumberPreferenceKey: '99365123456',
      QrTolegApp.languagePreferenceKey: 'en',
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(QrTolegApp(preferences: preferences));
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    expect(find.text(enL10n.informationSectionTitle), findsOneWidget);
    await tester.tap(find.byKey(const Key('about-setting')));
    await tester.pumpAndSettle();

    expect(find.text(enL10n.aboutTitle), findsOneWidget);
    expect(find.text(enL10n.aboutPurpose), findsOneWidget);
    expect(find.text(enL10n.aboutVersionLabel('1.0.0', '1')), findsOneWidget);
    expect(find.text(enL10n.aboutPrivacyTitle), findsOneWidget);
    expect(find.byKey(const Key('source-code')), findsOneWidget);
    expect(
      AboutScreen.sourceCodeUri,
      Uri.parse('https://github.com/AsmanHud/qr-toleg'),
    );
    expect(find.byKey(const Key('open-source-licenses')), findsOneWidget);
  });
}
