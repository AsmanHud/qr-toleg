import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/screens/amount_entry_screen.dart';
import 'package:qrtoleg/screens/qr_scanner_screen.dart';

import 'test_app.dart';

void main() {
  testWidgets('shows retry when camera permission is denied', (tester) async {
    final permissions = _FakeCameraPermissionGateway([
      CameraAccess.denied,
      CameraAccess.granted,
    ]);

    await tester.pumpWidget(
      _app(
        permissions,
        scannerBuilder: (_, _) => const ColoredBox(color: Colors.black),
      ),
    );
    await tester.pump();

    expect(find.text('Camera access is needed'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);

    await tester.tap(find.text('Try again'));
    await tester.pump();
    await tester.pump();

    expect(find.byKey(const Key('scan-frame')), findsOneWidget);
    final frameCenter = tester.getCenter(find.byKey(const Key('scan-frame')));
    final screenCenter = tester.getCenter(find.byType(Scaffold));
    expect(frameCenter.dy, lessThan(screenCenter.dy));
    expect(permissions.requestCount, 2);
  });

  testWidgets('opens settings when camera permission is permanently denied', (
    tester,
  ) async {
    final permissions = _FakeCameraPermissionGateway([
      CameraAccess.permanentlyDenied,
    ]);

    await tester.pumpWidget(_app(permissions));
    await tester.pump();

    expect(find.text('Allow camera access in Settings'), findsOneWidget);
    await tester.tap(find.text('Open settings'));
    await tester.pump();

    expect(permissions.openSettingsCount, 1);
  });

  testWidgets('valid scans open amount entry for the recipient', (
    tester,
  ) async {
    final permissions = _FakeCameraPermissionGateway([CameraAccess.granted]);
    ValueChanged<String>? onCode;

    await tester.pumpWidget(
      _app(
        permissions,
        scannerBuilder: (_, callback) {
          onCode = callback;
          return const ColoredBox(color: Colors.black);
        },
      ),
    );
    await tester.pump();

    onCode!('QRTM1:99365123456');
    await tester.pumpAndSettle();

    expect(find.byType(AmountEntryScreen), findsOneWidget);
    expect(find.text('Enter the amount'), findsOneWidget);
    expect(
      find.text('You are sending balance to +993 65 12 34 56.'),
      findsOneWidget,
    );
  });

  testWidgets('invalid scans show feedback and fit on a narrow screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final permissions = _FakeCameraPermissionGateway([CameraAccess.granted]);
    ValueChanged<String>? onCode;
    await tester.pumpWidget(
      _app(
        permissions,
        scannerBuilder: (_, callback) {
          onCode = callback;
          return const ColoredBox(color: Colors.black);
        },
      ),
    );
    await tester.pump();

    onCode!('not-a-qr-toleg-code');
    await tester.pump();

    expect(find.text("This isn't a QR Töleg code."), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Widget _app(
  CameraPermissionGateway permissions, {
  ScannerBuilder? scannerBuilder,
}) {
  return localizedTestApp(
    home: QrScannerScreen(
      permissionGateway: permissions,
      scannerBuilder: scannerBuilder,
    ),
  );
}

class _FakeCameraPermissionGateway implements CameraPermissionGateway {
  _FakeCameraPermissionGateway(this.responses);

  final List<CameraAccess> responses;
  int requestCount = 0;
  int openSettingsCount = 0;

  @override
  Future<CameraAccess> request() async {
    final index = requestCount.clamp(0, responses.length - 1);
    requestCount += 1;
    return responses[index];
  }

  @override
  Future<CameraAccess> check() async => responses.last;

  @override
  Future<bool> openSettings() async {
    openSettingsCount += 1;
    return true;
  }
}
