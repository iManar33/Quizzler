import 'package:flutter/material.dart';
import 'package:quizzler_flutter/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void checkAnswer(bool userPickedanswer) {
    setState(() {
      if (quizBrain.isFinished() == true) {
        scoreKeeper.clear();
        Alert(
          context: context,
          type: AlertType.error,
          title: "Finished",
          desc: "You've reached the end of the quiz.",
          buttons: [
            DialogButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
      else {
        bool correctAnswer = quizBrain.getAnswer();
        if (correctAnswer == userPickedanswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  List<Icon> scoreKeeper = [];
//   List<String> questions = [
//     'You can lead a cow down stairs but not up stairs.',
//     'Approximately one quarter of human bons are in the feet. ',
//     'A slung\' blood is green.',
//   ];
//   List<bool> answers = [
//     false,
//     true,
//     true,
// ];

  // Question q1 = Question(q: 'You can lead a cow down stairs but not up stairs.' , a: false);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(true);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                primary: Colors.white,
              ),
              child: Text('True'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(false);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.white,
              ),
              child: Text('False'),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
