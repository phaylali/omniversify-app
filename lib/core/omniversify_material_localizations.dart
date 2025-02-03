import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

abstract class OmniversifyMaterialLocalizations extends GlobalMaterialLocalizations {
   OmniversifyMaterialLocalizations({
    super.localeName = 'zgh',
  }) : super(
    fullYearFormat: intl.DateFormat.y(localeName),
    compactDateFormat: intl.DateFormat.yMd(localeName),
    shortDateFormat: intl.DateFormat.yMMMd(localeName),
    mediumDateFormat: intl.DateFormat.MMMEd(localeName),
    longDateFormat: intl.DateFormat.yMMMMEEEEd(localeName),
    yearMonthFormat: intl.DateFormat.yMMMM(localeName),
    shortMonthDayFormat: intl.DateFormat.MMMd(localeName),
    decimalFormat: intl.NumberFormat.decimalPattern(localeName),
    twoDigitZeroPaddedFormat: intl.NumberFormat('00', localeName),
  );

  static const LocalizationsDelegate<MaterialLocalizations> delegate = _OmniversifyMaterialLocalizationsDelegate();
}

class _OmniversifyMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _OmniversifyMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'es', 'zgh'].contains(locale.languageCode);
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    if (locale.languageCode == 'zgh') {
      return GlobalMaterialLocalizations.delegate.load(const Locale('en'));
    }
    return GlobalMaterialLocalizations.delegate.load(locale);
  }

  @override
  bool shouldReload(_OmniversifyMaterialLocalizationsDelegate old) => false;
}
