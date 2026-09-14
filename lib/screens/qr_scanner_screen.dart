import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../qr_payload.dart';

enum CameraAccess { checking, granted, denied, permanentlyDenied, unavailable }

abstract interface class CameraPermissionGateway {
  Future<CameraAccess> request();

  Future<CameraAccess> check();

  Future<bool> openSettings();
}

class SystemCameraPermissionGateway implements CameraPermissionGateway {
  const SystemCameraPermissionGateway();

  CameraAccess _map(PermissionStatus status) {
    if (status.isGranted || status.isLimited) return CameraAccess.granted;
    if (status.isPermanentlyDenied) return CameraAccess.permanentlyDenied;
    if (status.isRestricted) return CameraAccess.unavailable;
    return CameraAccess.denied;
  }

  @override
  Future<CameraAccess> request() async =>
      _map(await Permission.camera.request());

  @override
  Future<CameraAccess> check() async => _map(await Permission.camera.status);

  @override
  Future<bool> openSettings() => openAppSettings();
}

typedef ScannerBuilder = Widget Function(
  BuildContext context,
  ValueChanged<String> onCode,
);

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({
    this.permissionGateway = const SystemCameraPermissionGateway(),
    this.scannerBuilder,
    super.key,
  });

  final CameraPermissionGateway permissionGateway;
  final ScannerBuilder? scannerBuilder;

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen>
    with WidgetsBindingObserver {
  late final MobileScannerController _controller;
  CameraAccess _access = CameraAccess.checking;
  bool _openingSettings = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      formats: const [BarcodeFormat.qrCode],
    );
    WidgetsBinding.instance.addObserver(this);
    _requestPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _openingSettings) {
      _openingSettings = false;
      _checkPermission();
    }
  }

  Future<void> _requestPermission() async {
    setState(() => _access = CameraAccess.checking);
    final access = await widget.permissionGateway.request();
    if (!mounted) return;
    setState(() => _access = access);
  }

  Future<void> _checkPermission() async {
    final access = await widget.permissionGateway.check();
    if (!mounted) return;
    setState(() => _access = access);
  }

  Future<void> _openSettings() async {
    _openingSettings = true;
    final opened = await widget.permissionGateway.openSettings();
    if (!opened) _openingSettings = false;
  }

  void _handleCode(String rawValue) {
    if (decodeQrPayload(rawValue) != null ||
        _message == "This isn't a QR Töleg code.") {
      return;
    }
    setState(() => _message = "This isn't a QR Töleg code.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text('Scan QR code'),
      ),
      body: SafeArea(
        top: false,
        child: switch (_access) {
          CameraAccess.checking => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
          CameraAccess.granted => _buildScanner(),
          CameraAccess.denied => _PermissionMessage(
            icon: Icons.no_photography_outlined,
            title: 'Camera access is needed',
            body: 'Allow camera access to scan a QR Töleg code.',
            actionLabel: 'Try again',
            onAction: _requestPermission,
          ),
          CameraAccess.permanentlyDenied => _PermissionMessage(
            icon: Icons.settings_outlined,
            title: 'Allow camera access in Settings',
            body: 'Camera access is turned off for QR Töleg.',
            actionLabel: 'Open settings',
            onAction: _openSettings,
          ),
          CameraAccess.unavailable => const _PermissionMessage(
            icon: Icons.no_photography_outlined,
            title: 'Camera unavailable',
            body: 'The camera cannot be used on this device.',
          ),
        },
      ),
    );
  }

  Widget _buildScanner() {
    final scanner =
        widget.scannerBuilder?.call(context, _handleCode) ??
        MobileScanner(
          controller: _controller,
          onDetect: (capture) {
            for (final barcode in capture.barcodes) {
              final value = barcode.rawValue;
              if (value != null) {
                _handleCode(value);
                break;
              }
            }
          },
          errorBuilder: (context, error) => const _PermissionMessage(
            icon: Icons.no_photography_outlined,
            title: 'Camera unavailable',
            body: 'The camera could not be started.',
          ),
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        final scanSize = constraints.biggest.shortestSide.clamp(220.0, 340.0);
        return Stack(
          fit: StackFit.expand,
          children: [
            scanner,
            IgnorePointer(
              child: Center(
                child: Container(
                  key: const Key('scan-frame'),
                  width: scanSize,
                  height: scanSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 28,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _message ?? 'Place the QR code inside the frame',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (widget.scannerBuilder == null) ...[
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, state, child) {
                        if (state.torchState == TorchState.unavailable) {
                          return const SizedBox.shrink();
                        }
                        final isOn = state.torchState == TorchState.on;
                        return IconButton.filledTonal(
                          onPressed: _controller.toggleTorch,
                          tooltip: isOn
                              ? 'Turn off flashlight'
                              : 'Turn on flashlight',
                          icon: Icon(
                            isOn
                                ? Icons.flash_off_rounded
                                : Icons.flash_on_rounded,
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PermissionMessage extends StatelessWidget {
  const _PermissionMessage({
    required this.icon,
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                body,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 15),
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 24),
                FilledButton(onPressed: onAction, child: Text(actionLabel!)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
