import 'dart:async';
import 'package:Tubuddy/pages/pages.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Tubuddy/translated_app.dart';
import 'package:tuple/tuple.dart';

void main() {
  // Disable rotation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime selectedDate;
  bool _userLoggedIn = false;

  _MyAppState() : selectedDate = new DateTime.now();

  Widget getLoggedInPage(BuildContext context) {
    return new CupertinoTabScaffold(
      tabBar: new CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: CalendarTabPage.icon,
            title: Text(TubuddyStrings.of(context).calendarTitle),
          ),
          new BottomNavigationBarItem(
            icon: MedicationTabPage.icon,
            title: Text(TubuddyStrings.of(context).medicationTitle),
          ),
          new BottomNavigationBarItem(
            icon: InformationTabPage.icon,
            title: Text(TubuddyStrings.of(context).informationTitle),
          ),
          new BottomNavigationBarItem(
            icon: FaqTabPage.icon,
            title: Text(TubuddyStrings.of(context).faqTitle),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return new DefaultTextStyle(
          style: const TextStyle(
            fontFamily: '.SF UI Text',
            fontSize: 17.0,
            color: CupertinoColors.black,
          ),
          child: new CupertinoTabView(
            builder: (BuildContext context) {
              TabPage pageContent;
              switch (index) {
                case 0:
                  List<MedicationItem> pills = dummyMedicationData;
                  if (selectedDate.day != (new DateTime.now()).day) {
                    pills = [new MedicationItem("Fissa", "Any Time", 1)];
                  }
                  pageContent = new CalendarTabPage(
                      selectedDate, pills,
                          (DateTime date) => setState(() {
                        selectedDate = date;
                      }));
                  break;
                case 1:
                  List<MedicationItem> pills = dummyMedicationData;
                  if (selectedDate.day != (new DateTime.now()).day) {
                    pills = [new MedicationItem("Fissa", "Any Time", 1)];
                  }
                  pageContent = new MedicationTabPage(pills);
                  break;
                case 2:
                  pageContent = new InformationTabPage();
                  break;
                case 3:
                  pageContent = new FaqTabPage();
                  break;
              }
              return new CupertinoPageScaffold(
                  navigationBar: new CupertinoNavigationBar(
                    middle: pageContent.getTitle(context),
                    trailing: GestureDetector(
                      child: Icon(Icons.exit_to_app),
                      onTap: () async {
                        await UserSettings.of(context).setUserToken("");
                        setState(() => _userLoggedIn = false);
                      },
                    ),
                  ),
                  child: new Material(child: pageContent));
            },
          ),
        );
      },
    );
  }

  Future<UserSettingsState> getUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString("user_token");
    final userLanguage = prefs.getString("selected_language");

    return UserSettingsState(userLanguage: userLanguage, userToken: userToken);
  }

  Widget getPage(BuildContext context) {
    if (_userLoggedIn) {
      return getLoggedInPage(context);
    } else {
      return new LoginPage((String token) {
        UserSettings.of(context).setUserToken(token);
        setState(() {
          _userLoggedIn = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(builder: (context, state) {
      UserSettingsState us = UserSettingsState();
      if (state.connectionState == ConnectionState.done) {
        us = state.data;
        if (us.userToken != null && us.userToken != '') {
          _userLoggedIn = true;
        }
      }

      return UserSettings(
        child: TranslatedApp(
          homeBuilder: getPage,
        ),
        data: us
      );
    }, future: getUserSettings());
  }
}
