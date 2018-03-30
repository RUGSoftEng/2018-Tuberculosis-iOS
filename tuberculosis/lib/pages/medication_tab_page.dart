import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';

class MedicationTabPage extends StatelessWidget implements TabPage {
  static final Text title = const Text("Medication");
  static final Icon icon = const Icon(CupertinoIcons.book);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return dummyMedicationData[index];
        },
        itemCount: 2);
  }

  @override
  Text getTitle() {
    return title;
  }
}

final List<MedicationItem> dummyMedicationData = <MedicationItem>[
  new MedicationItem("Loratidine", "Any Time", 1),
  new MedicationItem("Differin", "Any Time", 2),
];

class MedicationItem extends StatelessWidget {
  MedicationItem(this.medicationName, this.recommendedTime, this.recommendedDosage);

  final String medicationName;
  final String recommendedTime;
  final int recommendedDosage;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: const Icon(Icons.healing),
        title: new Text(this.medicationName),
        subtitle: recommendedDosage != 1
            ? new Text(recommendedTime + " - " + recommendedDosage.toString() + " pills")
            : new Text(recommendedTime + " - " + recommendedDosage.toString() + " pill"));
  }
}
