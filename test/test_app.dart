import 'package:flutter/material.dart';
import 'package:qrtoleg/l10n/app_localizations.dart';

Widget localizedTestApp({required Widget home}) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}
