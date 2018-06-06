import 'package:Tubuddy/quiz/question.dart';
import 'package:Tubuddy/tubuddy_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void CheckAnswerCallback(int check);
class _QuestionWidget extends StatelessWidget {
  final Question _question;
  final CheckAnswerCallback onPressed;

  _QuestionWidget(this._question, this.onPressed);

  @override
  Widget build(BuildContext context) {
    // Create basic elements (title + question)
    List<Widget> c = [
      new Center(child: new Text(TubuddyStrings.of(context).quizTitle, style: Theme.of(context).textTheme.subhead)),
      new Center(child: new Text(_question.question, style: Theme.of(context).textTheme.headline)),
    ];
    // Add answer input elements
    List<Widget> answerWidgets = [];
    for (var i = 0; i < _question.answers.length; i++) {
      answerWidgets.add(new CupertinoButton(child: new Text(_question.answers[i]), onPressed: () {
        onPressed(i);
      }));
    }
    c.add(new Expanded(child: new ListView(children: answerWidgets,)));

    return new Expanded(child: new Column(children: c,));
  }
}

class _QuestionCheckPage extends StatelessWidget {
  final String message;
  final bool isCorrect;
  final VoidCallback onNextClicked;

  _QuestionCheckPage(this.message, this.isCorrect, this.onNextClicked);

  @override
  Widget build(BuildContext context) {
    return new Expanded(child: new Column(children: [
      new Text(message, style: Theme.of(context).textTheme.headline.copyWith(color: isCorrect ? Colors.green : Colors.red)),
      new CupertinoButton(child: new Text("OK"), onPressed: onNextClicked)
    ], crossAxisAlignment: CrossAxisAlignment.center));
  }
}

class _QuizFinished extends StatelessWidget {
  final int correct;
  final int total;

  _QuizFinished(this.correct, this.total);

  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text(TubuddyStrings.of(context).quizResult(correct, total), style: Theme.of(context).textTheme.headline));
  }
}

class QuizWidget extends StatefulWidget {
  final List<Question> _questions;

  const QuizWidget(this._questions);

  @override
  State<StatefulWidget> createState() => new _QuizState();
}

class _QuizState extends State<QuizWidget> {

  int currentQuestion = 0;
  int correct = 0;
  bool showCheckPage = false;
  String checkMessage = "";
  bool lastQuestionCorrect = false;
  bool showFinishPage = false;

  void _checkAnswer(int idx) {
    setState(() {
      if (widget._questions[currentQuestion].correctAnswer == idx) {
        correct++;
        lastQuestionCorrect = true;
        checkMessage = TubuddyStrings.of(context).quizQuestionCorrect;
      } else {
        lastQuestionCorrect = false;
        checkMessage = TubuddyStrings.of(context).quizQuestionWrong(widget._questions[currentQuestion].answers[widget._questions[currentQuestion].correctAnswer]);
      }
      showCheckPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showFinishPage) {
      return new _QuizFinished(correct, widget._questions.length);
    }

    if (showCheckPage) {
      return new _QuestionCheckPage(checkMessage, lastQuestionCorrect, () {
        setState(() {
          showCheckPage = false;
          currentQuestion = currentQuestion + 1;
          if (currentQuestion == widget._questions.length) {
            showFinishPage = true;
          }
        });
      });
    } else {
      return new Expanded(child: new Column(children: [
        new _QuestionWidget(widget._questions[currentQuestion], (i) => _checkAnswer(i)),
        new Align(alignment: Alignment.bottomCenter, child: new Text(TubuddyStrings.of(context).quizQuestionProgress(currentQuestion+1, widget._questions.length)))
      ]));
    }
  }

}