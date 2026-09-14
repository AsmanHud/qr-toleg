import 'package:flutter_test/flutter_test.dart';
import 'package:qrtoleg/qr_payload.dart';

void main() {
  group('encodeQrPayload', () {
    test('creates the versioned payload for a valid phone number', () {
      expect(encodeQrPayload('99365123456'), 'QRTM1:99365123456');
    });

    test('rejects an invalid phone number', () {
      expect(() => encodeQrPayload('65123456'), throwsA(isA<ArgumentError>()));
    });
  });

  group('decodeQrPayload', () {
    test('extracts a phone number from a valid payload', () {
      expect(decodeQrPayload('QRTM1:99365123456'), '99365123456');
    });

    test('rejects other QR contents and malformed phone numbers', () {
      expect(decodeQrPayload('https://example.com'), isNull);
      expect(decodeQrPayload('QRTM1:65123456'), isNull);
      expect(decodeQrPayload('QRTM1:99365123456extra'), isNull);
    });
  });
}
