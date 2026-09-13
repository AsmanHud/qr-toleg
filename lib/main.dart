import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/phone_entry_screen.dart';

void main() => runApp(const QrTolegApp());

class QrTolegApp extends StatefulWidget {
  const QrTolegApp({super.key});

  @override
  State<QrTolegApp> createState() => _QrTolegAppState();
}

class _QrTolegAppState extends State<QrTolegApp> {
  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF16211B);
    const green = Color(0xFF16794A);
    final phoneNumber = _phoneNumber;

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
      home: phoneNumber != null
          ? HomeScreen(phoneNumber: phoneNumber)
          : PhoneEntryScreen(
              onProceed: (phoneNumber) {
                setState(() => _phoneNumber = phoneNumber);
              },
            ),
    );
  }
}
