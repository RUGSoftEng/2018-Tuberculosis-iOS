import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationTabPage extends StatelessWidget implements TabPage {
  static final Text title = const Text("Information");
  static final Icon icon = const Icon(CupertinoIcons.info);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return new InfoEntryItem(dummyInfo[index]);
        },
        itemCount: 4);
  }

  @override
  Text getTitle() {
    return title;
  }
}

final List<InfoEntry> dummyInfo = <InfoEntry>[
  new InfoEntry("General information"),
  new InfoEntry("Symptoms"),
  new InfoEntry("Treatment"),
  new InfoEntry("Other")
];

class InfoEntry {
  InfoEntry(this.topic);
  final String topic;
}

class InfoEntryItem extends StatelessWidget {
  const InfoEntryItem(this.infoEntry);

  final InfoEntry infoEntry;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        title: new Text(infoEntry.topic),
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new VideoScreen(infoEntry.topic)));
        });
  }
}

class VideoScreen extends StatelessWidget {
  const VideoScreen(this._topic);

  final String _topic;
  final _apiUrl =
      "http://192.168.50.4:2002/api"; // TODO change this to non-local server once it's up

  @override
  Widget build(BuildContext context) {
    List<String> sampleData = <String>[
      "https://www.youtube.com/watch?v=yR51KVF4OX0",
      "https://www.youtube.com/watch?v=yR51KVF4OX0"
    ];
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(_topic),
        ),
        body: new GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20.0),
            crossAxisSpacing: 10.0,
            crossAxisCount: 2,
            children: sampleData.map((String url) {
              return new GridTile(
                  child: new GestureDetector(
                      onTap: () => _openVideo(url),
                      child: new Image.network(
                          "http://img.youtube.com/vi/" + getIdFromUrl(url) + "/hqdefault.jpg",
                          fit: BoxFit.cover)));
            }).toList()));
  }

  String getIdFromUrl(String url) {
    return url.substring(url.lastIndexOf("=") + 1);
  }

  void _showSnackbar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(message)));
  }

  _openVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
