import 'package:Tubuddy/api/dosages.dart';
import 'package:Tubuddy/api/faq.dart';
import 'package:Tubuddy/api/login.dart';
import 'package:Tubuddy/api/notes.dart';
import 'package:Tubuddy/api/videos.dart';

export 'package:Tubuddy/api/login.dart';
export 'package:Tubuddy/api/videos.dart';

const API_URL = "http://37.97.185.127:10123/api";

class API {
  final Videos _videos;
  final Login _login;
  final Dosages _dosages;
  final FAQ _faq;
  final Notes _notes;

  Videos get videos => _videos;
  Login get login => _login;
  FAQ get faq => _faq;
  Dosages get dosages => _dosages;
  Notes get notes => _notes;

  final String lang;

  API(String apiUrl, this.lang, int patientId, String token)
      : _videos = Videos(apiUrl, lang),
        _login = Login(apiUrl),
        _dosages = Dosages(apiUrl, patientId, token),
        _faq = FAQ(apiUrl, lang),
        _notes = Notes(apiUrl, patientId, token);
}

API api;

void initializeApi(String lang, int patientId, String token) {
  if (lang == null) {
    lang = '';
  }
  api = API(API_URL, lang.toUpperCase(), patientId, token);
}