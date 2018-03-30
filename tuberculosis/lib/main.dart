import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new CupertinoTabScaffold(
        tabBar: new CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.home),
              title: const Text('Home'),
            ),
            const BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.conversation_bubble),
              title: const Text('Support'),
            ),
            const BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.profile_circled),
              title: const Text('Profile'),
            ),
            const BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.profile_circled),
              title: const Text('Profile'),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return new DefaultTextStyle(
            style: const TextStyle(
              fontFamily: '.SF UI Text',
              fontSize: 17.0,
              color: CupertinoColors.black,
            ),
            child: new CupertinoTabView(
              builder: (BuildContext context) {
                var pageContent;
                switch (index) {
                  case 0:
                    pageContent = new ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return dummyMedicationData[index];
                        },
                        itemCount: 2);
                    break;
                  case 1:
                    pageContent = new ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return new InfoEntryItem(dummyFAQ[index]);
                        },
                        itemCount: 4);
                    break;
                  case 2:
                    break;
                  case 3:
                    break;
                }
                return new CupertinoPageScaffold(
                    child: new Scaffold(
                  body: pageContent,
                ));
              },
            ),
          );
        },
      ),
    );
  }
}

final List<MedicationItem> dummyMedicationData = <MedicationItem>[
  new MedicationItem("Loratidine", "Any Time", 1),
  new MedicationItem("Differin", "Any Time", 2),
];

class MedicationItem extends StatelessWidget {
  MedicationItem(
      this.medicationName, this.recommendedTime, this.recommendedDosage);

  final String medicationName;
  final String recommendedTime;
  final int recommendedDosage;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: const Icon(Icons.healing),
        title: new Text(this.medicationName),
        subtitle: recommendedDosage != 1
            ? new Text(recommendedTime +
                " - " +
                recommendedDosage.toString() +
                " pills")
            : new Text(recommendedTime +
                " - " +
                recommendedDosage.toString() +
                " pill"));
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

class InfoEntryItem extends StatelessWidget {
  const InfoEntryItem(this.infoEntry);

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
