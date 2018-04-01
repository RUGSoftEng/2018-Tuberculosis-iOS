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
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;

  LoginPageState(this._userLoggedIn);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new CupertinoPageScaffold(
            navigationBar: new CupertinoNavigationBar(
                middle: const Text("Welcome to Tubuddy!")),
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
                            child: new Center(child: _loginWidget())))))));
  }

  Widget _loginWidget() {
    final loginForm = new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset('graphics/logo.png', scale: 0.5),
            new TextFormField(
              decoration: new InputDecoration(
                  hintText: "Username",
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(32.0))),
              validator: _validateUsername,
              onSaved: (val) => _username = val,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
            ),
            const SizedBox(height: 12.0),
            new TextFormField(
              decoration: new InputDecoration(
                  hintText: "Password",
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(32.0))),
              validator: _validatePassword,
              onSaved: (val) => _password = val,
              obscureText: true,
            ),
            const SizedBox(height: 6.0),
            new Padding(
                padding: new EdgeInsets.only(top: 16.0),
                child: new Material(
                    borderRadius: new BorderRadius.circular(30.0),
                    shadowColor: Colors.lightBlueAccent.shade100,
                    elevation: 5.0,
                    child: new MaterialButton(
                      onPressed: _processForm,
                      child: new Text(
                        "Log In",
                        style: const TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightBlueAccent,
                    ))),
            const SizedBox(height: 12.0),
            new FlatButton(
              child: const Text(
                'Forgot password?',
                style: const TextStyle(color: Colors.black54),
              ),
              onPressed: () =>
                  null, // TODO: implement forgotten password function.
            )
          ],
        ));
    return loginForm;
  }

  String _validatePassword(String val) {
    if (val.isEmpty) return "Please enter a password.";
    return null;
  }

  String _validateUsername(String val) {
    if (val.isEmpty) return "Please enter a username.";
    return null;
  }

  void _showInSnackbar(String val) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(val)));
  }

  void _processForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _handleLogIn();
    }
  }

  void _handleLogIn() {
    // TODO: handle logging in.
    if (_username == "demo" && _password == "demo123") {
      _userLoggedIn(true);
    } else {
      _showInSnackbar("Username or password incorrect.");
    }
  }
}
