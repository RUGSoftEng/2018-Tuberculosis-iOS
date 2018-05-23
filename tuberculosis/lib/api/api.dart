import 'package:Tubuddy/api/login.dart';
import 'package:Tubuddy/api/videos.dart';

export 'package:Tubuddy/api/login.dart';
export 'package:Tubuddy/api/videos.dart';

const API_URL = "http://37.97.185.127:10123/api";

class API {
  final Videos _videos;
  final Login _login;

  Videos get videos => _videos;
  Login get login => _login;

  API(String apiUrl) : _videos = Videos(apiUrl), _login = Login(apiUrl);

}

final api = API(API_URL);