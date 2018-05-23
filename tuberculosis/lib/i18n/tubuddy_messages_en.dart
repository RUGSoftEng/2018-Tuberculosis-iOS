// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  static m0(howMany) => "${Intl.plural(howMany, one: 'pill', many: 'pills', other: 'pills')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "calendarTitle" : MessageLookupByLibrary.simpleMessage("Calendar"),
    "faqTitle" : MessageLookupByLibrary.simpleMessage("FAQ"),
    "forgotPasswordBtnText" : MessageLookupByLibrary.simpleMessage("Forgotten Password"),
    "informationTitle" : MessageLookupByLibrary.simpleMessage("Information"),
    "loginBtnInProgressText" : MessageLookupByLibrary.simpleMessage("Logging In..."),
    "loginBtnText" : MessageLookupByLibrary.simpleMessage("Log In"),
    "loginIncorrectCredentials" : MessageLookupByLibrary.simpleMessage("Username or password incorrect."),
    "loginMissingPassword" : MessageLookupByLibrary.simpleMessage("Please enter a password"),
    "loginMissingUsername" : MessageLookupByLibrary.simpleMessage("Please enter a username"),
    "medicationTitle" : MessageLookupByLibrary.simpleMessage("Medication"),
    "pillText" : m0,
    "welcomeText" : MessageLookupByLibrary.simpleMessage("Welcome to Tubuddy!")
  };
}
