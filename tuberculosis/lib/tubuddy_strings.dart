import 'dart:async';
import 'dart:ui';

import 'package:Tubuddy/i18n/tubuddy_messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TubuddyStringsDelegate extends LocalizationsDelegate<TubuddyStrings> {
  TubuddyStringsDelegate([this.overridenLocale]);

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'en' || locale.languageCode == 'nl';
  }

  @override
  Future<TubuddyStrings> load(Locale locale) {
    return TubuddyStrings.load((overridenLocale != null && overridenLocale.isNotEmpty) ? Locale(overridenLocale) : locale);
  }

  @override
  bool shouldReload(TubuddyStringsDelegate old) {
    return old.overridenLocale != overridenLocale;
  }

  final String overridenLocale;

}

class TubuddyStrings {
  TubuddyStrings(Locale locale) : _localeName = locale.toString();

  final String _localeName;

  static Future<TubuddyStrings> load(Locale locale) {
    return initializeMessages(locale.toString())
        .then((Object _) {
      return new TubuddyStrings(locale);
    });
  }

  static TubuddyStrings of(BuildContext context) {
    return Localizations.of<TubuddyStrings>(context, TubuddyStrings);
  }

  String get calendarTitle => Intl.message(
    'Calendar',
    name: 'calendarTitle',
    desc: 'Title for calendar tab',
    locale: _localeName
  );

//  String title() {
//    return Intl.message(
//      '<Stocks>',
//      name: 'title',
//      desc: 'Title for the Stocks application',
//      locale: _localeName,
//    );
//  }
//
//  String market() => Intl.message(
//    'MARKET',
//    name: 'market',
//    desc: 'Label for the Market tab',
//    locale: _localeName,
//  );
//
//  String portfolio() => Intl.message(
//    'PORTFOLIO',
//    name: 'portfolio',
//    desc: 'Label for the Portfolio tab',
//    locale: _localeName,
//  );
}