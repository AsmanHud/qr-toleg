import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/main.dart';
import 'package:qrtoleg/screens/home_screen.dart';
import 'package:qrtoleg/widgets/personal_qr.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('asks for an 8-digit TMcell number before showing the QR', (
    tester,
  ) async {
    await tester.pumpWidget(const QrTolegApp());

    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.byKey(const Key('phone-country-code')), findsOneWidget);
    expect(find.byKey(const Key('personal-qr')), findsNothing);

    final proceedButton = find.byKey(const Key('proceed-button'));
    expect(tester.widget<FilledButton>(proceedButton).onPressed, isNull);

    await tester.enterText(
      find.byKey(const Key('phone-number-field')),
      'ab71123456789',
    );
    await tester.pump();

    expect(find.text('71123456'), findsOneWidget);
    expect(tester.widget<FilledButton>(proceedButton).onPressed, isNotNull);

    await tester.tap(proceedButton);
    await tester.pump();

    expect(find.text('Receive balance'), findsOneWidget);
    expect(find.byKey(const Key('personal-qr')), findsOneWidget);
    expect(find.text('+993 71 12 34 56'), findsOneWidget);
  });

  testWidgets('country code remains visible after submitting an empty field', (
    tester,
  ) async {
    await tester.pumpWidget(const QrTolegApp());

    final field = find.byKey(const Key('phone-number-field'));
    await tester.showKeyboard(field);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('phone-country-code')), findsOneWidget);
    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('proceed-button')))
          .onPressed,
      isNull,
    );

    final decoration = tester.widget<TextField>(field).decoration!;
    expect(decoration.prefixText, isNull);
    expect(decoration.prefixIcon, isNotNull);
  });

  testWidgets('fits on a narrow phone without layout exceptions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const QrTolegApp());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.text('Proceed'), findsOneWidget);
  });

  testWidgets('home screen shows a QR containing the personal payload', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(phoneNumber: '99365123456', onOpenSettings: (_) {}),
      ),
    );

    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    final qr = tester.widget<PersonalQr>(find.byType(PersonalQr));
    expect(qr.payload, 'QRTM1:99365123456');
    expect(find.text('+993 65 12 34 56'), findsOneWidget);
    expect(find.text('Scan to send balance'), findsOneWidget);
  });

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
    await tester.tap(find.byKey(const Key('proceed-button')));
    await tester.pump();

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

  testWidgets('settings can reset the saved phone number', (tester) async {
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
