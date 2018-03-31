import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';

class CalendarTabPage extends StatelessWidget implements TabPage {
  static final title = const Text("Calendar");

  // 0xf3f3: calendar icon (see: https://raw.githubusercontent.com/flutter/cupertino_icons/master/map.png)
  static final Icon icon = const Icon(const IconData(0xf3f3,
      fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'));

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.do_not_disturb_alt);
  }

  @override
  Text getTitle() {
    return title;
  }
}
