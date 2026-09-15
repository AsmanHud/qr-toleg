import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';

typedef MessageLauncher = Future<bool> Function(Uri uri);

class TransferConfirmationScreen extends StatelessWidget {
  const TransferConfirmationScreen({
    required this.recipientPhoneNumber,
    required this.amount,
    this.launchMessage = _launchMessage,
    super.key,
  });

  static const carrierFee = 0.10;

  final String recipientPhoneNumber;
  final int amount;
  final MessageLauncher launchMessage;

  static Future<bool> _launchMessage(Uri uri) =>
      launchUrl(uri, mode: LaunchMode.externalApplication);

  Future<void> _openMessages(BuildContext context) async {
    final body = Uri.encodeComponent('$recipientPhoneNumber $amount');
    final uri = Uri.parse('sms:0804?body=$body');

    final launched = await launchMessage(uri);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).couldNotOpenMessages),
        ),
      );
    }
  }

  String get _formattedRecipient {
    final number = recipientPhoneNumber;
    return '+${number.substring(0, 3)} '
        '${number.substring(3, 5)} '
        '${number.substring(5, 7)} '
        '${number.substring(7, 9)} '
        '${number.substring(9, 11)}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final total = (amount + carrierFee).toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.confirmTransferTitle),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth < 380 ? 16.0 : 24.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                28,
                horizontalPadding,
                28,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.reviewDetailsTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 24),
                      _DetailRow(
                        label: l10n.recipientLabel,
                        value: _formattedRecipient,
                      ),
                      const Divider(height: 32),
                      _DetailRow(label: l10n.amountLabel, value: '$amount TMT'),
                      const SizedBox(height: 14),
                      _DetailRow(
                        label: l10n.carrierFeeLabel,
                        value: '0.10 TMT',
                      ),
                      const Divider(height: 32),
                      _DetailRow(
                        label: l10n.totalRequiredBalanceLabel,
                        value: '$total TMT',
                        emphasized: true,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 20,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l10n.balanceCheckHint,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        l10n.smsDestinationLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        key: const Key('sms-preview'),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          border: Border.all(color: const Color(0xFFDDE1DA)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '$recipientPhoneNumber $amount',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      FilledButton.icon(
                        key: const Key('open-messages-button'),
                        onPressed: () => _openMessages(context),
                        icon: const Icon(Icons.message_outlined),
                        label: Text(l10n.openMessagesAction),
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final style = emphasized
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.bodyMedium;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label, style: style)),
        const SizedBox(width: 16),
        Text(value, textAlign: TextAlign.end, style: style),
      ],
    );
  }
}
