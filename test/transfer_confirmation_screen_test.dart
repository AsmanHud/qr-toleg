import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/screens/transfer_confirmation_screen.dart';

import 'test_app.dart';

void main() {
  Widget buildScreen({int amount = 25, MessageLauncher? launchMessage}) {
    return localizedTestApp(
      home: TransferConfirmationScreen(
        recipientPhoneNumber: '99365123456',
        amount: amount,
        launchMessage: launchMessage ?? (_) async => true,
      ),
    );
  }

  testWidgets('shows the complete transfer and SMS details', (tester) async {
    await tester.pumpWidget(buildScreen());

    expect(find.text('Review the details'), findsOneWidget);
    expect(find.text('+993 65 12 34 56'), findsOneWidget);
    expect(find.text('25 TMT'), findsOneWidget);
    expect(find.text('0.10 TMT'), findsOneWidget);
    expect(find.text('25.10 TMT'), findsOneWidget);
    expect(
      find.text(
        'You can dial *0800# to check if you have enough balance for this '
        'transfer.',
      ),
      findsOneWidget,
    );
    expect(find.text('SMS to 0804'), findsOneWidget);
    expect(find.text('99365123456 25'), findsOneWidget);
  });

  testWidgets('calculates the total at the maximum transfer amount', (
    tester,
  ) async {
    await tester.pumpWidget(buildScreen(amount: 50));

    expect(find.text('50 TMT'), findsOneWidget);
    expect(find.text('50.10 TMT'), findsOneWidget);
    expect(find.text('99365123456 50'), findsOneWidget);
  });

  testWidgets('Open Messages launches a prefilled SMS to TMcell', (
    tester,
  ) async {
    Uri? launchedUri;
    await tester.pumpWidget(
      buildScreen(
        launchMessage: (uri) async {
          launchedUri = uri;
          return true;
        },
      ),
    );

    final button = find.byKey(const Key('open-messages-button'));
    expect(tester.widget<FilledButton>(button).onPressed, isNotNull);

    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    expect(launchedUri?.scheme, 'sms');
    expect(launchedUri?.path, '0804');
    expect(launchedUri?.queryParameters['body'], '99365123456 25');
    expect(launchedUri.toString(), 'sms:0804?body=99365123456%2025');
  });

  testWidgets('shows an error when Messages cannot be opened', (tester) async {
    await tester.pumpWidget(buildScreen(launchMessage: (_) async => false));

    final button = find.byKey(const Key('open-messages-button'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    expect(find.text('Could not open Messages.'), findsOneWidget);
  });

  testWidgets('fits on a narrow phone without layout exceptions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildScreen());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('sms-preview')), findsOneWidget);
    expect(find.byKey(const Key('open-messages-button')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
