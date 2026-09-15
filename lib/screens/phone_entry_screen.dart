import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneEntryScreen extends StatefulWidget {
  const PhoneEntryScreen({required this.onProceed, super.key});

  final ValueChanged<String> onProceed;

  @override
  State<PhoneEntryScreen> createState() => _PhoneEntryScreenState();
}

class _PhoneEntryScreenState extends State<PhoneEntryScreen> {
  final _phoneController = TextEditingController();

  bool get _isComplete => _phoneController.text.length == 8;

  String get _phoneNumber => '993${_phoneController.text}';

  String get _formattedPhoneNumber {
    final number = _phoneNumber;
    return '+${number.substring(0, 3)} '
        '${number.substring(3, 5)} '
        '${number.substring(5, 7)} '
        '${number.substring(7, 9)} '
        '${number.substring(9, 11)}';
  }

  Future<void> _proceed() async {
    if (!_isComplete) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Is this your number?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formattedPhoneNumber,
              key: const Key('phone-number-confirmation-value'),
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            const Text(
              'Please check carefully. Money sent using your QR code will go to this phone number.',
            ),
          ],
        ),
        actions: [
          TextButton(
            key: const Key('edit-phone-number'),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Edit'),
          ),
          FilledButton(
            key: const Key('confirm-phone-number'),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes, this is my number'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      widget.onProceed(_phoneNumber);
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 20,
        title: const Text(
          'QR Töleg',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
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
                          Icons.phone_iphone_rounded,
                          color: colors.onPrimaryContainer,
                          size: 27,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Enter your phone number',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'We use your TMcell number to create your personal QR code.',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'TMcell number',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        key: const Key('phone-number-field'),
                        controller: _phoneController,
                        autofocus: true,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [
                          AutofillHints.telephoneNumberNational,
                        ],
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8),
                        ],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 18, right: 8),
                            child: Text(
                              '+993',
                              key: const Key('phone-country-code'),
                              style: TextStyle(
                                color: colors.onSurface,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                          ),
                          hintText: '65 12 34 56',
                          counterText: '',
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
                        onSubmitted: (_) {
                          if (_isComplete) _proceed();
                        },
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Enter the 8 digits after +993.',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: colors.onSurfaceVariant),
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
                              'Not sure of your number? Dial *222# on your phone to check it.',
                              key: const Key('phone-number-hint'),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      FilledButton(
                        key: const Key('proceed-button'),
                        onPressed: _isComplete ? _proceed : null,
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
                        child: const Text('Proceed'),
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
