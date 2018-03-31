import 'package:Tubuddy/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';

class CalendarTabPage extends StatelessWidget implements TabPage {
  static final title = const Text("Calendar");
  static final Icon icon = const Icon(CupertinoIcons.home);

  final DateTime today;
  final ValueChanged<DateTime> onDateSelected;

  CalendarTabPage(this.today, [this.onDateSelected]);

  @override
  Widget build(BuildContext context) {
    return new Calendar(isExpandable: true, onDateSelected: onDateSelected);
  }

  @override
  Text getTitle() {
    return title;
  }
}