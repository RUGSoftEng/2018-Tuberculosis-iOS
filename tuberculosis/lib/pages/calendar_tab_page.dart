import 'package:Tubuddy/calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:Tubuddy/pages/medication_tab_page.dart';

class CalendarTabPage extends StatelessWidget implements TabPage {
  static final title = const Text("Calendar");

  // 0xf3f3: calendar icon (see: https://raw.githubusercontent.com/flutter/cupertino_icons/master/map.png)
  static final Icon icon = const Icon(const IconData(0xf3f3,
      fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'));

  final DateTime today;
  final ValueChanged<DateTime> onDateSelected;
  final List<MedicationItem> pills;

  CalendarTabPage(this.today, this.pills, [this.onDateSelected]);

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      Calendar(isExpandable: true, onDateSelected: onDateSelected),
      Expanded(child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return pills[index];
          },
          itemCount: pills.length))
    ]);
  }

  @override
  Text getTitle() {
    return title;
  }
}
