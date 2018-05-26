import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Dosage {
  final DateTime intakeMoment;
  final int amount;
  final String medicineName;
  final DateTime date;
  final bool taken;

  Dosage(
      {this.intakeMoment,
      this.amount,
      this.medicineName,
      this.date,
      this.taken});

  factory Dosage.fromJson(Map<String, dynamic> json) {
    return new Dosage(
        intakeMoment: DateTime.parse(json['intake_moment']),
        amount: json['amount'],
        medicineName: json['medicine']['name'],
        date: json['date'],
        taken: json['taken']);
  }
}

class Dosages {
  final String _apiUrl;
  final int _patientId;
  final formatter = new DateFormat('yyyy-MM-dd');

  Dosages(this._apiUrl, this._patientId);

  Future<List<Dosage>> getDosages(DateTime from, DateTime until) async {
    final response = await http.get(
        "$_apiUrl/accounts/patients/$_patientId/dosages/scheduled?from=${formatter
            .format(from)}&until=${formatter.format(until)}");
    final responseJson = await json.decode(response.body);

    List<Dosage> dosages;
    for (Map dosage in responseJson) {
      dosages.add(new Dosage.fromJson(dosage));
    }
    return dosages;
  }
}
