import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';

class FaqTabPage extends StatelessWidget implements TabPage {
  static final Text title = const Text("FAQ");
  static final Icon icon = const Icon(CupertinoIcons.conversation_bubble);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return new FAQEntryItem(dummyFAQ[index]);
        },
        itemCount: 4);
  }

  @override
  Text getTitle(BuildContext context) {
    return title;
  }
}

final List<FAQEntry> dummyFAQ = <FAQEntry>[
  new FAQEntry("Question 1",
      "An nam harum appareat repudiandae, eu vix quodsi inciderint. Minim clita gloriatur et eos, civibus lucilius incorrupte an vel, at eam putent luptatum convenire. No simul assueverit mel, nisl illum scribentur has ea. Dicunt aperiri definiebas vim in, mel alii molestie ei."),
  new FAQEntry("Question 2",
      "Id veniam scripta inermis mei, has ut choro tempor commune, sed eu tota populo. Probo delectus eu vix. Idque munere posidonium qui no. Pri accusamus temporibus id, case appetere convenire at vis, ei legere scribentur delicatissimi nam. Vix at affert neglegentur, purto integre his ei."),
  new FAQEntry("Question 3",
      "No elaboraret scribentur reformidans vim, sint meis contentiones et usu. Te ferri expetenda mei, ius an possim sapientem consulatu, no animal perpetua sadipscing vix. Sed eu veniam vivendum. In cum everti splendide, ea sed quas timeam posidonium. Mei error aeterno detracto ad, ex case veri ponderum vel. Idque lorem eu sea. Sit tota perpetua ad."),
  new FAQEntry("Question 4",
      "Sonet adolescens duo ea, eum eu idque dicta ancillae, mel ne illum placerat praesent. Pri ei iisque voluptua consequuntur, sumo singulis id vel. Pri ei nusquam oportere torquatos, eum ea deleniti deterruisset, an mea labores vivendum delicata. Fierent similique his ad, sit decore utinam ei. Vis apeirian recusabo theophrastus at, eu per tation nominati.")
];

class FAQEntry {
  FAQEntry(this.question, this.answer);

  final String question;
  final String answer;
}

class FAQEntryItem extends StatelessWidget {
  const FAQEntryItem(this.infoEntry);

  final FAQEntry infoEntry;

  Widget _buildTiles(FAQEntry faqEntry) {
    return new ExpansionTile(
      key: new PageStorageKey<FAQEntry>(faqEntry),
      title: new Text(faqEntry.question),
      children: <ListTile>[new ListTile(title: new Text(faqEntry.answer))],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(infoEntry);
  }
}
