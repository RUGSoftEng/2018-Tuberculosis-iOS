import 'package:flutter/widgets.dart';

abstract class TabPage extends Widget {
  Text getTitle() {
    return const Text("Tubuddy");
  }
}