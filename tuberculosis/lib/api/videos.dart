import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

class Videos {

  final String _apiUrl;

  Videos(this._apiUrl);

  Future<List<String>> getTopics() async {
    final response = await http.get(_apiUrl + "/general/videos/topics");
    final responseJson = await json.decode(response.body);

    List<String> topics = [];
    for (String topic in responseJson) {
      topics.add(topic);
    }

    return topics;
  }

  Future<List<Video>> getVideos(String topic) async {
    final response = await http.get(_apiUrl + "/general/videos/topics/" + topic);
    final responseJson = await json.decode(response.body);

    List<Video> videos = [];
    for (Map video in responseJson) {
      videos.add(new Video.fromJson(video));
    }

    return videos;
  }

}