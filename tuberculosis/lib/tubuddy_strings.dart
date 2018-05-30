import 'dart:async';
import 'dart:ui';

import 'package:Tubuddy/i18n/tubuddy_messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TubuddyStringsDelegate extends LocalizationsDelegate<TubuddyStrings> {
  TubuddyStringsDelegate([this.overriddenLocale]);

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'en' || locale.languageCode == 'nl';
  }

  @override
  Future<TubuddyStrings> load(Locale locale) {
    return TubuddyStrings.load((overriddenLocale != null && overriddenLocale.isNotEmpty) ? Locale(overriddenLocale) : locale);
  }

  @override
  bool shouldReload(TubuddyStringsDelegate old) {
    return old.overriddenLocale != overriddenLocale;
  }

  final String overriddenLocale;

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

  String get faqTitle => Intl.message(
      'FAQ',
      name: 'faqTitle',
      desc: 'Title for faq tab',
      locale: _localeName
  );

  String get informationTitle => Intl.message(
      'Information',
      name: 'informationTitle',
      desc: 'Title for information tab',
      locale: _localeName
  );

  String get medicationTitle => Intl.message(
      'Medication',
      name: 'medicationTitle',
      desc: 'Title for medication tab',
      locale: _localeName
  );

  String get welcomeText => Intl.message(
      'Welcome to Tubuddy!',
      name: 'welcomeText',
      desc: 'Welcome text on login page',
      locale: _localeName
  );

  String get loginBtnText => Intl.message(
      'Log In',
      name: 'loginBtnText',
      desc: 'Login button text',
      locale: _localeName
  );

  String get loginBtnInProgressText => Intl.message(
      'Logging In...',
      name: 'loginBtnInProgressText',
      desc: 'Login (in progress) button text',
      locale: _localeName
  );

  String get forgotPasswordBtnText => Intl.message(
      'Forgotten Password',
      name: 'forgotPasswordBtnText',
      desc: 'Forgotton password button text',
      locale: _localeName
  );

  String get loginMissingPassword => Intl.message(
      'Please enter a password',
      name: 'loginMissingPassword',
      desc: 'Error message displayed when the user forgets to fill in a password',
      locale: _localeName
  );

  String get loginMissingUsername => Intl.message(
      'Please enter a username',
      name: 'loginMissingUsername',
      desc: 'Error message displayed when the user forgets to fill in a username',
      locale: _localeName
  );

  String get loginIncorrectCredentials => Intl.message(
      'Username or password incorrect.',
      name: 'loginIncorrectCredentials',
      desc: 'Error message displayed when the user provides invalid credentials',
      locale: _localeName
  );

  String pillText(int howMany) => Intl.plural(
    howMany,
    one: 'pill',
    many: 'pills',
    other: 'pills',
    name: 'pillText',
    args: [howMany],
    desc: 'Text for "pill" singular and plural.'
  );

  String get username => Intl.message(
      'Username',
    name: 'username',
    desc: 'Username field on login page',
    locale: _localeName
  );

  String get password => Intl.message(
      'Password',
      name: 'password',
      desc: 'Password field on login page',
      locale: _localeName
  );

  String get quizTitle => Intl.message(
      'Quiz',
      name: 'quizTitle',
      desc: 'Quiz',
      locale: _localeName
  );

  String get quizQuestionCorrect => Intl.message(
    'Goed!',
    name: 'quizQuestionCorrect',
    desc: 'Text displayed when quiz question is answered correctly',
    locale: _localeName
  );

  String quizQuestionWrong(String correctAnswer) => Intl.message(
    'Fout. Het goede antwoord is $correctAnswer.',
    name: 'quizQuestionWrong',
    desc: 'Text displayed when quiz question is answered incorrectly',
    locale: _localeName,
    args: [correctAnswer]
  );

  String quizQuestionProgress(int current, int total) => Intl.message(
      'Vraag $current/$total',
      name: 'quizQuestionProgress',
      desc: 'Progress indication for quiz',
      locale: _localeName,
      args: [current, total]
  );

  String quizResult(int correct, int total) => Intl.message(
      'Je had $correct vragen van de $total goed.',
      name: 'quizResult',
      desc: 'Result indication for quiz',
      locale: _localeName,
      args: [correct, total]
  );

  String get settings => Intl.message(
    'Settings',
    name: 'settings',
    desc: 'Title of settings page',
    locale: _localeName
  );

  String get language => Intl.message(
    'Language',
    name: 'language',
    desc: 'Language title on settings page',
    locale: _localeName
  );

  String get logout => Intl.message(
      'Log Out',
      name: 'logout',
      desc: 'Log out button on settings page',
      locale: _localeName
  );

  String get updateMedicationError => Intl.message(
      'Error while connecting to server. Please try again.',
    name: 'updateMedicationError',
    desc: 'Text displayed when the medication taken status could not be updated',
    locale: _localeName
  );
}