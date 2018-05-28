import 'package:Tubuddy/api/api.dart';
import 'package:Tubuddy/api/fetch_data_widget.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Tubuddy/quiz/quiz.dart';

class InformationTabPage extends StatelessWidget implements TabPage {
  static final Icon icon = const Icon(CupertinoIcons.info);

  static String getTitleStatic(BuildContext context) {
    return TubuddyStrings.of(context).informationTitle;
  }

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
  Text getTitle(BuildContext context) {
    return Text(InformationTabPage.getTitleStatic(context));
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
    List<Widget> children = List<Widget>();

    children.add(new GestureDetector(
      onTap: () => _openVideo(_video.reference),
      child: new Image.network(
          "http://img.youtube.com/vi/" +
              getIdFromUrl(_video.reference) +
              "/hqdefault.jpg",
          fit: BoxFit.cover),
    ));

    if (_video.quiz != null) {
      children.add(new QuizWidget(_video.quiz.questions));
    }

    return new CupertinoPageScaffold(
        navigationBar: new CupertinoNavigationBar(
          middle: new Text(_video.title),
        ),
        child: new Material(
            child: new SafeArea(
                child: new Column(
                  children: children,
                ))));
  }

  String getIdFromUrl(String url) {
    if (url.startsWith('https://')) {
      url = url.substring('https://'.length);
    }
    if (url.startsWith('http://')) {
      url = url.substring('http://'.length);
    }
    if (url.startsWith('www.')) {
      url = url.substring('www.'.length);
    }
    if (url.startsWith('youtu.be')) {
      int end = url.indexOf('&');
      if (end == -1) {
        end = url.length;
      }
      return url.substring(url.indexOf('/') + 1, end);
    } else {
      int start = url.indexOf("v=") + 2;
      int end = url.indexOf('&', start);
      if (end == -1) {
        end = url.length;
      }
      return url.substring(start, end);
    }
  }

  _openVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
