import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FAQEntry {
  FAQEntry(this.question, this.answer);

  final String question;
  final String answer;

  factory FAQEntry.fromJson(Map<String, dynamic> json) {
    return FAQEntry(json['question'], json['answer']);
  }
}

class FAQ {
  final String _apiUrl;
  final String _lang;

  FAQ(this._apiUrl, this._lang);

  Future<List<FAQEntry>> getEntries() async {
    final response = await http.get(_apiUrl + "/general/faq?language=$_lang");
    final responseJson = await json.decode(response.body);

    List<FAQEntry> entries = [];
    for (Map<String, dynamic> e in responseJson) {
      entries.add(FAQEntry.fromJson(e));
    }

    return entries;
  }
}