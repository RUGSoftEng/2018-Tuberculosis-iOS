import 'package:Tubuddy/api/api.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  final ValueChanged<String> _userLoggedIn;

  LoginPage(this._userLoggedIn);

  @override
  LoginPageState createState() => new LoginPageState(_userLoggedIn);
}

class LoginPageState extends State<LoginPage> {
  final ValueChanged<String> _userLoggedIn;
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;
  bool _logInButtonDisabled = false;

  LoginPageState(this._userLoggedIn);

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
            navigationBar: new CupertinoNavigationBar(
                middle: Text(TubuddyStrings.of(context).welcomeText)),
            child: new Scaffold(
                key: _scaffoldKey,
                body: new DefaultTextStyle(
                    style: const TextStyle(
                      fontFamily: '.SF UI Text',
                      fontSize: 17.0,
                      color: CupertinoColors.black,
                    ),
                    child: new Padding(
                        padding: new EdgeInsets.all(30.0),
                        child: new Container(
                            child: new Center(child: _loginWidget()))))));
  }

  void _showInSnackbar(String val) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(val)));
  }

  Widget _loginWidget() {
    final logo = new Image.asset('graphics/logo.png', height: 200.0);

    final usernameField = new TextFormField(
      decoration: new InputDecoration(
          hintText: TubuddyStrings.of(context).username,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(32.0))),
      validator: _validateUsername,
      onSaved: (val) => _username = val,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
    );

    final passwordField = new TextFormField(
      decoration: new InputDecoration(
          hintText: TubuddyStrings.of(context).password,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(32.0))),
      validator: _validatePassword,
      onSaved: (val) => _password = val,
      obscureText: true,
    );

    final loginButton = new CupertinoButton(
        onPressed: _logInButtonDisabled ? null : _processForm,
        child: new Text(_logInButtonDisabled ? TubuddyStrings.of(context).loginBtnInProgressText : TubuddyStrings.of(context).loginBtnText));

    final forgottenPasswordButton = new CupertinoButton(
        child: Text(
          TubuddyStrings.of(context).forgotPasswordBtnText,
          style: const TextStyle(color: Colors.black45),
        ),
        onPressed: () => _showInSnackbar(
            "Implementation needed.") // TODO: implement forgotten password function.
        );

    final loginForm = new Form(
        key: _formKey,
        child: new ListView(
          children: <Widget>[
            logo,
            usernameField,
            const SizedBox(height: 12.0),
            passwordField,
            const SizedBox(height: 6.0),
            loginButton,
            forgottenPasswordButton
          ],
        ));
    return loginForm;
  }

  String _validatePassword(String val) {
    if (val.isEmpty) return TubuddyStrings.of(context).loginMissingPassword;
    return null;
  }

  String _validateUsername(String val) {
    if (val.isEmpty) return TubuddyStrings.of(context).loginMissingUsername;
    return null;
  }

  void _processForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _handleLogin();
    }
  }

  void _handleLogin() async {
    setState(() => _logInButtonDisabled = true);
    if (_username == "demo" && _password == "demo123") {
      _userLoggedIn("");
    } else {
      final loginResult = await api.login.doLogin(_username, _password);
      if (loginResult.success) {
        _userLoggedIn(loginResult.result.token);
      } else {
        _showLogInError(TubuddyStrings.of(context).loginIncorrectCredentials);
      }
//      http
//          .post(_apiUrl + "/accounts/login",
//              body: json.encode({"username": _username, "password": _password}))
//          .timeout(const Duration(seconds: 5))
//          .then((response) {
//        if (response.statusCode == HttpStatus.OK) {
//          // TODO store received API token somewhere, add blocking spinner.
//          _userLoggedIn(true);
//        } else {
//          _showLogInError("Username or password incorrect.");
//        }
//      }).catchError(
//              (e) => _showLogInError("Error: could not connect to server."));
    }
  }

  void _showLogInError(String val) {
    _showInSnackbar(val);
    setState(() => _logInButtonDisabled = false);
  }
}
