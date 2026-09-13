import 'package:flutter/material.dart';

void main() => runApp(const QrTolegApp());

class QrTolegApp extends StatelessWidget {
  const QrTolegApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF16211B);
    const green = Color(0xFF16794A);

    return MaterialApp(
      title: 'QR Töleg',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F5F0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          primary: green,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: ink,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
          titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 15, height: 1.45),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _phoneNumber = '+993 65 12 34 56';

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
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Settings',
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
                        'Receive balance',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Show this code to the person sending you balance.',
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
                            Semantics(
                              label: 'Placeholder personal QR code',
                              image: true,
                              child: Container(
                                key: const Key('mock-qr'),
                                width: qrSize,
                                height: qrSize,
                                padding: const EdgeInsets.all(12),
                                color: Colors.white,
                                child: const CustomPaint(
                                  painter: _MockQrPainter(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              _phoneNumber,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Your TMcell number',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.qr_code_scanner_rounded),
                        label: const Text('Scan to send balance'),
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
