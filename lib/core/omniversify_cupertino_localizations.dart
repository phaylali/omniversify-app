import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

abstract class OmniversifyCupertinoLocalizations extends GlobalCupertinoLocalizations {
  OmniversifyCupertinoLocalizations({
    super.localeName = 'zgh',
  }) : super(
  fullYearFormat: intl.DateFormat.y(localeName),
  dayFormat: intl.DateFormat.d(localeName),
  mediumDateFormat: intl.DateFormat.MMMEd(localeName),
  singleDigitHourFormat: intl.DateFormat.j(localeName),
  singleDigitMinuteFormat: intl.DateFormat.m(localeName),
  doubleDigitMinuteFormat: intl.DateFormat('mm',localeName),
  singleDigitSecondFormat: intl.DateFormat.s(localeName),
  decimalFormat: intl.NumberFormat.decimalPattern(localeName),
  weekdayFormat: intl.DateFormat.E(localeName),
  );

  static const LocalizationsDelegate<CupertinoLocalizations> delegate = _OmniversifyCupertinoLocalizationsDelegate();
}

class _OmniversifyCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const _OmniversifyCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'es', 'zgh'].contains(locale.languageCode);
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    if (locale.languageCode == 'zgh') {
      return GlobalCupertinoLocalizations.delegate.load(const Locale('en'));
    }
    return GlobalCupertinoLocalizations.delegate.load(locale);
  }

  @override
  bool shouldReload(_OmniversifyCupertinoLocalizationsDelegate old) => false;
}
