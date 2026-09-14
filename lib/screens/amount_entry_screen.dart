import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountEntryScreen extends StatefulWidget {
  const AmountEntryScreen({required this.recipientPhoneNumber, super.key});

  final String recipientPhoneNumber;

  @override
  State<AmountEntryScreen> createState() => _AmountEntryScreenState();
}

class _AmountEntryScreenState extends State<AmountEntryScreen> {
  final _amountController = TextEditingController();

  int? get _amount => int.tryParse(_amountController.text);

  bool get _hasInvalidAmount {
    final amount = _amount;
    return _amountController.text.isNotEmpty &&
        (amount == null || amount < 1 || amount > 50);
  }

  String get _formattedRecipient {
    final number = widget.recipientPhoneNumber;
    return '+${number.substring(0, 3)} '
        '${number.substring(3, 5)} '
        '${number.substring(5, 7)} '
        '${number.substring(7, 9)} '
        '${number.substring(9, 11)}';
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: const Text('Send balance'),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth < 380 ? 16.0 : 24.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                36,
                horizontalPadding,
                28,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.payments_outlined,
                          color: colors.onPrimaryContainer,
                          size: 27,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Enter the amount',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'You are sending balance to $_formattedRecipient.',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Amount',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        key: const Key('amount-field'),
                        controller: _amountController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                        ),
                        decoration: InputDecoration(
                          hintText: '0',
                          suffixText: 'TMT',
                          errorText: _hasInvalidAmount
                              ? 'Enter an amount from 1 to 50 TMT.'
                              : null,
                          filled: true,
                          fillColor: colors.surface,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 19,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              color: Color(0xFFDDE1DA),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              color: Color(0xFFDDE1DA),
                            ),
                          ),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Enter a whole-number amount from 1 to 50 TMT.',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: colors.onSurfaceVariant),
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
