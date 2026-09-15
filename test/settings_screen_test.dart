import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('reset clears the saved phone number', (tester) async {
    SharedPreferences.setMockInitialValues({
      QrTolegApp.phoneNumberPreferenceKey: '99365123456',
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(QrTolegApp(preferences: preferences));
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Reset phone number'), findsOneWidget);

    await tester.tap(find.byKey(const Key('reset-phone-number')));
    await tester.pumpAndSettle();
    expect(find.text('Reset phone number?'), findsOneWidget);

    await tester.tap(find.byKey(const Key('confirm-reset-phone-number')));
    await tester.pumpAndSettle();

    expect(
      preferences.containsKey(QrTolegApp.phoneNumberPreferenceKey),
      isFalse,
    );
    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.text('Receive balance'), findsNothing);
  });
}
