import 'package:Tubuddy/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new CupertinoTabScaffold(
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
                    pageContent = new CalendarTabPage();
                    break;
                  case 1:
                    pageContent = new MedicationTabPage();
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
                    child: new Scaffold(body: pageContent));
              },
            ),
          );
        },
      ),
    );
  }
}
