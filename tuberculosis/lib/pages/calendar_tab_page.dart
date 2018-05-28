import 'package:Tubuddy/api/api.dart';
import 'package:Tubuddy/calendar/calendar.dart';
import 'package:Tubuddy/main.dart';
import 'package:Tubuddy/translated_app.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:Tubuddy/pages/medication_tab_page.dart';
import 'package:Tubuddy/api/dosages.dart';

class CalendarTabPage extends StatefulWidget implements TabPage {
  static String getTitleStatic(BuildContext context) {
    return TubuddyStrings.of(context).calendarTitle;
  }

  // 0xf3f3: calendar icon (see: https://raw.githubusercontent.com/flutter/cupertino_icons/master/map.png)
  static final Icon icon = const Icon(const IconData(0xf3f3,
      fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'));

  final DateTime today;

  CalendarTabPage(this.today);

  @override
  Text getTitle(BuildContext context) {
    return Text(getTitleStatic(context));
  }

  @override
  _CalendarTabPageState createState() => new _CalendarTabPageState();
}

class _CalendarTabPageState extends State<CalendarTabPage> {
  ValueChanged<DateTime> onDateSelected;
  DateTime selectedDate;
  List<Dosage> monthDosageList;
  List<Dosage> todayDosageList;
  int _patientId;

  void _updateDosagesForSelectedDate() {
    if (monthDosageList != null) {
      todayDosageList.clear();
      todayDosageList.addAll(monthDosageList.where((dosage) {
        return dosage.date.day == selectedDate.day && dosage.date.month == selectedDate.month;
      }));
    }
  }

  _CalendarTabPageState() : monthDosageList = List<Dosage>(), todayDosageList = List<Dosage>() {

    onDateSelected = (DateTime date) {
      DateTime today = DateTime.now();
      if (selectedDate.month != date.month || selectedDate.year != date.year) {
        api.dosages.getDosages(
            DateTime(today.year, today.month, 1),
            DateTime(today.year, date.month + 1, 1)
        ).then((dosages) {
          setState(() {
            monthDosageList = dosages;
            _updateDosagesForSelectedDate();
          });
        });
      }

      selectedDate = date;
      setState(() => _updateDosagesForSelectedDate());
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_patientId == null) {
      _patientId = UserSettings.of(context).patientId;
      // Reset the state in order to get the dosages of this month.
      // Ugly workaround, I know, but it should work for now.
      DateTime date = DateTime.now();
      selectedDate = DateTime(1980, 1, 1);
      onDateSelected(date);
    }
    return new Column(children: <Widget>[
      Calendar(isExpandable: true, onDateSelected: onDateSelected),
      Divider(color: CupertinoColors.lightBackgroundGray, height: 5.0),
      Expanded(
          child: ListView(
        children: todayDosageList.map((dosage) {
          return MedicationItem(
            dosage.medicineName,
            dosage.intakeMoment,
            dosage.amount
          );
        }).toList(),
        shrinkWrap: false,
        padding: EdgeInsets.zero,
      )),
    ], mainAxisSize: MainAxisSize.max);
  }
}
