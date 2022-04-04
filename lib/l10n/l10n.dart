import 'dart:ui';

class L10n {
  static final all = [const Locale('en'), const Locale('de')];

  static String getLanguage(String code) {
    switch (code) {
      case 'de':
        return 'Deutsch';
      case 'en':
      default:
        return 'English';
    }
  }
}
