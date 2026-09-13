import 'package:flutter/material.dart';

class MockQr extends StatelessWidget {
  const MockQr({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Placeholder personal QR code',
      image: true,
      child: Container(
        key: const Key('mock-qr'),
        width: size,
        height: size,
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: const CustomPaint(painter: _MockQrPainter()),
      ),
    );
  }
}

class _MockQrPainter extends CustomPainter {
  const _MockQrPainter();

  static const _size = 21;

  bool _insideFinder(int row, int column, int top, int left) =>
      row >= top && row < top + 7 && column >= left && column < left + 7;

  bool _finderPixel(int row, int column, int top, int left) {
    final localRow = row - top;
    final localColumn = column - left;
    return localRow == 0 ||
        localRow == 6 ||
        localColumn == 0 ||
        localColumn == 6 ||
        (localRow >= 2 &&
            localRow <= 4 &&
            localColumn >= 2 &&
            localColumn <= 4);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.shortestSide / _size;
    final paint = Paint()..color = const Color(0xFF16211B);

    for (var row = 0; row < _size; row++) {
      for (var column = 0; column < _size; column++) {
        final inTopLeft = _insideFinder(row, column, 0, 0);
        final inTopRight = _insideFinder(row, column, 0, 14);
        final inBottomLeft = _insideFinder(row, column, 14, 0);
        final isFinder = inTopLeft || inTopRight || inBottomLeft;
        final isFilled = isFinder
            ? _finderPixel(
                row,
                column,
                inTopRight ? 0 : (inBottomLeft ? 14 : 0),
                inTopRight ? 14 : 0,
              )
            : ((row * 11 + column * 7 + row * column) % 9 < 4 &&
                  !_insideFinder(row, column, 13, 13));

        if (isFilled) {
          canvas.drawRect(
            Rect.fromLTWH(column * cell, row * cell, cell + 0.2, cell + 0.2),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
