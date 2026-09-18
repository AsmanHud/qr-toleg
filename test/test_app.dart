import 'package:flutter/material.dart';
import 'package:qrtoleg/l10n/app_localizations.dart';

final enL10n = lookupAppLocalizations(const Locale('en'));
final tkL10n = lookupAppLocalizations(const Locale('tk'));
final ruL10n = lookupAppLocalizations(const Locale('ru'));

Widget localizedTestApp({required Widget home}) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}
