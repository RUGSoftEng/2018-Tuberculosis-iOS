import 'dart:io';
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
  final DateTime takeBeforeDate;
  final bool taken;

  Dosage(
      {this.intakeMoment,
      this.amount,
      this.medicineName,
      this.date,
      this.takeBeforeDate,
      this.taken});

  @override
  String toString({minLevel: DiagnosticLevel.info}) {
    return this.date.toString() + ' ' + medicineName;
  }

  factory Dosage.fromJson(Map<String, dynamic> json) {
    final durationPartsStart = (json['dosage']['intake_interval_start'] as String)
        .split(':')
        .map((part) => int.parse(part))
        .toList(growable: false);
    final durationPartsEnd = (json['dosage']['intake_interval_end'] as String)
        .split(':')
        .map((part) => int.parse(part))
        .toList(growable: false);
    final date = formatter.parse(json['date']);
    final dateWithTime = date.add(Duration(
        hours: durationPartsStart[0],
        minutes: durationPartsStart[1],
        seconds: durationPartsStart[2]));
    final dateTakeBefore = date.add(Duration(
      hours: durationPartsEnd[0],
      minutes: durationPartsEnd[1],
      seconds: durationPartsEnd[2],
    ));
    return new Dosage(
        intakeMoment: json['dosage']['intake_interval_start'],
        amount: json['dosage']['amount'],
        medicineName: json['dosage']['medicine']['name'],
        date: dateWithTime,
        takeBeforeDate: dateTakeBefore,
        taken: json['taken']);
  }

  factory Dosage.fromDosage(Dosage dosage, bool taken) {
    return new Dosage(
        intakeMoment: dosage.intakeMoment,
        amount: dosage.amount,
        medicineName: dosage.medicineName,
        date: dosage.date,
        taken: taken);
  }

  Map toJson() {
    return {
      "intake_moment": intakeMoment,
      "amount": amount,
      "medicine": {"name": medicineName}
    };
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
            .format(from)}&until=${formatter.format(until)}",
        headers: {"access_token": _token});
    final responseJson = await json.decode(response.body);

    final dosages = List<Dosage>();
    for (Map dosage in responseJson) {
      dosages.add(new Dosage.fromJson(dosage));
    }

    return dosages;
  }

  Future<bool> updateDosageTaken(Dosage dosage) async {
    bool catastrophicFailure = false;
    final response = await http.post(
        "$_apiUrl/accounts/patients/$_patientId/dosages/scheduled",
        headers: {"access_token": _token, "Content-Type": "application/json"},
        body: json.encode([{
          "dosage": dosage.toJson(),
          "date": formatter.format(dosage.date),
          "taken": dosage.taken
        }])).catchError((e) {
      catastrophicFailure = true;
    });

    if (catastrophicFailure) return false;

    return (response.statusCode == HttpStatus.OK);
  }
}
