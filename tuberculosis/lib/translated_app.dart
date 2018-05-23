import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:Tubuddy/tubuddy_strings.dart';

class TranslationLanguage extends InheritedWidget {

  final TranslatedAppState data;

  TranslationLanguage({ Key key, Widget child, this.data }) : super(key: key, child: child);

  static TranslatedAppState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TranslationLanguage) as TranslationLanguage).data;
  }

  @override
  bool updateShouldNotify(TranslationLanguage oldWidget) {
    return oldWidget.data.language != data.language;
  }

}

class TranslatedApp extends StatefulWidget {
  final String language;
  final Widget home;

  const TranslatedApp({Key key, this.language, this.home}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new TranslatedAppState(language);
}

class TranslatedAppState extends State<TranslatedApp> {
  String language;

  TranslatedAppState(this.language);

  void changeLanguage(String language) {
    setState(() => this.language = language);
  }

  @override
  Widget build(BuildContext context) {
    return new TranslationLanguage(child: new MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          TubuddyStringsDelegate(language)
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('nl', 'NL'),
        ],
        localeResolutionCallback: (locale, supported) {
          if (language != null && language.isNotEmpty) {
            return Locale(language);
          } else if (supported.contains(locale)) {
            return locale;
          } else {
            return Locale('en', 'US');
          }
        },
        home: widget.home
    ), data: this,);
  }
}