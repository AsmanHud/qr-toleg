import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({
    super.key,
    this.packageInfoLoader = PackageInfo.fromPlatform,
  });

  static final Uri sourceCodeUri = Uri.parse(
    'https://github.com/AsmanHud/qr-toleg',
  );

  final Future<PackageInfo> Function() packageInfoLoader;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.aboutTitle),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.qr_code_2_rounded, size: 64),
                    const SizedBox(height: 12),
                    Text(
                      l10n.appTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    FutureBuilder<PackageInfo>(
                      future: packageInfoLoader(),
                      builder: (context, snapshot) {
                        final packageInfo = snapshot.data;
                        if (packageInfo == null) {
                          return const SizedBox(height: 20);
                        }
                        return Text(
                          l10n.aboutVersionLabel(
                            packageInfo.version,
                            packageInfo.buildNumber,
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.aboutPurpose,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 28),
                    _AboutItem(
                      icon: Icons.sms_outlined,
                      title: l10n.aboutHowItWorksTitle,
                      body: l10n.aboutHowItWorksBody,
                    ),
                    _AboutItem(
                      icon: Icons.lock_outline_rounded,
                      title: l10n.aboutPrivacyTitle,
                      body: l10n.aboutPrivacyBody,
                    ),
                    _AboutItem(
                      icon: Icons.info_outline_rounded,
                      title: l10n.aboutIndependenceTitle,
                      body: l10n.aboutIndependenceBody,
                    ),
                    _AboutItem(
                      icon: Icons.receipt_long_outlined,
                      title: l10n.aboutCarrierTitle,
                      body: l10n.aboutCarrierBody,
                    ),
                    const Divider(height: 32),
                    ListTile(
                      key: const Key('source-code'),
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.code_rounded),
                      title: Text(l10n.sourceCodeTitle),
                      subtitle: Text(l10n.sourceCodeDescription),
                      trailing: const Icon(Icons.open_in_new_rounded),
                      onTap: () => launchUrl(
                        sourceCodeUri,
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    ListTile(
                      key: const Key('open-source-licenses'),
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.description_outlined),
                      title: Text(l10n.openSourceLicensesTitle),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => showLicensePage(
                        context: context,
                        applicationName: l10n.appTitle,
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

class _AboutItem extends StatelessWidget {
  const _AboutItem({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(top: 2), child: Icon(icon)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
