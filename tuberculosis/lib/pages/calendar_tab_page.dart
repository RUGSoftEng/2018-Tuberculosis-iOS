import 'dart:math';

import 'package:Tubuddy/api/api.dart';
import 'package:Tubuddy/calendar/calendar.dart';
import 'package:Tubuddy/translated_app.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';
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
        return dosage.date.day == selectedDate.day &&
            dosage.date.month == selectedDate.month;
      }));
    }
  }

  _CalendarTabPageState()
      : monthDosageList = List<Dosage>(),
        todayDosageList = List<Dosage>() {
    onDateSelected = (DateTime date) {
      DateTime today = DateTime.now();
      if (selectedDate.month != date.month || selectedDate.year != date.year) {
        api.dosages
            .getDosages(DateTime(today.year, today.month, 1),
                DateTime(today.year, date.month + 1, 1))
            .then((dosages) {
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
    final DateTime today = DateTime.now();
    if (_patientId == null) {
      _patientId = UserSettings.of(context).patientId;
      // Reset the state in order to get the dosages of this month (uninitialized at this point).
      // Ugly workaround, I know, but it should work for now.
      selectedDate = DateTime(1980, 1, 1);
      onDateSelected(today);
    }
    return Scaffold(
        body: new Column(children: <Widget>[
      Calendar(isExpandable: true, onDateSelected: onDateSelected),
      Divider(color: CupertinoColors.lightBackgroundGray, height: 5.0),
      Expanded(
          child: ListView(
        children: todayDosageList.map((dosage) {
          return DosageItem(
            dosage,
            onError: (context) => Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: Text('Error while connecting to server. Please try again.'))),
            onSuccess: (updatedDosage) {
              setState(() {
                int dosageIndex = monthDosageList.indexOf(dosage);
                monthDosageList.replaceRange(
                    dosageIndex, dosageIndex + 1, [updatedDosage]);
              });
              _updateDosagesForSelectedDate();
            },
          );
        }).toList(),
        shrinkWrap: false,
        padding: EdgeInsets.zero,
      )),
    ], mainAxisSize: MainAxisSize.max));
  }
}

class DosageItem extends StatelessWidget {
  final Dosage dosage;
  final ValueChanged<BuildContext> onError;
  final ValueChanged<Dosage> onSuccess;

  DosageItem(this.dosage, {this.onError, this.onSuccess});

  void _setDosageTaken(BuildContext context, bool taken) async {
    Dosage updatedDosage = new Dosage.fromDosage(dosage, taken);
    bool success = await api.dosages.updateDosageTaken(updatedDosage);
    if (!success) {
      if (onError != null) onError(context);
    } else {
      if (onSuccess != null) onSuccess(updatedDosage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final afterToday = dosage.date.isAfter(today);

    return new ListTile(
        leading: DosageIcon(dosage: dosage),
        title: new Text(dosage.medicineName),
        subtitle: new Text(
          dosage.intakeMoment +
              " - " +
              dosage.amount.toString() +
              ' ' +
              TubuddyStrings.of(context).pillText(dosage.amount),
        ),
        enabled: !afterToday,
        trailing: afterToday
            ? null
            : DosageToggle(
                onToggle: ((bool taken) => _setDosageTaken(context, taken)),
                enabled: dosage.taken,
              ));
  }
}

class DosageIcon extends StatefulWidget {
  final Dosage dosage;

  const DosageIcon({Key key, this.dosage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DosageIcon();
}

class _DosageIcon extends State<DosageIcon>
    with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  Animation<double> rotateAnimation;
  AnimationController controller;
  bool taken;

  initState() {
    super.initState();
    controller = new AnimationController(
      vsync: this,
    );

    taken = widget.dosage.taken;
    startAnimation(const Duration(milliseconds: 0));
  }

  startAnimation(Duration duration) {
    animation = new ColorTween(
            begin: widget.dosage.taken
                ? CupertinoColors.destructiveRed
                : CupertinoColors.activeGreen,
            end: widget.dosage.taken
                ? CupertinoColors.activeGreen
                : CupertinoColors.destructiveRed)
        .animate(controller)
          ..addListener(() => setState(() {}));

    rotateAnimation = new Tween(
            begin: widget.dosage.taken ? 0.0 : pi,
            end: (widget.dosage.taken ? 1 : 2) * pi)
        .animate(controller);

    controller.duration = duration;
    controller.reset();
    controller.forward();
  }

  Widget build(BuildContext context) {
    final today = DateTime.now();
    if (widget.dosage.date.isAfter(today)) {
      return Icon(Icons.healing, color: CupertinoColors.inactiveGray);
    }

    if (taken != widget.dosage.taken) {
      taken = widget.dosage.taken;
      startAnimation(const Duration(milliseconds: 350));
    }

    return Transform(
      child: Icon(Icons.healing, color: animation.value),
      alignment: Alignment.center,
      transform: new Matrix4.rotationY(rotateAnimation.value)
        ..rotateX(rotateAnimation.value)
        ..rotateZ(rotateAnimation.value),
    );
  }
}

class DosageToggle extends StatelessWidget {
  final ValueChanged<bool> onToggle;
  final bool enabled;

  DosageToggle({this.onToggle, this.enabled});

  @override
  Widget build(BuildContext context) {
    return new Checkbox(value: enabled, onChanged: onToggle);
  }
}
