import 'package:Tubuddy/api/api.dart';
import 'package:Tubuddy/api/faq.dart';
import 'package:Tubuddy/api/fetch_data_widget.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';

class FaqTabPage extends StatelessWidget implements TabPage {
  static final Text title = const Text("FAQ");
  static final Icon icon = const Icon(CupertinoIcons.conversation_bubble);

  static String getTitleStatic(BuildContext context) {
    return TubuddyStrings.of(context).faqTitle;
  }

  @override
  Widget build(BuildContext context) {
    return new FetchDataWidget<List<FAQEntry>>(
      builder: (context, entries) {
        return new ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return new FAQEntryItem(entries[index]);
            },
            itemCount: entries.length);
      },
      getFutureFunction: api.faq.getEntries
    );
  }

  @override
  Text getTitle(BuildContext context) {
    return Text(FaqTabPage.getTitleStatic(context));
  }
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
