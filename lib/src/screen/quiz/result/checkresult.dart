import 'package:flutte_demo/src/data/models/Result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckResult extends StatelessWidget {
  List<Result> results;

  CheckResult({this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kiểm tra kết quả"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.pink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  var item = results[index];
                  return ContainerInfo(
                    title: item.quizData.description,
                    answer: item.getAns(item.answer),
                    correctAns: item.getAns(item.correctAns),
                  );
                })),
      ),
    );
  }
}

class ContainerInfo extends StatelessWidget {
  var title;
  var answer;
  var correctAns;

  ContainerInfo({this.title, this.answer, this.correctAns});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 16, right: 16, top: 8,bottom: 8),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                height: 1.5,
                fontSize: 18,
                color: Colors.black,
              )),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              "Trả lời: $answer",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: answer == correctAns ? Colors.green : Colors.red),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              "Đáp án : $correctAns",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
