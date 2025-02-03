
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class OmniversifyWidgetsLocalizations extends GlobalWidgetsLocalizations {
   OmniversifyWidgetsLocalizations(String localeName) 
    : super(_getTextDirection(localeName));

  static TextDirection _getTextDirection(String localeName) {
    switch (localeName) {
      case 'ar':
      
        return TextDirection.rtl;
      default:
        return TextDirection.ltr;
    }
  }

  static const LocalizationsDelegate<WidgetsLocalizations> delegate = _OmniversifyWidgetsLocalizationsDelegate();
}

class _OmniversifyWidgetsLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const _OmniversifyWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'es', 'zgh'].contains(locale.languageCode);
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) async {
    if (locale.languageCode == 'zgh') {
      return GlobalWidgetsLocalizations.delegate.load(const Locale('en'));
    }
    return GlobalWidgetsLocalizations.delegate.load(locale);
  }

  @override
  bool shouldReload(_OmniversifyWidgetsLocalizationsDelegate old) => false;
}
