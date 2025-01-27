//import 'package:flutter/cupertion.dart';
//import 'package:flutter/fondation.dart';
//import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smtmonitoring/localization/en_us/en_us_translations.dart';
import '../core/app_export.dart';
import 'fr_FR/fr_fr_translations.dart';

//import 'en_us/en_us/translations.dart';
extension LocalizationExtension on String {
  String get tr => AppLocalization.of().getString(this);
}

// ignore_for_file: must_be_immutable
class AppLocalization {
  AppLocalization(this.locale);
  Locale locale;
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': enUs, // English translations
    'fr': frFR, // French translations
  };
  static AppLocalization of() {
    return Localizations.of<AppLocalization>(
        NavigatorService.navigatorKey.currentContext!, AppLocalization)!;
  }

  static List<String> languages() => _localizedValues.keys.toList();
  String getString(String text) =>
      _localizedValues[locale.languageCode]![text] ?? text;
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    // Add all supported locales here
    return ['en', 'fr'].contains(locale.languageCode);
  }

  //Returning a SynchronousFuture here because an async "load" operation //cause an async "load" operation @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
