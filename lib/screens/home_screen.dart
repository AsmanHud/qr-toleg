import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../l10n/app_localizations.dart';
import '../qr_payload.dart';
import 'qr_scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.phoneNumber,
    required this.onOpenSettings,
    super.key,
  });

  final String phoneNumber;
  final ValueChanged<BuildContext> onOpenSettings;

  String get _formattedPhoneNumber =>
      '+${phoneNumber.substring(0, 3)} '
      '${phoneNumber.substring(3, 5)} '
      '${phoneNumber.substring(5, 7)} '
      '${phoneNumber.substring(7, 9)} '
      '${phoneNumber.substring(9, 11)}';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 20,
        title: Text(
          l10n.appTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () => onOpenSettings(context),
            tooltip: l10n.settingsTooltip,
            icon: const Icon(Icons.settings_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth < 380 ? 16.0 : 24.0;
            final qrSize = (constraints.maxWidth - horizontalPadding * 2 - 64)
                .clamp(190.0, 260.0);

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                20,
                horizontalPadding,
                28,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.receiveBalanceTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.receiveBalanceDescription,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFDDE1DA)),
                        ),
                        child: Column(
                          children: [
                            QrImageView(
                              key: const Key('personal-qr'),
                              data: encodeQrPayload(phoneNumber),
                              size: qrSize,
                              padding: const EdgeInsets.all(12),
                              backgroundColor: Colors.white,
                              errorCorrectionLevel: QrErrorCorrectLevel.M,
                              semanticsLabel: l10n.personalQrCodeSemantics,
                            ),
                            const SizedBox(height: 22),
                            Text(
                              _formattedPhoneNumber,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              l10n.yourTmcellNumber,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => const QrScannerScreen(),
                          ),
                        ),
                        icon: const Icon(Icons.qr_code_scanner_rounded),
                        label: Text(l10n.scanToSendBalance),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
