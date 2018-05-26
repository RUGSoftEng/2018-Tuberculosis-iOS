import 'dart:async';

import 'package:Tubuddy/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey userSettings = GlobalKey();

class UserSettingsState {
  final String userToken;
  final int patientId;
  final String userLanguage;

  UserSettingsState({this.userToken, this.patientId, this.userLanguage});
}

class UserSettings extends InheritedWidget {
  final TranslatedAppState data;

  UserSettings({child, this.data}) : super(child: child);

  static TranslatedAppState of(BuildContext context) {
    final us =
        (context.inheritFromWidgetOfExactType(UserSettings) as UserSettings);
    if (us == null) return null;
    return us.data;
  }

  @override
  bool updateShouldNotify(UserSettings oldWidget) {
    return oldWidget.data.userToken != data.userToken ||
        oldWidget.data.userLanguage != data.userLanguage ||
        oldWidget.data.patientId != data.patientId;
  }
}

class TranslatedApp extends StatefulWidget {
  final Widget home;
  final WidgetBuilder homeBuilder;

  const TranslatedApp({Key key, this.home, this.homeBuilder}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TranslatedAppState();
}

class TranslatedAppState extends State<TranslatedApp> {
  String userLanguage;
  String userToken;
  int patientId;

  Future<UserSettingsState> getUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString("user_token");
    final userLanguage = prefs.getString("selected_language");
    final patientId = prefs.getInt("patient_id");

    return UserSettingsState(
        userLanguage: userLanguage, patientId: patientId, userToken: userToken);
  }

  Future<bool> setUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token == "") {
      return prefs.remove("user_token");
    }
    setState(() {
      userToken = token;
    });

    return prefs.setString("user_token", token);
  }

  Future<bool> setPatientId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (id == null) {
      return prefs.remove("patient_id");
    }
    setState(() {
      patientId = id;
    });

    return prefs.setInt("patient_id", id);
  }

  void changeLanguage(String language) async {
    final instance = await SharedPreferences.getInstance();
    if (instance != null) {
      instance.setString('selected_language', language);
    }

    setState(() {
      userLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        builder: (context, state) {
          if (state.connectionState == ConnectionState.done) {
            userToken = state.data.userToken;
            userLanguage = state.data.userLanguage;
          }

          initializeApi(userLanguage);

          return UserSettings(
              child: new MaterialApp(
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
                    if (widget.homeBuilder != null) {
                      body = widget.homeBuilder(context);
                    } else {
                      body = widget.home;
                    }

                    return body;
                  }
                },
              ),
              data: this);
        },
        future: getUserSettings());
  }
}
