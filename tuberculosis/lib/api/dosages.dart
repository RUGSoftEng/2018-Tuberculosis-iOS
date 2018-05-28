import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:Tubuddy/tubuddy_strings.dart';

class Dosage extends StatelessWidget {
  static final formatter = new DateFormat('yyyy-MM-dd');

  final String intakeMoment;
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

  @override
  String toString({minLevel: DiagnosticLevel.info}) {
    return this.date.toString() + ' ' + medicineName;
  }

  factory Dosage.fromJson(Map<String, dynamic> json) {
    final durationParts = (json['dosage']['intake_moment'] as String).split(':').map((part) => int.parse(part)).toList(growable: false);
    final date = formatter.parse(json['date']);
    final dateWithTime = date.add(Duration(hours: durationParts[0], minutes: durationParts[1], seconds: durationParts[2]));
    return new Dosage(
        intakeMoment: json['dosage']['intake_moment'],
        amount: json['dosage']['amount'],
        medicineName: json['dosage']['medicine']['name'],
        date: dateWithTime,
        taken: json['taken']);
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: const Icon(Icons.healing),
        title: new Text(medicineName),
        subtitle: new Text(intakeMoment.toString() +
            " - " +
            amount.toString() +
            ' ' +
            TubuddyStrings.of(context).pillText(amount)));
  }
}

class Dosages {
  final String _apiUrl;
  final int _patientId;
  final String _token;
  final formatter = new DateFormat('yyyy-MM-dd');

  Dosages(this._apiUrl, this._patientId, this._token);

  Future<List<Dosage>> getDosages(DateTime from, DateTime until) async {
    final response = await http.get(
        "$_apiUrl/accounts/patients/$_patientId/dosages/scheduled?from=${formatter
            .format(from)}&until=${formatter.format(until)}", headers: {"access_token": _token});
    final responseJson = await json.decode(response.body);

    final dosages = List<Dosage>();
    for (Map dosage in responseJson) {
      dosages.add(new Dosage.fromJson(dosage));
    }

    print(dosages);

    return dosages;
  }
}
