import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

void main() {
  testWidgets('saves the phone number and restores it on the next launch', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      QrTolegApp.languagePreferenceKey: 'en',
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(QrTolegApp(preferences: preferences));
    await tester.enterText(
      find.byKey(const Key('phone-number-field')),
      '65123456',
    );
    await tester.pump();
    final proceedButton = find.byKey(const Key('proceed-button'));
    await tester.ensureVisible(proceedButton);
    await tester.tap(proceedButton);
    await tester.pumpAndSettle();

    expect(
      preferences.containsKey(QrTolegApp.phoneNumberPreferenceKey),
      isFalse,
    );

    await tester.tap(find.byKey(const Key('confirm-phone-number')));
    await tester.pumpAndSettle();

    expect(
      preferences.getString(QrTolegApp.phoneNumberPreferenceKey),
      '99365123456',
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(QrTolegApp(preferences: preferences));

    expect(find.text(enL10n.receiveBalanceTitle), findsOneWidget);
    expect(find.text('+993 65 12 34 56'), findsOneWidget);
    expect(find.text(enL10n.enterPhoneNumberTitle), findsNothing);
  });

  testWidgets('ignores an invalid saved phone number', (tester) async {
    SharedPreferences.setMockInitialValues({
      QrTolegApp.phoneNumberPreferenceKey: 'not-a-phone-number',
      QrTolegApp.languagePreferenceKey: 'en',
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(QrTolegApp(preferences: preferences));

    expect(find.text(enL10n.enterPhoneNumberTitle), findsOneWidget);
    expect(find.text(enL10n.receiveBalanceTitle), findsNothing);
  });

  testWidgets('uses Turkmen by default', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(QrTolegApp(preferences: preferences));

    expect(find.text(tkL10n.enterPhoneNumberTitle), findsOneWidget);
    expect(find.text(enL10n.enterPhoneNumberTitle), findsNothing);
  });
}
