import 'package:Tubuddy/calendar/calendar.dart';
import 'package:Tubuddy/main.dart';
import 'package:Tubuddy/translated_app.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:Tubuddy/pages/medication_tab_page.dart';

class CalendarTabPage extends StatelessWidget implements TabPage {
  static String getTitleStatic(BuildContext context) {
    return TubuddyStrings.of(context).calendarTitle;
  }

  // 0xf3f3: calendar icon (see: https://raw.githubusercontent.com/flutter/cupertino_icons/master/map.png)
  static final Icon icon =
      const Icon(const IconData(0xf3f3, fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'));

  final DateTime today;
  final ValueChanged<DateTime> onDateSelected;
  final List<MedicationItem> pills;

  CalendarTabPage(this.today, this.pills, [this.onDateSelected]);

  @override
  Widget build(BuildContext context)  {
    final currentLanguage = TranslationLanguage.of(context).language;
    final newLanguage = currentLanguage == 'en' ? 'nl' : 'en';

    return new Column(children: <Widget>[
      Calendar(isExpandable: true, onDateSelected: onDateSelected),
      Divider(color: CupertinoColors.lightBackgroundGray, height: 5.0),
      MaterialButton(
        child: Text('Naar ' + newLanguage.toUpperCase()),
        onPressed: () {
          TranslationLanguage.of(context).changeLanguage(newLanguage);
        },
      ),
      Expanded(
          child: ListView(
        children: pills,
        shrinkWrap: false,
        padding: EdgeInsets.zero,
      )),
    ], mainAxisSize: MainAxisSize.max);
  }

  @override
  Text getTitle(BuildContext context) {
    return Text(getTitleStatic(context));
  }
}
