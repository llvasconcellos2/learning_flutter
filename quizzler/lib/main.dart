import 'package:flutter/material.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List scoreKeeper = [];
  Map<int, Map<String, bool>> questions = {
    0: {'O nome do inventor da marca Ferrari é Enzo?': true},
    1: {'Na China surgiu a primeira moeda?': false},
    2: {'Em Moçambique se fala português?': true},
    3: {'O maior oceano do mundo é o Atlântico?': false},
    4: {'Albert Einstein era Austríaco?': false},
    5: {'A raiz quadrada de 81 é 9?': true},
  };

  int questionNumber = 0;

  void answerQuestion(bool answer) {
    var question = questions[questionNumber];
    var correctAnswer = question?.values.toList().first;
    var score = correctAnswer == answer;
    setState(() {
      scoreKeeper.add(score);

      if (questionNumber < questions.length - 1) questionNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var question = questions[questionNumber]?.keys.toList().first;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                question!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                answerQuestion(true);
              },
              child: const Text(
                'True',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                answerQuestion(false);
              },
              child: const Text(
                'False',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              ...scoreKeeper.map(
                (e) =>
                    e
                        ? Icon(Icons.check, color: Colors.green)
                        : Icon(Icons.close, color: Colors.red),
              ),
              // for (var score in scoreKeeper)
              //    score
              //    ? Icon(Icons.check, color: Colors.green)
              //    : Icon(Icons.close, color: Colors.red),
            ],
          ),
        ),
      ],
    );
  }
}
