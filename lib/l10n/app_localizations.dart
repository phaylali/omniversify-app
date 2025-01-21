import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_zgh.dart';

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
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('zgh')
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Omniversify'**
  String get app_title;

  /// Home navigation label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Profile navigation label
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Settings navigation label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language settings option
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Theme settings option
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Privacy policy link text
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// Licenses page title
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// Exit button text
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// Exit confirmation dialog message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit?'**
  String get exit_confirmation;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Scroll action text
  ///
  /// In en, this message translates to:
  /// **'Scroll'**
  String get scroll;

  /// Open link button text
  ///
  /// In en, this message translates to:
  /// **'Open Link'**
  String get open_link;

  /// Link opening confirmation message
  ///
  /// In en, this message translates to:
  /// **'Do you want to open this link in your browser?'**
  String get open_link_confirmation;

  /// Television category label
  ///
  /// In en, this message translates to:
  /// **'TV'**
  String get tv;

  /// Action to save content
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Social media post action
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// Social activity or event
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// Video game or gaming content
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get game;

  /// Audio content
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get audio;

  /// Musical content
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// Geographic location
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Film content
  ///
  /// In en, this message translates to:
  /// **'Movie'**
  String get movie;

  /// TV or web series content
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get series;

  /// Voting poll
  ///
  /// In en, this message translates to:
  /// **'Poll'**
  String get poll;

  /// Animated GIF image
  ///
  /// In en, this message translates to:
  /// **'GIF'**
  String get gif;

  /// Web link or URL
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get link;

  /// Book content
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// Video content
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// Image content
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// Placeholder text for post creation input
  ///
  /// In en, this message translates to:
  /// **'What\'s on your mind?'**
  String get whats_on_your_mind;

  /// Action to clear database
  ///
  /// In en, this message translates to:
  /// **'Clear Database'**
  String get clearDatabase;

  /// Delete action
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Action to delete database
  ///
  /// In en, this message translates to:
  /// **'Delete Database'**
  String get deleteDatabase;

  /// Log out action
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// Action to sync data
  ///
  /// In en, this message translates to:
  /// **'Sync Data'**
  String get syncData;

  /// Status message for sync
  ///
  /// In en, this message translates to:
  /// **'Sync in Progress'**
  String get syncInProgress;

  /// Arabic language option
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Tifinagh language option
  ///
  /// In en, this message translates to:
  /// **'Tifinagh'**
  String get tifinagh;

  /// Spanish language option
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// Theme mode selection
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get lightTheme;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get systemTheme;

  /// Username input field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Sign in action button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Dialog box label
  ///
  /// In en, this message translates to:
  /// **'Dialog'**
  String get dialogLabel;

  /// Alert dialog label
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alertDialogLabel;

  /// Search field label
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchFieldLabel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'es', 'zgh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'zgh': return AppLocalizationsZgh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
