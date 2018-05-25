// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
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
  get localeName => 'nl';

  static m0(howMany) => "${Intl.plural(howMany, one: 'pil', many: 'pillen', other: 'pillen')}";

  static m1(current, total) => "Vraag ${current}/${total}";

  static m2(correctAnswer) => "Fout. Het goede antwoord is ${correctAnswer}.";

  static m3(correct, total) => "Je had ${correct} vragen van de ${total} goed.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "calendarTitle" : MessageLookupByLibrary.simpleMessage("Kalender"),
    "faqTitle" : MessageLookupByLibrary.simpleMessage("FAQ"),
    "forgotPasswordBtnText" : MessageLookupByLibrary.simpleMessage("Wachtwoord Vergeten"),
    "informationTitle" : MessageLookupByLibrary.simpleMessage("Informatie"),
    "loginBtnInProgressText" : MessageLookupByLibrary.simpleMessage("Aan het inloggen..."),
    "loginBtnText" : MessageLookupByLibrary.simpleMessage("Log In"),
    "loginIncorrectCredentials" : MessageLookupByLibrary.simpleMessage("Gebruikersnaam of wachtwoord incorrect."),
    "loginMissingPassword" : MessageLookupByLibrary.simpleMessage("Vul een wachtwoord in"),
    "loginMissingUsername" : MessageLookupByLibrary.simpleMessage("Vul een gebruikersnaam in"),
    "medicationTitle" : MessageLookupByLibrary.simpleMessage("Medicatie"),
    "password" : MessageLookupByLibrary.simpleMessage("Wachtwoord"),
    "pillText" : m0,
    "quizQuestionCorrect" : MessageLookupByLibrary.simpleMessage("Goed!"),
    "quizQuestionProgress" : m1,
    "quizQuestionWrong" : m2,
    "quizResult" : m3,
    "quizTitle" : MessageLookupByLibrary.simpleMessage("Quiz"),
    "username" : MessageLookupByLibrary.simpleMessage("Gebruikersnaam"),
    "welcomeText" : MessageLookupByLibrary.simpleMessage("Welkom bij Tubuddy!")
  };
}
