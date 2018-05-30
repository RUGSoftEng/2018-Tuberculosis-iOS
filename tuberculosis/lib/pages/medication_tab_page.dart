import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';

class MedicationTabPage extends StatelessWidget implements TabPage {
  static final Icon icon = const Icon(CupertinoIcons.book);

  static String getTitleStatic(BuildContext context) {
    return TubuddyStrings.of(context).medicationTitle;
  }

  final List<MedicationItem> pills;

  MedicationTabPage(this.pills);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return pills[index];
        },
        itemCount: pills.length);
  }

  @override
  Text getTitle(BuildContext context) {
    return Text(MedicationTabPage.getTitleStatic(context));
  }
}

final List<MedicationItem> dummyMedicationData = <MedicationItem>[
  new MedicationItem("Loratidine", "Any Time", 1, true, false),
  new MedicationItem("Differin", "Any Time", 1, true, false)
];

class MedicationItem extends StatelessWidget {
  MedicationItem(this.medicationName, this.recommendedTime,
      this.recommendedDosage, this.taken, this.afterToday);

  final String medicationName;
  final String recommendedTime;
  final int recommendedDosage;
  final bool taken;
  final bool afterToday;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: new Icon(Icons.healing,
            color: (afterToday
                ? CupertinoColors.inactiveGray
                : (taken
                    ? CupertinoColors.activeGreen
                    : CupertinoColors.destructiveRed))),
        title: new Text(this.medicationName),
        subtitle: new Text(
          recommendedTime +
              " - " +
              recommendedDosage.toString() +
              ' ' +
              TubuddyStrings.of(context).pillText(recommendedDosage),
        ),
        enabled: !afterToday);
  }
}
