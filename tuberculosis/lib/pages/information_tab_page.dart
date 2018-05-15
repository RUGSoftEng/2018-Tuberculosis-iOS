import 'package:Tubuddy/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Tubuddy/quiz/quiz.dart';

class InformationTabPage extends StatelessWidget implements TabPage {
  static final Text title = const Text("Information");
  static final Icon icon = const Icon(CupertinoIcons.info);

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<String>>(
      future: api.videos.getTopics(),
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
          Navigator.push(
              context,
              new CupertinoPageRoute(
                  builder: (context) => VideoSelectorScreen(infoEntry.topic)));
        });
  }
}

class VideoSelectorScreen extends StatelessWidget {
  const VideoSelectorScreen(this._topic);

  final String _topic;

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
        navigationBar: new CupertinoNavigationBar(
        middle: new Text(_topic),
      ),
      child: new FutureBuilder<List<Video>>(
        future: api.videos.getVideos(_topic),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Material(child: ListView(children: snapshot.data.map((v) => ListTile(
              title: Text(v.title),
              onTap: () => Navigator.push(
                  context,
                  new CupertinoPageRoute(
                      builder: (context) => VideoScreen(v)
                  )
              ),
            )).toList(),));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(child: new CircularProgressIndicator(),);
          }
        }
      )
    );
  }
}

class VideoScreen extends StatelessWidget {
  const VideoScreen(this._video);

  final Video _video;

  @override
  Widget build(BuildContext context) {
    List<String> sampleData = <String>[
      "https://www.youtube.com/watch?v=yR51KVF4OX0",
      "https://www.youtube.com/watch?v=yR51KVF4OX0"
    ];
    List<Question> questions = <Question>[
      const Question("Hoi"),
      const Question("Vraag 2"),
      new Question("ASdadasda", answers: ["asdsadsadasadsasaasdas", "bgbgbgbgbgbg", "cdiasdihsjsdjfhskjfhskdfhkshjkjkhksfdhjkh"], correctAnswer: 2)
    ];
    return new CupertinoPageScaffold(
        navigationBar: new CupertinoNavigationBar(
          middle: new Text(_video.title),
        ),
        child: new Material(
            child: new SafeArea(
                child: new Column(
                  children: [
                    new GestureDetector(
                      onTap: () => _openVideo(sampleData[0]),
                      child: new Image.network(
                          "http://img.youtube.com/vi/" +
                              getIdFromUrl(sampleData[0]) +
                              "/hqdefault.jpg",
                          fit: BoxFit.cover),
                    ),
                    new QuizWidget(questions)
                  ],
                ))));
//    return new CupertinoPageScaffold(
//      navigationBar: CupertinoNavigationBar(
//        middle: Text(_video.title)
//      ),
//      child: GestureDetector(
//        child: new Image.network("http://img.youtube.com/vi/" + getIdFromUrl(_video.reference) + "/hqdefault.jpg"),
//        onTap: () => _openVideo(_video.reference),
//      )
//    );
  }

  String getIdFromUrl(String url) {
    return url.substring(url.indexOf("?v=") + 3);
  }

  _openVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
