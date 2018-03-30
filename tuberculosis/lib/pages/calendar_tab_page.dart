import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';

class CalendarTabPage extends StatelessWidget implements TabPage {
  final _title = const Text("Calendar");

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.do_not_disturb_alt);
  }

  @override
  Text getTitle() {
    return _title;
  }
}