import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.dart';
import 'l10n/turkmen_framework_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/phone_entry_screen.dart';
import 'screens/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  runApp(QrTolegApp(preferences: preferences));
}

class QrTolegApp extends StatefulWidget {
  const QrTolegApp({this.preferences, super.key});

  static const phoneNumberPreferenceKey = 'phone_number';
  static const languagePreferenceKey = 'language';

  final SharedPreferences? preferences;

  @override
  State<QrTolegApp> createState() => _QrTolegAppState();
}

class _QrTolegAppState extends State<QrTolegApp> {
  static const _defaultLanguageCode = 'tk';
  static const _supportedLanguageCodes = {'tk', 'en'};

  String? _phoneNumber;
  late String _languageCode;

  @override
  void initState() {
    super.initState();
    final savedLanguageCode = widget.preferences?.getString(
      QrTolegApp.languagePreferenceKey,
    );
    _languageCode = _supportedLanguageCodes.contains(savedLanguageCode)
        ? savedLanguageCode!
        : _defaultLanguageCode;
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

  Future<void> _resetPhoneNumber() async {
    await widget.preferences?.remove(QrTolegApp.phoneNumberPreferenceKey);
    if (mounted) {
      setState(() => _phoneNumber = null);
    }
  }

  Future<void> _changeLanguage(String languageCode) async {
    if (!_supportedLanguageCodes.contains(languageCode) ||
        languageCode == _languageCode) {
      return;
    }
    setState(() => _languageCode = languageCode);
    await widget.preferences?.setString(
      QrTolegApp.languagePreferenceKey,
      languageCode,
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => SettingsScreen(
          languageCode: _languageCode,
          onLanguageChanged: _changeLanguage,
          onResetPhoneNumber: _resetPhoneNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF16211B);
    const green = Color(0xFF16794A);
    final phoneNumber = _phoneNumber;

    return MaterialApp(
      locale: Locale(_languageCode),
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        TurkmenMaterialLocalizationsDelegate(),
        TurkmenCupertinoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
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
          ? HomeScreen(phoneNumber: phoneNumber, onOpenSettings: _openSettings)
          : PhoneEntryScreen(onProceed: _savePhoneNumber),
    );
  }
}
