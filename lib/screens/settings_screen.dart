import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    required this.languageCode,
    required this.onLanguageChanged,
    required this.onResetPhoneNumber,
    super.key,
  });

  final String languageCode;
  final Future<void> Function(String languageCode) onLanguageChanged;
  final Future<void> Function() onResetPhoneNumber;

  Future<void> _selectLanguage(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final selectedLanguageCode = await showDialog<String>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(l10n.selectLanguageTitle),
        children: [
          _LanguageOption(
            key: const Key('language-option-tk'),
            languageCode: 'tk',
            label: l10n.turkmenLanguage,
            selected: languageCode == 'tk',
          ),
          _LanguageOption(
            key: const Key('language-option-en'),
            languageCode: 'en',
            label: l10n.englishLanguage,
            selected: languageCode == 'en',
          ),
          _LanguageOption(
            key: const Key('language-option-ru'),
            languageCode: 'ru',
            label: l10n.russianLanguage,
            selected: languageCode == 'ru',
          ),
        ],
      ),
    );

    if (selectedLanguageCode != null) {
      await onLanguageChanged(selectedLanguageCode);
    }
  }

  Future<void> _confirmReset(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.resetPhoneNumberQuestion),
        content: Text(l10n.resetPhoneNumberWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancelAction),
          ),
          FilledButton(
            key: const Key('confirm-reset-phone-number'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(l10n.resetAction),
          ),
        ],
      ),
    );

    if (shouldReset != true || !context.mounted) return;

    await onResetPhoneNumber();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.settingsTitle),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionTitle(l10n.preferencesSectionTitle),
                    ListTile(
                      key: const Key('language-setting'),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      tileColor: colors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xFFDDE1DA)),
                      ),
                      leading: const Icon(Icons.language_rounded),
                      title: Text(l10n.languageTitle),
                      subtitle: Text(switch (languageCode) {
                        'tk' => l10n.turkmenLanguage,
                        'ru' => l10n.russianLanguage,
                        _ => l10n.englishLanguage,
                      }),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => _selectLanguage(context),
                    ),
                    const SizedBox(height: 24),
                    _SectionTitle(l10n.deviceDataSectionTitle),
                    ListTile(
                      key: const Key('reset-phone-number'),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      tileColor: colors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xFFDDE1DA)),
                      ),
                      leading: Icon(Icons.delete_outline, color: colors.error),
                      title: Text(
                        l10n.resetPhoneNumberTitle,
                        style: TextStyle(
                          color: colors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(l10n.resetPhoneNumberDescription),
                      onTap: () => _confirmReset(context),
                    ),
                    const SizedBox(height: 24),
                    _SectionTitle(l10n.informationSectionTitle),
                    ListTile(
                      key: const Key('about-setting'),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      tileColor: colors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xFFDDE1DA)),
                      ),
                      leading: const Icon(Icons.info_outline_rounded),
                      title: Text(l10n.aboutTitle),
                      subtitle: Text(l10n.aboutDescription),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => const AboutScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.languageCode,
    required this.label,
    required this.selected,
    super.key,
  });

  final String languageCode;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: () => Navigator.of(context).pop(languageCode),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          if (selected) const Icon(Icons.check_rounded),
        ],
      ),
    );
  }
}
