import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../l10n/app_localizations.dart';
import '../qr_payload.dart';
import 'amount_entry_screen.dart';

const _debugRecipientPhoneNumber = '99365123456';

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
  bool _isOpeningAmountEntry = false;
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
    final invalidQrCodeMessage = AppLocalizations.of(context)
        .invalidQrCodeMessage;
    final recipientPhoneNumber = decodeQrPayload(rawValue);
    if (recipientPhoneNumber != null) {
      if (_isOpeningAmountEntry) return;
      _isOpeningAmountEntry = true;
      Navigator.of(context)
          .push(
            MaterialPageRoute<void>(
              builder: (context) =>
                  AmountEntryScreen(recipientPhoneNumber: recipientPhoneNumber),
            ),
          )
          .whenComplete(() => _isOpeningAmountEntry = false);
      return;
    }
    if (_message == invalidQrCodeMessage) {
      return;
    }
    setState(() => _message = invalidQrCodeMessage);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.scanQrCodeTitle),
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
            title: l10n.cameraAccessNeededTitle,
            body: l10n.cameraAccessNeededBody,
            actionLabel: l10n.tryAgainAction,
            onAction: _requestPermission,
            debugAction: kDebugMode ? _buildDebugBypassButton() : null,
          ),
          CameraAccess.permanentlyDenied => _PermissionMessage(
            icon: Icons.settings_outlined,
            title: l10n.allowCameraInSettingsTitle,
            body: l10n.cameraAccessDisabledBody,
            actionLabel: l10n.openSettingsAction,
            onAction: _openSettings,
            debugAction: kDebugMode ? _buildDebugBypassButton() : null,
          ),
          CameraAccess.unavailable => _PermissionMessage(
            icon: Icons.no_photography_outlined,
            title: l10n.cameraUnavailableTitle,
            body: l10n.cameraUnavailableDeviceBody,
            debugAction: kDebugMode ? _buildDebugBypassButton() : null,
          ),
        },
      ),
    );
  }

  Widget _buildDebugBypassButton() {
    return OutlinedButton.icon(
      key: const Key('debug-skip-scanner'),
      onPressed: () => _handleCode(encodeQrPayload(_debugRecipientPhoneNumber)),
      icon: const Icon(Icons.developer_mode_outlined),
      label: const Text('Debug: use mock recipient'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white70),
      ),
    );
  }

  Widget _buildScanner() {
    final l10n = AppLocalizations.of(context);
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
          errorBuilder: (context, error) => _PermissionMessage(
            icon: Icons.no_photography_outlined,
            title: l10n.cameraUnavailableTitle,
            body: l10n.cameraCouldNotStartBody,
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
              child: Align(
                alignment: const Alignment(0, -0.30),
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
                    _message ?? l10n.placeQrInFrame,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (kDebugMode) ...[
                    const SizedBox(height: 16),
                    _buildDebugBypassButton(),
                  ],
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
                              ? l10n.turnOffFlashlightTooltip
                              : l10n.turnOnFlashlightTooltip,
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
    this.debugAction,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? debugAction;

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
              if (debugAction != null) ...[
                const SizedBox(height: 12),
                debugAction!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
