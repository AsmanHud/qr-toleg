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
}
