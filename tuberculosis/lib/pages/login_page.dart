import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<bool> _userLoggedIn;

  LoginPage(this._userLoggedIn);

  @override
  LoginPageState createState() => new LoginPageState(_userLoggedIn);
}

class LoginPageState extends State<LoginPage> {
  final ValueChanged<bool> _userLoggedIn;
  final formKey = new GlobalKey<FormState>();
  String _username, _password;

  LoginPageState(this._userLoggedIn);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new CupertinoPageScaffold(
            navigationBar: new CupertinoNavigationBar(
                middle: const Text("Welcome to Tubuddy!")),
            child: new Scaffold(
                body: new DefaultTextStyle(
                    style: const TextStyle(
                      fontFamily: '.SF UI Text',
                      fontSize: 17.0,
                      color: CupertinoColors.black,
                    ),
                    child: new Padding(
                        padding: new EdgeInsets.all(30.0),
                        child: new Container(
                            child: new Center(child: _loginWidget())))))));
  }

  Widget _loginWidget() {
    final loginForm = new Form(
        key: formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
                title: new TextFormField(
              decoration: new InputDecoration(labelText: "Username"),
              validator: (val) =>
                  val.isEmpty ? "Please enter a username." : null,
              onSaved: (val) => _username = val,
              autocorrect: false,
            )),
            new ListTile(
                title: new TextFormField(
              decoration: new InputDecoration(labelText: "Password"),
              validator: (val) => val.length < 6 ? "Password too short." : null,
              onSaved: (val) => _password = val,
              obscureText: true,
            )),
            new ListTile(
                title: new RaisedButton(
                    onPressed: _processForm, child: new Text("Log In")))
          ],
        ));
    return loginForm;
  }

  void _processForm() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _handleLogIn();
    }
  }

  void _handleLogIn() {
    // TODO: handle logging in.
    _userLoggedIn(true);
  }
}
