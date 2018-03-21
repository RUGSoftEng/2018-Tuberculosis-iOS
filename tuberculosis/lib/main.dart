import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: 4,
        child: new Scaffold(
          appBar: new AppBar(
            bottom: new TabBar(
              tabs: [
                new Tab(
                    icon: new Image(
                        image: new AssetImage("graphics/ic_calendar.png"),
                        width: 35.0,
                        height: 35.0)),
                new Tab(
                    icon: new Image(
                        image: new AssetImage("graphics/ic_medication.png"),
                        width: 35.0,
                        height: 35.0)),
                new Tab(
                    icon: new Image(
                        image: new AssetImage("graphics/ic_information.png"),
                        width: 35.0,
                        height: 35.0)),
                new Tab(
                    icon: new Image(
                        image: new AssetImage("graphics/ic_notes.png"), width: 35.0, height: 35.0))
              ],
            ),
            title: new Text('Tubuddy'),
          ),
          body: new TabBarView(
            children: [
              new Icon(Icons.directions_transit),
              new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return new MedicationItem(dummyData[index].medicationName,
                      dummyData[index].recommendedTime, dummyData[index].recommendedDosage);
                },
                itemCount: 2,
              ),
              new Icon(Icons.directions_bike),
              new Icon(Icons.directions_run),
            ],
          ),
        ),
      ),
    );
  }
}

final List<MedicationItem> dummyData = <MedicationItem>[
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
        subtitle: recommendedDosage > 1
            ? new Text(recommendedTime + " - " + recommendedDosage.toString() + " pills")
            : new Text(recommendedTime + " - " + recommendedDosage.toString() + " pill"));
  }
}
