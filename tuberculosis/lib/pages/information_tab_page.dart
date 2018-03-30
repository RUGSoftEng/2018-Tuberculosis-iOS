import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';

class InformationTabPage extends StatelessWidget implements TabPage {
  final Text _title = const Text("Information");

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.do_not_disturb_alt);
  }

  @override
  Text getTitle() {
    return _title;
  }
}