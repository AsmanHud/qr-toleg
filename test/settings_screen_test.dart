import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

void main() {
  testWidgets('reset clears the saved phone number', (tester) async {
    SharedPreferences.setMockInitialValues({
      QrTolegApp.phoneNumberPreferenceKey: '99365123456',
      QrTolegApp.languagePreferenceKey: 'en',
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(QrTolegApp(preferences: preferences));
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    expect(find.text(enL10n.settingsTitle), findsOneWidget);
    expect(find.text(enL10n.resetPhoneNumberTitle), findsOneWidget);

    await tester.tap(find.byKey(const Key('reset-phone-number')));
    await tester.pumpAndSettle();
    expect(find.text(enL10n.resetPhoneNumberQuestion), findsOneWidget);

    await tester.tap(find.byKey(const Key('confirm-reset-phone-number')));
    await tester.pumpAndSettle();

    expect(
      preferences.containsKey(QrTolegApp.phoneNumberPreferenceKey),
      isFalse,
    );
    expect(find.text(enL10n.enterPhoneNumberTitle), findsOneWidget);
    expect(find.text(enL10n.receiveBalanceTitle), findsNothing);
  });

  testWidgets('changes language and restores it on restart', (tester) async {
    SharedPreferences.setMockInitialValues({
      QrTolegApp.phoneNumberPreferenceKey: '99365123456',
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(QrTolegApp(preferences: preferences));
    expect(find.text(tkL10n.receiveBalanceTitle), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text(tkL10n.settingsTitle), findsOneWidget);

    await tester.tap(find.byKey(const Key('language-setting')));
    await tester.pumpAndSettle();
    expect(find.text(tkL10n.selectLanguageTitle), findsOneWidget);

    await tester.tap(find.byKey(const Key('language-option-en')));
    await tester.pumpAndSettle();

    expect(find.text(enL10n.settingsTitle), findsOneWidget);
    expect(preferences.getString(QrTolegApp.languagePreferenceKey), 'en');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(QrTolegApp(preferences: preferences));

    expect(find.text(enL10n.receiveBalanceTitle), findsOneWidget);
    expect(find.text(tkL10n.receiveBalanceTitle), findsNothing);
  });
}
