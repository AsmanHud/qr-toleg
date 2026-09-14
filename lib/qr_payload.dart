const _qrPayloadPrefix = 'QRTM1:';
final _phoneNumberPattern = RegExp(r'^993\d{8}$');

String encodeQrPayload(String phoneNumber) {
  if (!_phoneNumberPattern.hasMatch(phoneNumber)) {
    throw ArgumentError.value(
      phoneNumber,
      'phoneNumber',
      'must be 11 digits beginning with 993',
    );
  }

  return '$_qrPayloadPrefix$phoneNumber';
}

String? decodeQrPayload(String payload) {
  if (!payload.startsWith(_qrPayloadPrefix)) {
    return null;
  }

  final phoneNumber = payload.substring(_qrPayloadPrefix.length);
  return _phoneNumberPattern.hasMatch(phoneNumber) ? phoneNumber : null;
}
