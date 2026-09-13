import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'screens/phone_entry_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  runApp(QrTolegApp(preferences: preferences));
}

class QrTolegApp extends StatefulWidget {
  const QrTolegApp({this.preferences, super.key});

  static const phoneNumberPreferenceKey = 'phone_number';

  final SharedPreferences? preferences;

  @override
  State<QrTolegApp> createState() => _QrTolegAppState();
}

class _QrTolegAppState extends State<QrTolegApp> {
  String? _phoneNumber;

  @override
  void initState() {
    super.initState();
    final savedPhoneNumber = widget.preferences?.getString(
      QrTolegApp.phoneNumberPreferenceKey,
    );
    if (savedPhoneNumber != null &&
        RegExp(r'^993\d{8}$').hasMatch(savedPhoneNumber)) {
      _phoneNumber = savedPhoneNumber;
    }
  }

  void _savePhoneNumber(String phoneNumber) {
    setState(() => _phoneNumber = phoneNumber);
    widget.preferences?.setString(
      QrTolegApp.phoneNumberPreferenceKey,
      phoneNumber,
    );
  }

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
          : PhoneEntryScreen(onProceed: _savePhoneNumber),
    );
  }
}
