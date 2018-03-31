import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  static _LoginPageState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LoginPageState>());

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loggedIn;

  bool get isLoggedIn => _loggedIn;

  @override
  Widget build(BuildContext context) {
    // TODO: implement something such that this is only shown when a user is not logged in.
    return new CupertinoPageScaffold(
        navigationBar: new CupertinoNavigationBar(
            middle: const Text("Welcome to Tubuddy!")),
        child: new Scaffold(body: null));
  }
}
