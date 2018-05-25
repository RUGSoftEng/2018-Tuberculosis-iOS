import 'dart:async';

import 'package:Tubuddy/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsWidget extends StatefulWidget {
  final Widget child;

  const UserSettingsWidget({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new UserSettingsState();
}

class UserSettingsState extends State<UserSettingsWidget> {
  String userToken;
  String userLanguage;

  UserSettingsState({this.userToken, this.userLanguage});

  void changeLanguage(String language) async {
    final instance = await SharedPreferences.getInstance();
    if (instance != null) {
      instance.setString('selected_language', language);
    }

    setState(() {
      this.userLanguage = language;
    });
  }

  Future<bool> setUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token == "") {
      return prefs.remove("user_token");
    }
    userToken = token;
    return prefs.setString("user_token", token);
  }

  void fromOther(UserSettingsState other) {
//    setState(() {
    userToken = other.userToken;
    userLanguage = other.userLanguage;
//    });
  }

  Future<String> getLanguage() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('selected_language');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

}

class UserSettings extends InheritedWidget {

  final UserSettingsState data;

  UserSettings({child, this.data}) : super(child: child);

  static UserSettingsState of(BuildContext context) {
    final us = (context.inheritFromWidgetOfExactType(UserSettings) as UserSettings);
    if (us == null) return null;
    return us.data;
  }

  @override
  bool updateShouldNotify(UserSettings oldWidget) {
    return oldWidget.data.userToken != data.userToken || oldWidget.data.userLanguage != data.userLanguage;
  }

}

class TranslatedApp extends StatelessWidget {
  final Widget home;
  final WidgetBuilder homeBuilder;

  const TranslatedApp({Key key, this.home, this.homeBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userLanguage = UserSettings.of(context).userLanguage;
    initializeApi(userLanguage);

    return new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        TubuddyStringsDelegate(userLanguage)
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('nl', 'NL'),
      ],
      localeResolutionCallback: (locale, supported) {
        if (userLanguage != null && userLanguage.isNotEmpty) {
          return Locale(userLanguage);
        } else if (supported.contains(locale)) {
          return locale;
        } else {
          return Locale('en', 'US');
        }
      },
      routes: {
        '/': (context) {
          Widget body;
          if (homeBuilder != null) {
            body = homeBuilder(context);
          } else {
            body = home;
          }

          return body;
        }
      },
    );
  }
}
