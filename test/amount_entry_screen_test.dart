import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/screens/amount_entry_screen.dart';
import 'package:qrtoleg/screens/transfer_confirmation_screen.dart';

void main() {
  testWidgets('shows the recipient and validates the transfer range', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AmountEntryScreen(recipientPhoneNumber: '99365123456'),
      ),
    );

    expect(find.text('Enter the amount'), findsOneWidget);
    expect(
      find.text('You are sending balance to +993 65 12 34 56.'),
      findsOneWidget,
    );

    final field = find.byKey(const Key('amount-field'));
    await tester.enterText(field, '51');
    await tester.pump();
    expect(find.text('Enter an amount from 1 to 50 TMT.'), findsOneWidget);

    await tester.enterText(field, '50');
    await tester.pump();
    expect(find.text('Enter an amount from 1 to 50 TMT.'), findsNothing);
  });

  testWidgets('fits on a narrow phone without layout exceptions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: AmountEntryScreen(recipientPhoneNumber: '99365123456'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('amount-field')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('valid amount proceeds to transfer confirmation', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AmountEntryScreen(recipientPhoneNumber: '99365123456'),
      ),
    );

    final proceedButton = find.byKey(const Key('amount-proceed-button'));
    expect(tester.widget<FilledButton>(proceedButton).onPressed, isNull);

    await tester.enterText(find.byKey(const Key('amount-field')), '25');
    await tester.pump();
    expect(tester.widget<FilledButton>(proceedButton).onPressed, isNotNull);

    await tester.tap(proceedButton);
    await tester.pumpAndSettle();

    expect(find.byType(TransferConfirmationScreen), findsOneWidget);
    final confirmation = tester.widget<TransferConfirmationScreen>(
      find.byType(TransferConfirmationScreen),
    );
    expect(confirmation.recipientPhoneNumber, '99365123456');
    expect(confirmation.amount, 25);
  });
}
