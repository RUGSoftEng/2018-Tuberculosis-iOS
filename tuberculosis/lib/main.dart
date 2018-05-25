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
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime selectedDate;

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
                      selectedDate,
                      pills,
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
                        child: Icon(IconData(0xf43c, fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
                            size: 28.0, color: CupertinoColors.black),
                        onTap: () {
                          Navigator.push(
                              context,
                              new CupertinoPageRoute(
                                  builder: (context) => SettingsPage(() async {
                                        await (userSettings.currentState as TranslatedAppState).setUserToken("");
                                        // DO NOT REMOVE THE FOLLOWING LINE
                                        // This triggers an update of this widget as it does not happen automatically.
                                        setState(() {});
                                      })));
                        }),
                  ),
                  child: new Material(child: pageContent));
            },
          ),
        );
      },
    );
  }

  Widget getPage(BuildContext context) {
    final state = UserSettings.of(context);
    final _userLoggedIn = (state != null && state.userToken != null && state.userToken.isNotEmpty);

    if (_userLoggedIn) {
      return getLoggedInPage(context);
    } else {
      return new LoginPage((String token) {
        (userSettings.currentState as TranslatedAppState).setUserToken(token);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TranslatedApp(
      key: userSettings,
      homeBuilder: getPage,
    );
  }
}
