// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkmen (`tk`).
class AppLocalizationsTk extends AppLocalizations {
  AppLocalizationsTk([String locale = 'tk']) : super(locale);

  @override
  String get appTitle => 'QR Töleg';

  @override
  String get settingsTooltip => 'Sazlamalar';

  @override
  String get receiveBalanceTitle => 'Balans almak';

  @override
  String get receiveBalanceDescription =>
      'Bu kody size balans geçirjek adama görkeziň.';

  @override
  String get personalQrCodeSemantics => 'Şahsy QR-kod';

  @override
  String get yourTmcellNumber => 'Siziň TMcell belgiňiz';

  @override
  String get scanToSendBalance => 'Balans geçirmek üçin skanirläň';

  @override
  String get confirmPhoneNumberTitle => 'Bu siziň belgiňizmi?';

  @override
  String get confirmPhoneNumberWarning =>
      'Üns bilen barlaň. QR-koduňyz arkaly iberilen pul şu telefon belgisine geçiriler.';

  @override
  String get editAction => 'Üýtget';

  @override
  String get confirmPhoneNumberAction => 'Hawa, bu meniň belgim';

  @override
  String get enterPhoneNumberTitle => 'Telefon belgiňizi giriziň';

  @override
  String get enterPhoneNumberDescription =>
      'Şahsy QR-koduňyzy döretmek üçin TMcell belgiňizi ulanýarys.';

  @override
  String get tmcellNumberLabel => 'TMcell belgisi';

  @override
  String get phoneNumberHelper => '+993-den soňky 8 sifri giriziň.';

  @override
  String get phoneNumberCheckHint =>
      'Belgiňizi anyk bilmeýärsiňizmi? Barlamak üçin telefonyňyzdan *222# belgisini aýlaň.';

  @override
  String get proceedAction => 'Dowam et';

  @override
  String get tmcellAffiliationDisclaimer =>
      'Bu programma TMcell-iň resmi programmasy däldir we TMcell bilen hiç hili baglanyşygy ýokdur. Siziň girizen telefon belgiňiz diňe öz telefonyňyzda saklanýar. Programma ony telefonyňyzdan daşarda saklamaýar we hiç ýere ibermeýär.';

  @override
  String get sendBalanceTitle => 'Balans geçirmek';

  @override
  String get enterAmountTitle => 'Mukdary giriziň';

  @override
  String sendingBalanceTo(String recipient) {
    return 'Siz $recipient belgä balans geçirýärsiňiz.';
  }

  @override
  String get amountLabel => 'Mukdar';

  @override
  String get invalidAmountError => '1–50 TMT aralygynda mukdar giriziň.';

  @override
  String get amountHelper => '1–50 TMT aralygynda diňe bitin san giriziň.';

  @override
  String get couldNotOpenMessages => 'SMS programmasyny açyp bolmady.';

  @override
  String get confirmTransferTitle => 'Geçirimi tassyklamak';

  @override
  String get reviewDetailsTitle => 'Maglumatlary barlaň';

  @override
  String get recipientLabel => 'Alyjy';

  @override
  String get carrierFeeLabel => 'Operatoryň geçirim tölegi';

  @override
  String get totalRequiredBalanceLabel => 'Hasapda zerur jemi serişde';

  @override
  String get balanceCheckHint =>
      'Bu geçirim üçin hasabyňyzda ýeterlik serişdäniň bardygyny barlamak üçin *0800# belgisini aýlap bilersiňiz.';

  @override
  String get smsDestinationLabel => '0804 belgä SMS';

  @override
  String get openMessagesAction => 'SMS programmasyny aç';

  @override
  String get scanQrCodeTitle => 'QR-kody skanirlemek';

  @override
  String get invalidQrCodeMessage => 'Bu QR Töleg kody däl.';

  @override
  String get cameraAccessNeededTitle => 'Kamerany ulanmaga rugsat gerek';

  @override
  String get cameraAccessNeededBody =>
      'QR Töleg koduny skanirlemek üçin kamerany ulanmaga rugsat beriň.';

  @override
  String get tryAgainAction => 'Gaýtadan synanyş';

  @override
  String get allowCameraInSettingsTitle =>
      'Sazlamalarda kamerany ulanmaga rugsat beriň';

  @override
  String get cameraAccessDisabledBody =>
      'QR Töleg programmasynyň kamerany ulanmagyna rugsat berilmeýär.';

  @override
  String get openSettingsAction => 'Sazlamalary aç';

  @override
  String get cameraUnavailableTitle => 'Kamera elýeterli däl';

  @override
  String get cameraUnavailableDeviceBody =>
      'Bu enjamda kamerany ulanyp bolmaýar.';

  @override
  String get cameraCouldNotStartBody => 'Kamerany işledip bolmady.';

  @override
  String get placeQrInFrame => 'QR-kody çarçuwanyň içine ýerleşdiriň';

  @override
  String get turnOffFlashlightTooltip => 'Fonary öçür';

  @override
  String get turnOnFlashlightTooltip => 'Fonary ýak';

  @override
  String get settingsTitle => 'Sazlamalar';

  @override
  String get preferencesSectionTitle => 'Saýlamalar';

  @override
  String get deviceDataSectionTitle => 'Enjamdaky maglumatlar';

  @override
  String get informationSectionTitle => 'Maglumat';

  @override
  String get languageTitle => 'Dil';

  @override
  String get selectLanguageTitle => 'Dili saýlaň';

  @override
  String get turkmenLanguage => 'Türkmençe';

  @override
  String get englishLanguage => 'English';

  @override
  String get russianLanguage => 'Русский';

  @override
  String get resetPhoneNumberTitle => 'Telefon belgisini täzeden bellemek';

  @override
  String get resetPhoneNumberDescription => 'Bu enjamda saklanan belgini aýyr';

  @override
  String get resetPhoneNumberQuestion => 'Telefon belgisi täzeden bellensinmi?';

  @override
  String get resetPhoneNumberWarning =>
      'Saklanan belgiňiz aýrylar we başlangyç ekrana dolanarsyňyz.';

  @override
  String get aboutTitle => 'QR Töleg barada';

  @override
  String get aboutDescription => 'Programma, gizlinlik we lisenziýalar barada';

  @override
  String get aboutPurpose =>
      'QR Töleg QR-kodlaryň kömegi bilen TMcell balans geçirimini taýýarlamaga kömek edýär.';

  @override
  String aboutVersionLabel(String version, String buildNumber) {
    return 'Wersiýa $version ($buildNumber)';
  }

  @override
  String get aboutHowItWorksTitle => 'Geçirim siziň gözegçiligiňizde';

  @override
  String get aboutHowItWorksBody =>
      'QR Töleg geçirim üçin SMS-i taýýarlaýar. Siz ony barlap, SMS programmaňyzda «Iber» düwmesine basýarsyňyz.';

  @override
  String get aboutPrivacyTitle => 'Gizlinlik';

  @override
  String get aboutPrivacyBody =>
      'Telefon belgiňiz diňe şu enjamda saklanýar. QR Töleg-de ulanyjy hasaby, serwer ulgamy, analitika ýa-da bulut ammary ýok.';

  @override
  String get aboutIndependenceTitle => 'Garaşsyz programma';

  @override
  String get aboutIndependenceBody =>
      'QR Töleg TMcell-iň resmi programmasy däldir we TMcell bilen hiç hili baglanyşygy ýokdur.';

  @override
  String get aboutCarrierTitle => 'Operatoryň şertleri';

  @override
  String get aboutCarrierBody =>
      'Geçirimiň elýeterliligi, hyzmat tölegleri, çäkleri we amala aşyrylyşy TMcell tarapyndan kesgitlenýär.';

  @override
  String get sourceCodeTitle => 'Çeşme kody';

  @override
  String get sourceCodeDescription => 'QR Tölegiň çeşme koduny GitHub-da görüň';

  @override
  String get openSourceLicensesTitle => 'Açyk çeşme lisenziýalary';

  @override
  String get cancelAction => 'Ýatyr';

  @override
  String get resetAction => 'Täzeden belle';
}
