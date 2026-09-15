import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('saves the phone number and restores it on the next launch', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
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

    expect(find.text('Receive balance'), findsOneWidget);
    expect(find.text('+993 65 12 34 56'), findsOneWidget);
    expect(find.text('Enter your phone number'), findsNothing);
  });

  testWidgets('ignores an invalid saved phone number', (tester) async {
    SharedPreferences.setMockInitialValues({
      QrTolegApp.phoneNumberPreferenceKey: 'not-a-phone-number',
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(QrTolegApp(preferences: preferences));

    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.text('Receive balance'), findsNothing);
  });
}
