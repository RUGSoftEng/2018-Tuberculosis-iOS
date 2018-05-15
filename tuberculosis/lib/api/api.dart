import 'package:Tubuddy/api/videos.dart';

export 'package:Tubuddy/api/videos.dart';

const API_URL = "http://37.97.185.127:10123/api";

class API {
  final Videos _videos;

  Videos get videos => _videos;

  API(String apiUrl) : _videos = Videos(apiUrl);

}

final api = API(API_URL);