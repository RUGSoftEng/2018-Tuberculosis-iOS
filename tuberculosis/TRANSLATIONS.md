# New Translation guide
To add new strings to the translations file, add strings in `lib/tubuddy_strings.dart`.

Documentation for defining new strings can be found in the [intl package](https://pub.dartlang.org/documentation/intl/latest/).  
The next step is running the following command in the project root directory:
```
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/tubuddy_strings.dart
```
This will generate an intl_messages.arb file in the `lib/i18n` folder.
You have to manually copy (and translate) the new definitions to all `tubuddy_messages_{locale}.arb` files.

After translating the following command has to be run to generate new Dart translation files:
```
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n --generated-file-prefix=tubuddy_ --no-use-deferred-loading lib/*.dart lib/i18n/tubuddy_*.arb
```

# Adding a new locale
Copy one of the existing `tubuddy_messages_{locale}.dart` files to a new file with the locale you desire.  
After copying the file you can begin translating the strings.

The next step is to open `translated_app.dart` and add your locale to the `supportedLocales` array.