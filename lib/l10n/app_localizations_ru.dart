// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'QR Töleg';

  @override
  String get settingsTooltip => 'Настройки';

  @override
  String get receiveBalanceTitle => 'Получить баланс';

  @override
  String get receiveBalanceDescription =>
      'Покажите этот код тому, кто переводит вам баланс.';

  @override
  String get personalQrCodeSemantics => 'Личный QR-код';

  @override
  String get yourTmcellNumber => 'Ваш номер TMcell';

  @override
  String get scanToSendBalance => 'Отсканируйте, чтобы перевести баланс';

  @override
  String get confirmPhoneNumberTitle => 'Это ваш номер?';

  @override
  String get confirmPhoneNumberWarning =>
      'Внимательно проверьте номер. Деньги, отправленные по вашему QR-коду, поступят на этот номер.';

  @override
  String get editAction => 'Изменить';

  @override
  String get confirmPhoneNumberAction => 'Да, это мой номер';

  @override
  String get enterPhoneNumberTitle => 'Введите номер телефона';

  @override
  String get enterPhoneNumberDescription =>
      'Мы используем ваш номер TMcell, чтобы создать личный QR-код.';

  @override
  String get tmcellNumberLabel => 'Номер TMcell';

  @override
  String get phoneNumberHelper => 'Введите 8 цифр после +993.';

  @override
  String get phoneNumberCheckHint =>
      'Не уверены в своем номере? Наберите *222#, чтобы узнать его.';

  @override
  String get proceedAction => 'Продолжить';

  @override
  String get tmcellAffiliationDisclaimer =>
      'Это неофициальное приложение TMcell, не связанное с компанией TMcell. Введенный номер хранится только на вашем телефоне. Приложение не хранит его за пределами телефона и никуда не отправляет.';

  @override
  String get sendBalanceTitle => 'Перевести баланс';

  @override
  String get enterAmountTitle => 'Введите сумму';

  @override
  String sendingBalanceTo(String recipient) {
    return 'Вы переводите баланс на номер $recipient.';
  }

  @override
  String get amountLabel => 'Сумма';

  @override
  String get invalidAmountError => 'Введите сумму от 1 до 50 TMT.';

  @override
  String get amountHelper => 'Введите целую сумму от 1 до 50 TMT.';

  @override
  String get couldNotOpenMessages => 'Не удалось открыть приложение SMS.';

  @override
  String get confirmTransferTitle => 'Подтвердить перевод';

  @override
  String get reviewDetailsTitle => 'Проверьте данные';

  @override
  String get recipientLabel => 'Получатель';

  @override
  String get carrierFeeLabel => 'Комиссия оператора';

  @override
  String get totalRequiredBalanceLabel => 'Необходимый общий баланс';

  @override
  String get balanceCheckHint =>
      'Наберите *0800#, чтобы проверить, хватает ли баланса для этого перевода.';

  @override
  String get smsDestinationLabel => 'SMS на номер 0804';

  @override
  String get openMessagesAction => 'Открыть SMS';

  @override
  String get scanQrCodeTitle => 'Сканировать QR-код';

  @override
  String get invalidQrCodeMessage => 'Это не QR-код QR Töleg.';

  @override
  String get cameraAccessNeededTitle => 'Нужен доступ к камере';

  @override
  String get cameraAccessNeededBody =>
      'Разрешите доступ к камере, чтобы сканировать QR-код QR Töleg.';

  @override
  String get tryAgainAction => 'Повторить';

  @override
  String get allowCameraInSettingsTitle =>
      'Разрешите доступ к камере в настройках';

  @override
  String get cameraAccessDisabledBody => 'Доступ QR Töleg к камере отключен.';

  @override
  String get openSettingsAction => 'Открыть настройки';

  @override
  String get cameraUnavailableTitle => 'Камера недоступна';

  @override
  String get cameraUnavailableDeviceBody =>
      'На этом устройстве нельзя использовать камеру.';

  @override
  String get cameraCouldNotStartBody => 'Не удалось запустить камеру.';

  @override
  String get placeQrInFrame => 'Поместите QR-код в рамку';

  @override
  String get turnOffFlashlightTooltip => 'Выключить фонарик';

  @override
  String get turnOnFlashlightTooltip => 'Включить фонарик';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get preferencesSectionTitle => 'Параметры';

  @override
  String get deviceDataSectionTitle => 'Данные на устройстве';

  @override
  String get informationSectionTitle => 'Информация';

  @override
  String get languageTitle => 'Язык';

  @override
  String get selectLanguageTitle => 'Выберите язык';

  @override
  String get turkmenLanguage => 'Türkmençe';

  @override
  String get englishLanguage => 'English';

  @override
  String get russianLanguage => 'Русский';

  @override
  String get resetPhoneNumberTitle => 'Сбросить номер телефона';

  @override
  String get resetPhoneNumberDescription =>
      'Удалить номер, сохраненный на этом устройстве';

  @override
  String get resetPhoneNumberQuestion => 'Сбросить номер телефона?';

  @override
  String get resetPhoneNumberWarning =>
      'Сохраненный номер будет удален, и вы вернетесь на начальный экран.';

  @override
  String get aboutTitle => 'О QR Töleg';

  @override
  String get aboutDescription => 'О приложении, конфиденциальности и лицензиях';

  @override
  String get aboutPurpose =>
      'QR Töleg помогает подготавливать переводы баланса TMcell с помощью QR-кодов.';

  @override
  String aboutVersionLabel(String version, String buildNumber) {
    return 'Версия $version ($buildNumber)';
  }

  @override
  String get aboutHowItWorksTitle => 'Вы контролируете перевод';

  @override
  String get aboutHowItWorksBody =>
      'QR Töleg подготавливает SMS для перевода. Вы проверяете его и сами нажимаете «Отправить» в приложении SMS.';

  @override
  String get aboutPrivacyTitle => 'Конфиденциальность по замыслу';

  @override
  String get aboutPrivacyBody =>
      'Ваш номер телефона хранится только на этом устройстве. В QR Töleg нет учетных записей, сервера, аналитики или облачного хранилища.';

  @override
  String get aboutIndependenceTitle => 'Независимое приложение';

  @override
  String get aboutIndependenceBody =>
      'QR Töleg — неофициальное приложение TMcell, не связанное с компанией TMcell.';

  @override
  String get aboutCarrierTitle => 'Условия оператора';

  @override
  String get aboutCarrierBody =>
      'Доступность, комиссии, лимиты и обработка переводов определяются TMcell.';

  @override
  String get sourceCodeTitle => 'Исходный код';

  @override
  String get sourceCodeDescription => 'Посмотреть QR Töleg на GitHub';

  @override
  String get openSourceLicensesTitle => 'Лицензии открытого ПО';

  @override
  String get cancelAction => 'Отмена';

  @override
  String get resetAction => 'Сбросить';
}
