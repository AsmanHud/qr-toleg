import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../qr_payload.dart';

class PersonalQr extends StatelessWidget {
  const PersonalQr({required this.phoneNumber, required this.size, super.key});

  final String phoneNumber;
  final double size;

  String get payload => encodeQrPayload(phoneNumber);

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      key: const Key('personal-qr'),
      data: payload,
      size: size,
      padding: const EdgeInsets.all(12),
      backgroundColor: Colors.white,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      semanticsLabel: 'Personal QR code',
    );
  }
}
