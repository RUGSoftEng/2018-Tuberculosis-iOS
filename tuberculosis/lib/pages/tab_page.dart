import 'package:flutter/widgets.dart';

abstract class TabPage extends StatelessWidget {
  Text getTitle() {
    return const Text("Tubuddy");
  }
}