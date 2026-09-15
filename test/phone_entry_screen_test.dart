import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/main.dart';

import 'test_app.dart';

void main() {
  testWidgets('asks for an 8-digit TMcell number before showing the QR', (
    tester,
  ) async {
    await tester.pumpWidget(const QrTolegApp());

    expect(find.text(tkL10n.enterPhoneNumberTitle), findsOneWidget);
    expect(find.byKey(const Key('phone-country-code')), findsOneWidget);
    expect(find.byKey(const Key('phone-number-hint')), findsOneWidget);
    expect(find.textContaining('*222#'), findsOneWidget);
    expect(find.text(tkL10n.tmcellAffiliationDisclaimer), findsOneWidget);
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

    await tester.ensureVisible(proceedButton);
    await tester.tap(proceedButton);
    await tester.pumpAndSettle();

    expect(find.text(tkL10n.confirmPhoneNumberTitle), findsOneWidget);
    expect(find.text('+993 71 12 34 56'), findsOneWidget);
    expect(find.byKey(const Key('personal-qr')), findsNothing);

    await tester.tap(find.byKey(const Key('confirm-phone-number')));
    await tester.pumpAndSettle();

    expect(find.text(tkL10n.receiveBalanceTitle), findsOneWidget);
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
    expect(find.text(tkL10n.enterPhoneNumberTitle), findsOneWidget);
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
    expect(find.text(tkL10n.enterPhoneNumberTitle), findsOneWidget);
    expect(find.text(tkL10n.proceedAction), findsOneWidget);
  });

  testWidgets('allows editing a number instead of confirming it', (
    tester,
  ) async {
    await tester.pumpWidget(const QrTolegApp());
    final field = find.byKey(const Key('phone-number-field'));

    await tester.enterText(field, '65123456');
    await tester.pump();
    final proceedButton = find.byKey(const Key('proceed-button'));
    await tester.ensureVisible(proceedButton);
    await tester.tap(proceedButton);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('edit-phone-number')));
    await tester.pumpAndSettle();

    expect(find.text(tkL10n.confirmPhoneNumberTitle), findsNothing);
    expect(find.text('65123456'), findsOneWidget);
    expect(find.byKey(const Key('personal-qr')), findsNothing);
  });
}
