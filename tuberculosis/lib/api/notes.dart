import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class Notes {
  final String _apiUrl;

  final int _patientId;
  final String _token;

  Notes(this._apiUrl, this._patientId, this._token);

  void addNote(String note) {
    http.put(_apiUrl + "/accounts/patients/$_patientId/notes", body: json.encode(
      {
        'note': note,
        'created_at': (DateFormat('yyyy-MM-dd').format(DateTime.now()))
      }
    ), headers: {
      'access-token': _token
    });
  }
}