import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
/// To configure the locales supported by your app, you'll need to edit this
/// file.
///
/// First, open your project's ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project's Runner folder.
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Instrument Tuner'**
  String get appTitle;

  /// No description provided for @tuner.
  ///
  /// In en, this message translates to:
  /// **'Tuner'**
  String get tuner;

  /// No description provided for @instruments.
  ///
  /// In en, this message translates to:
  /// **'Instruments'**
  String get instruments;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @guitar.
  ///
  /// In en, this message translates to:
  /// **'Guitar'**
  String get guitar;

  /// No description provided for @guitar6.
  ///
  /// In en, this message translates to:
  /// **'6-String Guitar'**
  String get guitar6;

  /// No description provided for @guitar7.
  ///
  /// In en, this message translates to:
  /// **'7-String Guitar'**
  String get guitar7;

  /// No description provided for @guitar8.
  ///
  /// In en, this message translates to:
  /// **'8-String Guitar'**
  String get guitar8;

  /// No description provided for @ukulele.
  ///
  /// In en, this message translates to:
  /// **'Ukulele'**
  String get ukulele;

  /// No description provided for @violin.
  ///
  /// In en, this message translates to:
  /// **'Violin'**
  String get violin;

  /// No description provided for @viola.
  ///
  /// In en, this message translates to:
  /// **'Viola'**
  String get viola;

  /// No description provided for @cello.
  ///
  /// In en, this message translates to:
  /// **'Cello'**
  String get cello;

  /// No description provided for @bass.
  ///
  /// In en, this message translates to:
  /// **'Bass Guitar'**
  String get bass;

  /// No description provided for @mandolin.
  ///
  /// In en, this message translates to:
  /// **'Mandolin'**
  String get mandolin;

  /// No description provided for @banjo.
  ///
  /// In en, this message translates to:
  /// **'Banjo'**
  String get banjo;

  /// No description provided for @tuningStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard Tuning'**
  String get tuningStandard;

  /// No description provided for @tuningDropD.
  ///
  /// In en, this message translates to:
  /// **'Drop D'**
  String get tuningDropD;

  /// No description provided for @tuningDropC.
  ///
  /// In en, this message translates to:
  /// **'Drop C'**
  String get tuningDropC;

  /// No description provided for @tuningOpenG.
  ///
  /// In en, this message translates to:
  /// **'Open G'**
  String get tuningOpenG;

  /// No description provided for @tuningOpenD.
  ///
  /// In en, this message translates to:
  /// **'Open D'**
  String get tuningOpenD;

  /// No description provided for @tuningDADGAD.
  ///
  /// In en, this message translates to:
  /// **'DADGAD'**
  String get tuningDADGAD;

  /// No description provided for @tuningHalfStep.
  ///
  /// In en, this message translates to:
  /// **'Half Step Down'**
  String get tuningHalfStep;

  /// No description provided for @tuningFullStep.
  ///
  /// In en, this message translates to:
  /// **'Full Step Down'**
  String get tuningFullStep;

  /// No description provided for @listening.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get listening;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap to start tuning'**
  String get tapToStart;

  /// No description provided for @inTune.
  ///
  /// In en, this message translates to:
  /// **'In Tune!'**
  String get inTune;

  /// No description provided for @tooLow.
  ///
  /// In en, this message translates to:
  /// **'Too Low'**
  String get tooLow;

  /// No description provided for @tooHigh.
  ///
  /// In en, this message translates to:
  /// **'Too High'**
  String get tooHigh;

  /// No description provided for @playNote.
  ///
  /// In en, this message translates to:
  /// **'Play Note'**
  String get playNote;

  /// No description provided for @autoDetect.
  ///
  /// In en, this message translates to:
  /// **'Auto Detect'**
  String get autoDetect;

  /// No description provided for @manual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get manual;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @selectInstrument.
  ///
  /// In en, this message translates to:
  /// **'Select Instrument'**
  String get selectInstrument;

  /// No description provided for @selectTuning.
  ///
  /// In en, this message translates to:
  /// **'Select Tuning'**
  String get selectTuning;

  /// No description provided for @cents.
  ///
  /// In en, this message translates to:
  /// **'cents'**
  String get cents;

  /// No description provided for @hz.
  ///
  /// In en, this message translates to:
  /// **'Hz'**
  String get hz;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
