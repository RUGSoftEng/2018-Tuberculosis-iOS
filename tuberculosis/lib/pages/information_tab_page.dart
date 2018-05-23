import 'package:Tubuddy/api/api.dart';
import 'package:Tubuddy/api/fetch_data_widget.dart';
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
    return FetchDataWidget(
      getFutureFunction: api.videos.getTopics,
      builder: (context, data) {
        return new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return new InfoEntryItem(new InfoEntry(data[index]));
          },
          itemCount: data.length,
        );
      }
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
      child: FetchDataWidget<List<Video>>(
        getFutureFunction: () => api.videos.getVideos(_topic),
        builder: (context, data) {
          return Material(child: ListView(children: data.map((v) => ListTile(
            title: Text(v.title),
            onTap: () => Navigator.push(
                context,
                new CupertinoPageRoute(
                    builder: (context) => VideoScreen(v)
                )
            ),
          )).toList(),));
        },
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
                      onTap: () => _openVideo(_video.reference),
                      child: new Image.network(
                          "http://img.youtube.com/vi/" +
                              getIdFromUrl(_video.reference) +
                              "/hqdefault.jpg",
                          fit: BoxFit.cover),
                    ),
                    new QuizWidget(questions)
                  ],
                ))));
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
