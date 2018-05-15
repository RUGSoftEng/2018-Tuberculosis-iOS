// import 'dart:_http';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:Tubuddy/api/api_result.dart';
import 'package:http/http.dart' as http;

class LoggedInUser {
  final int id;
  final String token;

  LoggedInUser(this.id, this.token);

  factory LoggedInUser.fromJson(Map<String, dynamic> json) {
    return new LoggedInUser(
      json['id'],
      json['token'],
    );
  }
}

class Login {

  final String _apiUrl;

  Login(this._apiUrl);

  Future<ApiResult> doLogin(String username, String password) async {
    return http.post(_apiUrl + "/accounts/login", body: json.encode({
      "username": username,
      "password": password
    })).then((response) async {
      if (response.statusCode == HttpStatus.OK) {
        final responseJson = await json.decode(response.body);
        return ApiResult(LoggedInUser.fromJson(responseJson), null);
      }
      return ApiResult(null, response.body);
    });
  }
}