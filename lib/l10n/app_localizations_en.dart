// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'QR Töleg';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get receiveBalanceTitle => 'Receive balance';

  @override
  String get receiveBalanceDescription =>
      'Show this code to the person sending you balance.';

  @override
  String get personalQrCodeSemantics => 'Personal QR code';

  @override
  String get yourTmcellNumber => 'Your TMcell number';

  @override
  String get scanToSendBalance => 'Scan to send balance';

  @override
  String get confirmPhoneNumberTitle => 'Is this your number?';

  @override
  String get confirmPhoneNumberWarning =>
      'Please check carefully. Money sent using your QR code will go to this phone number.';

  @override
  String get editAction => 'Edit';

  @override
  String get confirmPhoneNumberAction => 'Yes, this is my number';

  @override
  String get enterPhoneNumberTitle => 'Enter your phone number';

  @override
  String get enterPhoneNumberDescription =>
      'We use your TMcell number to create your personal QR code.';

  @override
  String get tmcellNumberLabel => 'TMcell number';

  @override
  String get phoneNumberHelper => 'Enter the 8 digits after +993.';

  @override
  String get phoneNumberCheckHint =>
      'Not sure of your number? Dial *222# on your phone to check it.';

  @override
  String get proceedAction => 'Proceed';

  @override
  String get tmcellAffiliationDisclaimer =>
      'This is not an official TMcell app and is not affiliated with TMcell. The phone number you enter is stored only on your phone. The app does not store it outside your phone or send it anywhere.';

  @override
  String get sendBalanceTitle => 'Send balance';

  @override
  String get enterAmountTitle => 'Enter the amount';

  @override
  String sendingBalanceTo(String recipient) {
    return 'You are sending balance to $recipient.';
  }

  @override
  String get amountLabel => 'Amount';

  @override
  String get invalidAmountError => 'Enter an amount from 1 to 50 TMT.';

  @override
  String get amountHelper => 'Enter a whole-number amount from 1 to 50 TMT.';

  @override
  String get couldNotOpenMessages => 'Could not open Messages.';

  @override
  String get confirmTransferTitle => 'Confirm transfer';

  @override
  String get reviewDetailsTitle => 'Review the details';

  @override
  String get recipientLabel => 'Recipient';

  @override
  String get carrierFeeLabel => 'Carrier fee';

  @override
  String get totalRequiredBalanceLabel => 'Total required balance';

  @override
  String get balanceCheckHint =>
      'You can dial *0800# to check if you have enough balance for this transfer.';

  @override
  String get smsDestinationLabel => 'SMS to 0804';

  @override
  String get openMessagesAction => 'Open Messages';

  @override
  String get scanQrCodeTitle => 'Scan QR code';

  @override
  String get invalidQrCodeMessage => 'This isn\'t a QR Töleg code.';

  @override
  String get cameraAccessNeededTitle => 'Camera access is needed';

  @override
  String get cameraAccessNeededBody =>
      'Allow camera access to scan a QR Töleg code.';

  @override
  String get tryAgainAction => 'Try again';

  @override
  String get allowCameraInSettingsTitle => 'Allow camera access in Settings';

  @override
  String get cameraAccessDisabledBody =>
      'Camera access is turned off for QR Töleg.';

  @override
  String get openSettingsAction => 'Open settings';

  @override
  String get cameraUnavailableTitle => 'Camera unavailable';

  @override
  String get cameraUnavailableDeviceBody =>
      'The camera cannot be used on this device.';

  @override
  String get cameraCouldNotStartBody => 'The camera could not be started.';

  @override
  String get placeQrInFrame => 'Place the QR code inside the frame';

  @override
  String get turnOffFlashlightTooltip => 'Turn off flashlight';

  @override
  String get turnOnFlashlightTooltip => 'Turn on flashlight';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get preferencesSectionTitle => 'Preferences';

  @override
  String get deviceDataSectionTitle => 'Device data';

  @override
  String get informationSectionTitle => 'Information';

  @override
  String get languageTitle => 'Language';

  @override
  String get selectLanguageTitle => 'Select language';

  @override
  String get turkmenLanguage => 'Türkmençe';

  @override
  String get englishLanguage => 'English';

  @override
  String get resetPhoneNumberTitle => 'Reset phone number';

  @override
  String get resetPhoneNumberDescription =>
      'Remove the number saved on this device';

  @override
  String get resetPhoneNumberQuestion => 'Reset phone number?';

  @override
  String get resetPhoneNumberWarning =>
      'Your saved number will be removed and you will return to the welcome screen.';

  @override
  String get aboutTitle => 'About QR Töleg';

  @override
  String get aboutDescription => 'App details, privacy, and licenses';

  @override
  String get aboutPurpose =>
      'QR Töleg helps you prepare TMcell balance transfers using QR codes.';

  @override
  String aboutVersionLabel(String version, String buildNumber) {
    return 'Version $version ($buildNumber)';
  }

  @override
  String get aboutHowItWorksTitle => 'You stay in control';

  @override
  String get aboutHowItWorksBody =>
      'QR Töleg prepares the transfer SMS. You review it and press Send in your messaging app.';

  @override
  String get aboutPrivacyTitle => 'Private by design';

  @override
  String get aboutPrivacyBody =>
      'Your phone number stays on this device. QR Töleg has no account, backend, analytics, or cloud storage.';

  @override
  String get aboutIndependenceTitle => 'Independent app';

  @override
  String get aboutIndependenceBody =>
      'QR Töleg is not an official TMcell app and is not affiliated with TMcell.';

  @override
  String get aboutCarrierTitle => 'Carrier terms';

  @override
  String get aboutCarrierBody =>
      'Transfer availability, fees, limits, and processing are controlled by TMcell.';

  @override
  String get sourceCodeTitle => 'Source code';

  @override
  String get sourceCodeDescription => 'View QR Töleg on GitHub';

  @override
  String get openSourceLicensesTitle => 'Open-source licenses';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get resetAction => 'Reset';
}
