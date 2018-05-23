import 'dart:async';
import 'package:Tubuddy/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _userToken = "";

  _MyAppState() : selectedDate = new DateTime.now();

  Widget getLoggedInPage() {
    return new CupertinoTabScaffold(
      tabBar: new CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: CalendarTabPage.icon,
            title: CalendarTabPage.title,
          ),
          new BottomNavigationBarItem(
            icon: MedicationTabPage.icon,
            title: MedicationTabPage.title,
          ),
          new BottomNavigationBarItem(
            icon: InformationTabPage.icon,
            title: InformationTabPage.title,
          ),
          new BottomNavigationBarItem(
            icon: FaqTabPage.icon,
            title: FaqTabPage.title,
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
                    middle: pageContent.getTitle(),
                    trailing: GestureDetector(
                        child: Icon(
                            IconData(0xf43c,
                                fontFamily: 'CupertinoIcons',
                                fontPackage: 'cupertino_icons'),
                            size: 28.0,
                            color: CupertinoColors.black),
                        onTap: () {
                          Navigator.push(
                              context,
                              new CupertinoPageRoute(
                                  builder: (context) =>
                                      SettingsPage(() => setState(() {
                                            setUserToken("").then((result) {
                                              _userToken = "";
                                              _userLoggedIn = false;
                                            });
                                          }))));
                        }),
                  ),
                  child: new Material(child: pageContent));
            },
          ),
        );
      },
    );
  }

  Future<bool> setUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token == "") {
      return prefs.remove("user_token");
    }
    return prefs.setString("user_token", token);
  }

  Future<String> getExistingUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_token");
  }

  Widget getPage(BuildContext context) {
    if (_userLoggedIn) {
      return getLoggedInPage();
    } else {
      return LoginPage((String token) {
        setUserToken(token);

        setState(() {
          _userLoggedIn = true;
          _userToken = token;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      builder: (context, state) {
        if (state.connectionState != ConnectionState.waiting &&
            state.data != null &&
            state.data != "") {
          _userToken = state.data;
          _userLoggedIn = true;
        }
        return new MaterialApp(home: getPage(context));
      },
      future: getExistingUserToken(),
    );
  }
}
