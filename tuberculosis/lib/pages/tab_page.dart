import 'package:flutter/widgets.dart';

abstract class TabPage extends Widget {
  Text getTitle(BuildContext context) {
    return const Text("Tubuddy");
  }
}