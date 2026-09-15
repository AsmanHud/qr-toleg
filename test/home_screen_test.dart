import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrtoleg/screens/home_screen.dart';

import 'test_app.dart';

void main() {
  testWidgets('shows the personal QR and phone number', (tester) async {
    await tester.pumpWidget(
      localizedTestApp(
        home: HomeScreen(phoneNumber: '99365123456', onOpenSettings: (_) {}),
      ),
    );

    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    expect(find.byKey(const Key('personal-qr')), findsOneWidget);
    expect(find.byType(QrImageView), findsOneWidget);
    expect(find.byType(CustomPaint), findsWidgets);
    expect(
      find.bySemanticsLabel(enL10n.personalQrCodeSemantics),
      findsOneWidget,
    );
    expect(find.text('+993 65 12 34 56'), findsOneWidget);
    expect(find.text(enL10n.scanToSendBalance), findsOneWidget);
  });
}
