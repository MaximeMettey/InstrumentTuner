import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import 'package:instrument_tuner/generated/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsProvider = context.watch<SettingsProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          // Theme section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.theme,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _SettingsTile(
            title: l10n.lightMode,
            trailing: Radio<ThemeMode>(
              value: ThemeMode.light,
              groupValue: settingsProvider.themeMode,
              onChanged: (mode) {
                if (mode != null) settingsProvider.setThemeMode(mode);
              },
            ),
          ),
          _SettingsTile(
            title: l10n.darkMode,
            trailing: Radio<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: settingsProvider.themeMode,
              onChanged: (mode) {
                if (mode != null) settingsProvider.setThemeMode(mode);
              },
            ),
          ),
          _SettingsTile(
            title: l10n.systemDefault,
            trailing: Radio<ThemeMode>(
              value: ThemeMode.system,
              groupValue: settingsProvider.themeMode,
              onChanged: (mode) {
                if (mode != null) settingsProvider.setThemeMode(mode);
              },
            ),
          ),

          const Divider(),

          // Language section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.language,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _SettingsTile(
            title: 'English',
            trailing: Radio<Locale>(
              value: const Locale('en'),
              groupValue: settingsProvider.locale ?? const Locale('en'),
              onChanged: (locale) {
                if (locale != null) settingsProvider.setLocale(locale);
              },
            ),
          ),
          _SettingsTile(
            title: 'Français',
            trailing: Radio<Locale>(
              value: const Locale('fr'),
              groupValue: settingsProvider.locale ?? const Locale('en'),
              onChanged: (locale) {
                if (locale != null) settingsProvider.setLocale(locale);
              },
            ),
          ),
          _SettingsTile(
            title: 'Español',
            trailing: Radio<Locale>(
              value: const Locale('es'),
              groupValue: settingsProvider.locale ?? const Locale('en'),
              onChanged: (locale) {
                if (locale != null) settingsProvider.setLocale(locale);
              },
            ),
          ),
          _SettingsTile(
            title: 'Deutsch',
            trailing: Radio<Locale>(
              value: const Locale('de'),
              groupValue: settingsProvider.locale ?? const Locale('en'),
              onChanged: (locale) {
                if (locale != null) settingsProvider.setLocale(locale);
              },
            ),
          ),

          const Divider(),

          // About section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.about,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _SettingsTile(
            title: l10n.version,
            trailing: const Text('1.0.0'),
          ),
          _SettingsTile(
            title: l10n.appTitle,
            trailing: const Icon(Icons.music_note),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final Widget trailing;

  const _SettingsTile({
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: trailing,
    );
  }
}
