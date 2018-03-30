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
              icon: new Image(
                image: new AssetImage("graphics/ic_calendar.png"),
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
              title: const Text('Calendar'),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.book),
              title: const Text('Medication'),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.info),
              title: const Text('Information'),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.conversation_bubble),
              title: const Text('FAQ'),
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
                var pageContent;
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
                    child: new Scaffold(
                  body: pageContent,
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
