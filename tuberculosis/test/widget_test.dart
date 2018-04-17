// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:Tubuddy/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login page enabled test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    // Verify that the login page is the first view (and thus is enabled).
    expect(find.text("Welcome to Tubuddy!"), findsOneWidget);
  });
}
