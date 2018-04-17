import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class InformationTabPage extends StatelessWidget implements TabPage {
  static final Text title = const Text("Information");
  static final Icon icon = const Icon(CupertinoIcons.info);
  final _apiUrl =
    "http://192.168.50.4:2002/api"; // TODO change this to non-local server once it's up

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<String>>(
      future: _getTopics(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return new InfoEntryItem(new InfoEntry(snapshot.data[index]));
            },
            itemCount: snapshot.data.length,
          );
        }
        else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new Center(
          child: new CircularProgressIndicator()
        );
      },
    );
  }

  @override
  Text getTitle() {
    return title;
  }

  Future<List> _getTopics() async {
    final response = await http.get(_apiUrl + "/general/videos/topics");
    final responseJson = await json.decode(response.body);

    List<String> topics = [];
    for (String topic in responseJson) {
      topics.add(topic);
    }

    return topics;
  }
}

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

class Video {
  final String topic;
  final String title;
  final String reference;

  Video({this.topic, this.title, this.reference});

  factory Video.fromJson(Map<String, dynamic> json) {
    return new Video(
      topic: json['topic'],
      title: json['title'],
      reference: json['reference']
    );
  }
}

class VideoScreen extends StatelessWidget {
  const VideoScreen(this._topic);

  final String _topic;
  final _apiUrl =
      "http://192.168.50.4:2002/api"; // TODO change this to non-local server once it's up

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_topic),
      ),
      body: new FutureBuilder<List<Video>>(
        future: _getVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: snapshot.data.map((Video video) {
                return new GridTile(
                  child: new GestureDetector(
                    onTap: () => _openVideo(video.reference),
                    child: new Image.network("http://img.youtube.com/vi/" + getIdFromUrl(video.reference) + "/hqdefault.jpg",
                    fit: BoxFit.cover)
                  ),
                );
              }).toList()
            );
          }
          else if (snapshot.hasError) {
            return new Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return new Center(
            child: new CircularProgressIndicator(),
          );
        },
      )
    );
  }

  String getIdFromUrl(String url) {
    return url.substring(url.indexOf("?v=") + 3);
  }

  Future<List> _getVideos() async {
    final response = await http.get(_apiUrl + "/general/videos/topics/" + _topic);
    final responseJson = await json.decode(response.body);

    List<Video> videos = [];
    for (Map video in responseJson) {
      videos.add(new Video.fromJson(video));
    }

    return videos;
  }

  _openVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
