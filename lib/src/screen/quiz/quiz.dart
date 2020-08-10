import 'package:flutte_demo/src/data/models/Result.dart';
import 'package:flutte_demo/src/data/moor/database.dart';
import 'package:flutte_demo/src/screen/category/category.dart';
import 'package:flutte_demo/src/screen/quiz/result/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Quizzes extends StatefulWidget {
  CategoryData categoryData;

  Quizzes({this.categoryData});

  @override
  State<StatefulWidget> createState() {
    return _QuizzesState(categoryData: categoryData);
  }
}

class _QuizzesState extends State<Quizzes> {
  var db = AppDatabase.getInstance().modesDao;
  int currentQuestion = 1;
  CategoryData categoryData;
  List<QuizData> quizzes;

  _QuizzesState({this.categoryData});

  @override
  void initState() {
    super.initState();
    quizzes = List<QuizData>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WaveHeaderImage(),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 36),
            child: Text(
              "Quiz",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 36, left: 16),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 100, right: 24, left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  builder: (BuildContext context,
                      AsyncSnapshot<List<QuizData>> snapshot) {
                    if (snapshot.hasData) {
                      quizzes = snapshot.data;
                      return Quiz(
                        quizzes: snapshot.data,
                      );
                    } else
                      return Text("Data error");
                  },
                  future: db.getQuizzesByCat(categoryData.id),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  List<QuizData> quizzes;

  Quiz({this.quizzes});

  @override
  State<StatefulWidget> createState() {
    return _QuizState(quizzes);
  }
}

class _QuizState extends State<Quiz> {
  List<QuizData> quizzes;
  QuizData quiz;
  var _result = [0, 0, 0, 0];
  var _title = TextEditingController();
  String _character = "";
  int _currentQuiz = 0;
  var _nextState = 0;
  var _quizController = TextEditingController();

  _QuizState(List<QuizData> quizzes) {
    this.quizzes = quizzes;
  }

  @override
  void initState() {
    super.initState();
    _title.text = "Next";
    _quizController.text = "1";
    _nextState = 0;
    if (quizzes != null && quizzes.isNotEmpty) {
      quiz = quizzes[_currentQuiz];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              width: 36,
              height: 36,
              child: Text(
                _quizController.text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 6),
              margin: EdgeInsets.only(left: 48),
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  quiz.description,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: Text(quiz.A),
                leading: Radio(
                  value: quiz.A,
                  onChanged: (value) {
                    setState(() {
                      _result[_currentQuiz] = 1;
                      _character = value;
                      _nextState = 1;
                    });
                  },
                  groupValue: _character,
                ),
              ),
              ListTile(
                title: Text(quiz.B),
                leading: Radio(
                  value: quiz.B,
                  onChanged: (value) {
                    setState(() {
                      _result[_currentQuiz] = 2;
                      _character = value;
                      _nextState = 1;
                    });
                  },
                  groupValue: _character,
                ),
              ),
              ListTile(
                title: Text(quiz.C),
                leading: Radio(
                  value: quiz.C,
                  onChanged: (value) {
                    setState(() {
                      _result[_currentQuiz] = 3;
                      _character = value;
                      _nextState = 1;
                    });
                  },
                  groupValue: _character,
                ),
              ),
              ListTile(
                title: Text(quiz.D),
                leading: Radio(
                  value: quiz.D,
                  onChanged: (value) {
                    setState(() {
                      _result[_currentQuiz] = 4;
                      _character = value;
                      _nextState = 1;
                    });
                  },
                  groupValue: _character,
                ),
              )
            ],
          ),
        ),
        RaisedButton(
          onPressed: () {
            if (_nextState == 0) return;
            _nextQuiz();
          },
          color: _nextState == 1 ? Colors.purple : Colors.grey,
          child: Text(
            _title.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.only(left: 24, right: 24),
        )
      ],
    );
  }

  void _nextQuiz() {
    if (_currentQuiz == 3) {
      List<Result> results = List<Result>();
      for (int i = 0; i < _result.length; i++) {
        results.add(Result(
            quizData: quizzes[i],
            correctAns: quizzes[i].result,
            answer: _result[i]));
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultPage(results: results)));
      return;
    }
    setState(() {
      _nextState = 0;
      _currentQuiz++;
      if (_currentQuiz == 3) {
        _title.text = "Finish";
      }
      _quizController.text = (_currentQuiz + 1).toString();
      quiz = quizzes[_currentQuiz];
    });
  }
}
