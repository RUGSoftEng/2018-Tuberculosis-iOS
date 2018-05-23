class Question {
  final String question;

  final List<String> answers;
  final int correctAnswer;

  const Question(this.question, {this.answers = const <String>["Appel", "Banaan", "Citroen"], this.correctAnswer = 0});
}