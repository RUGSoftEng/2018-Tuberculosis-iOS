import 'package:Tubuddy/translated_app.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
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

  final Map<String, String> languageCodes = {
    'English': 'en',
    'Deutsch': 'de',
    'Nederlands': 'nl',
    'Românesc': 'ro'
  };

  final VoidCallback onLogOut;

  SettingsPage(this.onLogOut);

  @override
  Widget build(BuildContext context) {
    String languageCode = UserSettings.of(context).userLanguage;
    if (languageCode == '') {
      languageCode = Localizations.localeOf(context).languageCode;
      if (!languageCodes.containsValue(languageCode)) {
        languageCode = 'en';
      }
    }

    int selectedItem = 1;
    int i = 0;
    languages.forEach((str) {
      if (languageCodes[str] == languageCode) {
        selectedItem = i;
      }
      i++;
    });

    return new CupertinoPageScaffold(
        navigationBar: new CupertinoNavigationBar(
          middle: new Text(TubuddyStrings.of(context).settings),
        ),
        backgroundColor: Color(0xFFEEEEF3),
        child: new CupertinoSettings(<Widget>[
          new CSHeader(TubuddyStrings.of(context).language),
          new CSSelection(languages, (index) {
            (userSettings.currentState as TranslatedAppState).changeLanguage(languageCodes[languages[index]]);
          }, currentSelection: selectedItem,),
          new CSButton(CSButtonType.DESTRUCTIVE, TubuddyStrings.of(context).logout, onLogOut),
        ]));
  }
}
