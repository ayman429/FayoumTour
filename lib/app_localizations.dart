import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  Locale? local;
  AppLocalizations({
    this.local,
  });

  static AppLocalizations? of(context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // static _AppLocalizationDelegate delegate = _AppLocalizationDelegate();
  static LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationDelegate();
  late Map<String, String> jsonString;
  Future loadLangJson() async {
    String strings = await rootBundle
        .loadString('assets/languages/${local!.languageCode}.json');
    Map<String, dynamic> jsons = json.decode(strings);
    jsonString = jsons.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) => jsonString[key] ?? "";
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(local: locale);
    await appLocalizations.loadLangJson();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
