import 'package:Tubuddy/api/api.dart';
import 'package:Tubuddy/api/faq.dart';
import 'package:Tubuddy/api/fetch_data_widget.dart';
import 'package:Tubuddy/translated_app.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tubuddy/pages/tab_page.dart';
import 'package:flutter/cupertino.dart';

class _FaqQuestionBox extends StatelessWidget {

  final faqTxtController = new TextEditingController();

  void _showInSnackbar(BuildContext context, String txt) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(txt),));
  }

  Widget _buildQuestionBox(BuildContext context) {
    return Column(
      children: [
        Text(TubuddyStrings.of(context).faqAskQuestion, style: Theme.of(context).textTheme.title,),
        TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          controller: faqTxtController,
        ),
        CupertinoButton(
          child: Text(TubuddyStrings.of(context).faqQuestionSubmit),
          onPressed: () {
            _showInSnackbar(context, TubuddyStrings.of(context).faqQuestionSubmitted);
            api.notes.addNote(faqTxtController.text);
            faqTxtController.text = '';
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildQuestionBox(context);
  }

}

class FaqTabPage extends StatelessWidget implements TabPage {
  static final Icon icon = const Icon(CupertinoIcons.conversation_bubble);

  static String getTitleStatic(BuildContext context) {
    return TubuddyStrings.of(context).faqTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Column(children: [
      FetchDataWidget<List<FAQEntry>>(
        builder: (context, entries) {
          return Expanded(child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new FAQEntryItem(entries[index % entries.length]);
              },
              itemCount: entries.length * 2,
          ));
        },
        getFutureFunction: api.faq.getEntries,
        language: api.lang,
      ),
      _FaqQuestionBox(),
    ])));
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
