import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatelessWidget {
  final List<String> languages = [
    'Deutsch',
    'English',
    'Nederlands',
    'Românesc'
  ];
  final VoidCallback onLogOut;

  SettingsPage(this.onLogOut);

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
        navigationBar: new CupertinoNavigationBar(
          middle: new Text("Settings"),
        ),
        backgroundColor: Color(0xFFEEEEF3),
        child: new CupertinoSettings(<Widget>[
          new CSHeader('Language'),
          new CSSelection(languages, (index) {
            print("Selected " + languages[index]);
          }),
          new CSButton(CSButtonType.DESTRUCTIVE, "Log out", onLogOut),
        ]));
  }
}
