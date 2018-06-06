import 'dart:async';
import 'dart:convert';
import 'package:Tubuddy/quiz/question.dart';
import 'package:http/http.dart' as http;

class Quiz {
  final List<Question> questions;

  Quiz({this.questions});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    var questions = new List<Question>();

    if (json.containsKey('quizzes') && json['quizzes'] != null) {
      json['quizzes'].forEach((q) {
        var answers = List<String>();
        q['answers'].forEach((d) => answers.add(d as String));
        final newQuestion = Question(
            q['question'],
            answers: answers
        );
        questions.add(newQuestion);
      });

      return Quiz(
          questions: questions
      );
    } else {
      return null;
    }
  }
}

class Video {
  final String topic;
  final String title;
  final String reference;
  final Quiz quiz;

  Video({this.topic, this.title, this.reference, this.quiz});

  factory Video.fromJson(Map<String, dynamic> json) {
    return new Video(
        topic: json['video']['topic'],
        title: json['video']['title'],
        reference: json['video']['reference'],
        quiz: Quiz.fromJson(json)
    );
  }
}

class Videos {

  final String _apiUrl;
  final String _lang;

  Videos(this._apiUrl, this._lang);

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