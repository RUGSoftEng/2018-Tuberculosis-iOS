import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: 3,
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
                        image: new AssetImage("graphics/ic_notes.png"),
                        width: 35.0,
                        height: 35.0))
              ],
            ),
            title: new Text('Tubuddy'),
          ),
          body: new TabBarView(
            children: [
              new Icon(Icons.directions_car),
              new Icon(Icons.directions_transit),
              new Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
