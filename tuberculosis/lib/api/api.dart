import 'package:Tubuddy/api/faq.dart';
import 'package:Tubuddy/api/login.dart';
import 'package:Tubuddy/api/videos.dart';

export 'package:Tubuddy/api/login.dart';
export 'package:Tubuddy/api/videos.dart';

const API_URL = "http://37.97.185.127:10123/api";

class API {
  final Videos _videos;
  final Login _login;
  final FAQ _faq;

  Videos get videos => _videos;
  Login get login => _login;
  FAQ get faq => _faq;

  API(String apiUrl, String lang) : _videos = Videos(apiUrl, lang), _login = Login(apiUrl), _faq = FAQ(apiUrl, lang);

}

var api;

void initializeApi(String lang) {
  if (lang == null) lang = '';
  api = API(API_URL, lang.toUpperCase());
}