import 'package:flutter/material.dart';

import 'l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('de'); // set the default language for the App

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}
