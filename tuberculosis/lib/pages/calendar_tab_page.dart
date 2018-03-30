import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';

class CalendarTabPage extends StatelessWidget implements TabPage {
  static final title = const Text("Calendar");
  static final Icon icon = const Icon(CupertinoIcons.home);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.do_not_disturb_alt);
  }

  @override
  Text getTitle() {
    return title;
  }
}