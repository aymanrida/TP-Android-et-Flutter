import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestion = 0;
  int score = 0;
  var quiz = [
    {
      'title': 'Question 1',
      'answers': [
        {'answer': 'Answer 11', 'correct': false},
        {'answer': 'Answer 12', 'correct': false},
        {'answer': 'Answer 13', 'correct': true},
      ]
    },
    {
      'title': 'Question 2',
      'answers': [
        {'answer': 'Answer 21', 'correct': false},
        {'answer': 'Answer 22', 'correct': true},
        {'answer': 'Answer 23', 'correct': false},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
          backgroundColor: Colors.red,
        ),
        body: (this.currentQuestion >= quiz.length)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Votre Score est : ${score} (${(100 * score / quiz.length).round()}%)',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          currentQuestion=0;
                          score=0;
                        });
                      },
                      child: Text(
                        'Restart ?',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      color: Colors.redAccent,
                    )
                  ],
                ),
              )
            : ListView(
                children: <Widget>[
                  ListTile(
                    title: Center(
                        child: Text(
                      'Question ${currentQuestion + 1} / ${quiz.length}',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  ListTile(
                    title: Text(
                      quiz[currentQuestion]['title'],
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...(quiz[currentQuestion]['answers']
                          as List<Map<String, Object>>)
                      .map((answer) {
                    return ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              if (answer['correct'] == true) ++score;
                              ++currentQuestion;
                            });
                          },
                          child: Text(answer['answer']),
                          color: Colors.redAccent,
                          textColor: Colors.white,
                        ),
                      ),
                    );
                  })
                ],
              ));
  }
}
