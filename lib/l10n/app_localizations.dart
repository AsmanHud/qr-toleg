import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tk'),
  ];

  /// The application name. Töleg means payment.
  ///
  /// In en, this message translates to:
  /// **'QR Töleg'**
  String get appTitle;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @receiveBalanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Receive balance'**
  String get receiveBalanceTitle;

  /// No description provided for @receiveBalanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Show this code to the person sending you balance.'**
  String get receiveBalanceDescription;

  /// No description provided for @personalQrCodeSemantics.
  ///
  /// In en, this message translates to:
  /// **'Personal QR code'**
  String get personalQrCodeSemantics;

  /// No description provided for @yourTmcellNumber.
  ///
  /// In en, this message translates to:
  /// **'Your TMcell number'**
  String get yourTmcellNumber;

  /// No description provided for @scanToSendBalance.
  ///
  /// In en, this message translates to:
  /// **'Scan to send balance'**
  String get scanToSendBalance;

  /// No description provided for @confirmPhoneNumberTitle.
  ///
  /// In en, this message translates to:
  /// **'Is this your number?'**
  String get confirmPhoneNumberTitle;

  /// No description provided for @confirmPhoneNumberWarning.
  ///
  /// In en, this message translates to:
  /// **'Please check carefully. Money sent using your QR code will go to this phone number.'**
  String get confirmPhoneNumberWarning;

  /// No description provided for @editAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editAction;

  /// No description provided for @confirmPhoneNumberAction.
  ///
  /// In en, this message translates to:
  /// **'Yes, this is my number'**
  String get confirmPhoneNumberAction;

  /// No description provided for @enterPhoneNumberTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumberTitle;

  /// No description provided for @enterPhoneNumberDescription.
  ///
  /// In en, this message translates to:
  /// **'We use your TMcell number to create your personal QR code.'**
  String get enterPhoneNumberDescription;

  /// No description provided for @tmcellNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'TMcell number'**
  String get tmcellNumberLabel;

  /// No description provided for @phoneNumberHelper.
  ///
  /// In en, this message translates to:
  /// **'Enter the 8 digits after +993.'**
  String get phoneNumberHelper;

  /// No description provided for @phoneNumberCheckHint.
  ///
  /// In en, this message translates to:
  /// **'Not sure of your number? Dial *222# on your phone to check it.'**
  String get phoneNumberCheckHint;

  /// No description provided for @proceedAction.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceedAction;

  /// No description provided for @tmcellAffiliationDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This is not an official TMcell app and is not affiliated with TMcell. The phone number you enter is stored only on your phone. The app does not store it outside your phone or send it anywhere.'**
  String get tmcellAffiliationDisclaimer;

  /// No description provided for @sendBalanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Send balance'**
  String get sendBalanceTitle;

  /// No description provided for @enterAmountTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount'**
  String get enterAmountTitle;

  /// Explains which phone number will receive the balance.
  ///
  /// In en, this message translates to:
  /// **'You are sending balance to {recipient}.'**
  String sendingBalanceTo(String recipient);

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @invalidAmountError.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount from 1 to 50 TMT.'**
  String get invalidAmountError;

  /// No description provided for @amountHelper.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole-number amount from 1 to 50 TMT.'**
  String get amountHelper;

  /// No description provided for @couldNotOpenMessages.
  ///
  /// In en, this message translates to:
  /// **'Could not open Messages.'**
  String get couldNotOpenMessages;

  /// No description provided for @confirmTransferTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm transfer'**
  String get confirmTransferTitle;

  /// No description provided for @reviewDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Review the details'**
  String get reviewDetailsTitle;

  /// No description provided for @recipientLabel.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get recipientLabel;

  /// No description provided for @carrierFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Carrier fee'**
  String get carrierFeeLabel;

  /// No description provided for @totalRequiredBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Total required balance'**
  String get totalRequiredBalanceLabel;

  /// No description provided for @balanceCheckHint.
  ///
  /// In en, this message translates to:
  /// **'You can dial *0800# to check if you have enough balance for this transfer.'**
  String get balanceCheckHint;

  /// No description provided for @smsDestinationLabel.
  ///
  /// In en, this message translates to:
  /// **'SMS to 0804'**
  String get smsDestinationLabel;

  /// No description provided for @openMessagesAction.
  ///
  /// In en, this message translates to:
  /// **'Open Messages'**
  String get openMessagesAction;

  /// No description provided for @scanQrCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get scanQrCodeTitle;

  /// No description provided for @invalidQrCodeMessage.
  ///
  /// In en, this message translates to:
  /// **'This isn\'t a QR Töleg code.'**
  String get invalidQrCodeMessage;

  /// No description provided for @cameraAccessNeededTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera access is needed'**
  String get cameraAccessNeededTitle;

  /// No description provided for @cameraAccessNeededBody.
  ///
  /// In en, this message translates to:
  /// **'Allow camera access to scan a QR Töleg code.'**
  String get cameraAccessNeededBody;

  /// No description provided for @tryAgainAction.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgainAction;

  /// No description provided for @allowCameraInSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow camera access in Settings'**
  String get allowCameraInSettingsTitle;

  /// No description provided for @cameraAccessDisabledBody.
  ///
  /// In en, this message translates to:
  /// **'Camera access is turned off for QR Töleg.'**
  String get cameraAccessDisabledBody;

  /// No description provided for @openSettingsAction.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettingsAction;

  /// No description provided for @cameraUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera unavailable'**
  String get cameraUnavailableTitle;

  /// No description provided for @cameraUnavailableDeviceBody.
  ///
  /// In en, this message translates to:
  /// **'The camera cannot be used on this device.'**
  String get cameraUnavailableDeviceBody;

  /// No description provided for @cameraCouldNotStartBody.
  ///
  /// In en, this message translates to:
  /// **'The camera could not be started.'**
  String get cameraCouldNotStartBody;

  /// No description provided for @placeQrInFrame.
  ///
  /// In en, this message translates to:
  /// **'Place the QR code inside the frame'**
  String get placeQrInFrame;

  /// No description provided for @turnOffFlashlightTooltip.
  ///
  /// In en, this message translates to:
  /// **'Turn off flashlight'**
  String get turnOffFlashlightTooltip;

  /// No description provided for @turnOnFlashlightTooltip.
  ///
  /// In en, this message translates to:
  /// **'Turn on flashlight'**
  String get turnOnFlashlightTooltip;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @preferencesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferencesSectionTitle;

  /// No description provided for @deviceDataSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Device data'**
  String get deviceDataSectionTitle;

  /// No description provided for @informationSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get informationSectionTitle;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @selectLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguageTitle;

  /// No description provided for @turkmenLanguage.
  ///
  /// In en, this message translates to:
  /// **'Türkmençe'**
  String get turkmenLanguage;

  /// No description provided for @englishLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  /// No description provided for @resetPhoneNumberTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset phone number'**
  String get resetPhoneNumberTitle;

  /// No description provided for @resetPhoneNumberDescription.
  ///
  /// In en, this message translates to:
  /// **'Remove the number saved on this device'**
  String get resetPhoneNumberDescription;

  /// No description provided for @resetPhoneNumberQuestion.
  ///
  /// In en, this message translates to:
  /// **'Reset phone number?'**
  String get resetPhoneNumberQuestion;

  /// No description provided for @resetPhoneNumberWarning.
  ///
  /// In en, this message translates to:
  /// **'Your saved number will be removed and you will return to the welcome screen.'**
  String get resetPhoneNumberWarning;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About QR Töleg'**
  String get aboutTitle;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'App details, privacy, and licenses'**
  String get aboutDescription;

  /// No description provided for @aboutPurpose.
  ///
  /// In en, this message translates to:
  /// **'QR Töleg helps you prepare TMcell balance transfers using QR codes.'**
  String get aboutPurpose;

  /// Application version and build number.
  ///
  /// In en, this message translates to:
  /// **'Version {version} ({buildNumber})'**
  String aboutVersionLabel(String version, String buildNumber);

  /// No description provided for @aboutHowItWorksTitle.
  ///
  /// In en, this message translates to:
  /// **'You stay in control'**
  String get aboutHowItWorksTitle;

  /// No description provided for @aboutHowItWorksBody.
  ///
  /// In en, this message translates to:
  /// **'QR Töleg prepares the transfer SMS. You review it and press Send in your messaging app.'**
  String get aboutHowItWorksBody;

  /// No description provided for @aboutPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Private by design'**
  String get aboutPrivacyTitle;

  /// No description provided for @aboutPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'Your phone number stays on this device. QR Töleg has no account, backend, analytics, or cloud storage.'**
  String get aboutPrivacyBody;

  /// No description provided for @aboutIndependenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Independent app'**
  String get aboutIndependenceTitle;

  /// No description provided for @aboutIndependenceBody.
  ///
  /// In en, this message translates to:
  /// **'QR Töleg is not an official TMcell app and is not affiliated with TMcell.'**
  String get aboutIndependenceBody;

  /// No description provided for @aboutCarrierTitle.
  ///
  /// In en, this message translates to:
  /// **'Carrier terms'**
  String get aboutCarrierTitle;

  /// No description provided for @aboutCarrierBody.
  ///
  /// In en, this message translates to:
  /// **'Transfer availability, fees, limits, and processing are controlled by TMcell.'**
  String get aboutCarrierBody;

  /// No description provided for @sourceCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Source code'**
  String get sourceCodeTitle;

  /// No description provided for @sourceCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'View QR Töleg on GitHub'**
  String get sourceCodeDescription;

  /// No description provided for @openSourceLicensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Open-source licenses'**
  String get openSourceLicensesTitle;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @resetAction.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetAction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tk':
      return AppLocalizationsTk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
