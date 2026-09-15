import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/screens/amount_entry_screen.dart';
import 'package:qrtoleg/screens/qr_scanner_screen.dart';

import 'test_app.dart';

void main() {
  testWidgets('debug shortcut works when camera permission is denied', (
    tester,
  ) async {
    await tester.pumpWidget(
      localizedTestApp(
        home: const QrScannerScreen(
          permissionGateway: _DeniedCameraPermissionGateway(),
        ),
      ),
    );
    await tester.pump();

    final shortcut = find.byKey(const Key('debug-skip-scanner'));
    expect(shortcut, findsOneWidget);

    await tester.tap(shortcut);
    await tester.pumpAndSettle();

    expect(find.byType(AmountEntryScreen), findsOneWidget);
    expect(
      find.text(enL10n.sendingBalanceTo('+993 65 12 34 56')),
      findsOneWidget,
    );
  });
}

class _DeniedCameraPermissionGateway implements CameraPermissionGateway {
  const _DeniedCameraPermissionGateway();

  @override
  Future<CameraAccess> request() async => CameraAccess.denied;

  @override
  Future<CameraAccess> check() async => CameraAccess.denied;

  @override
  Future<bool> openSettings() async => false;
}
