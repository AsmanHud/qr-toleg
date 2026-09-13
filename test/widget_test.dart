import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/main.dart';

void main() {
  testWidgets('shows the personal QR and transfer actions', (tester) async {
    await tester.pumpWidget(const QrTolegApp());

    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    expect(find.text('Receive balance'), findsOneWidget);
    expect(find.byKey(const Key('mock-qr')), findsOneWidget);
    expect(find.text('+993 65 12 34 56'), findsOneWidget);
    expect(find.text('Scan to send balance'), findsOneWidget);
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
    expect(find.text('Scan to send balance'), findsOneWidget);
  });
}
