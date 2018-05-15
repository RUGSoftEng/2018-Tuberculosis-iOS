import 'package:Tubuddy/pages/medication_tab_page.dart';
import 'package:Tubuddy/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
  bool _userLoggedIn = false; // replace with actual check in the future.

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
                      middle: pageContent.getTitle()),
                  child: new Material(child: pageContent));
            },
          ),
        );
      },
    );
  }

  Widget getPage() {
    if (_userLoggedIn) {
      return getLoggedInPage();
    } else {
      return new LoginPage((bool loggedIn) => setState(() {
        _userLoggedIn = loggedIn;
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: getPage()
    );
  }
}
