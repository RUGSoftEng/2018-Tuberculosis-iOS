import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// TranslationLanguage provides an easy way for all children in the app
/// to access the current language and an easy way to change it using [TranslatedAppState].
class TranslationLanguage extends InheritedWidget {
  final TranslatedAppState data;

  TranslationLanguage({Key key, Widget child, this.data}) : super(key: key, child: child);

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
  final WidgetBuilder homeBuilder;

  TranslatedApp({Key key, this.language, this.home, this.homeBuilder}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new TranslatedAppState(language);
}

class TranslatedAppState extends State<TranslatedApp> {
  String language;

  TranslatedAppState(this.language);

  void changeLanguage(String language) async {
    final instance = await SharedPreferences.getInstance();
    if (instance != null) {
      instance.setString('selected_language', language);
    }

    setState(() {
      this.language = language;
    });
  }

  Future<String> getLanguage() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('selected_language');
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
      routes: {
        '/': (context) {
          return new TranslationLanguage(
            child: new FutureBuilder(
              builder: (context, snapshot) {
                Widget body;
                if (widget.homeBuilder != null) {
                  body = widget.homeBuilder(context);
                } else {
                  body = widget.home;
                }

                if (snapshot.connectionState != ConnectionState.waiting) {
                  TranslationLanguage.of(context).changeLanguage(snapshot.data);
                }

                return body;
              },
              future: getLanguage(),
            ),
            data: this,
          );
        }
      },
    );
  }
}
