import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/main.dart';
import 'package:qrtoleg/screens/home_screen.dart';

void main() {
  testWidgets('asks for an 8-digit TMcell number before showing the QR', (
    tester,
  ) async {
    await tester.pumpWidget(const QrTolegApp());

    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.byKey(const Key('phone-country-code')), findsOneWidget);
    expect(find.byKey(const Key('mock-qr')), findsNothing);

    final proceedButton = find.byKey(const Key('proceed-button'));
    expect(tester.widget<FilledButton>(proceedButton).onPressed, isNull);

    await tester.enterText(
      find.byKey(const Key('phone-number-field')),
      'ab65123456789',
    );
    await tester.pump();

    expect(find.text('65123456'), findsOneWidget);
    expect(tester.widget<FilledButton>(proceedButton).onPressed, isNotNull);

    await tester.tap(proceedButton);
    await tester.pump();

    expect(find.text('Receive balance'), findsOneWidget);
    expect(find.byKey(const Key('mock-qr')), findsOneWidget);
    expect(find.text('+993 65 12 34 56'), findsOneWidget);
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

  testWidgets('home screen still shows the existing mocked QR', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    expect(find.byKey(const Key('mock-qr')), findsOneWidget);
    expect(find.text('+993 65 12 34 56'), findsOneWidget);
    expect(find.text('Scan to send balance'), findsOneWidget);
  });
}
