import 'package:flutte_demo/src/data/models/Result.dart';
import 'package:flutte_demo/src/screen/quiz/result/checkresult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResultPage extends StatelessWidget {
  List<Result> results;

  var _correctAns = 0;

  ResultPage({this.results});

  @override
  Widget build(BuildContext context) {
    getCorrectAns();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/user");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kết quả"),
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
          child: Column(
            children: [
              ContainerInfo(
                title: "Tổng số lượng câu hỏi",
                subTitle: "4",
              ),
              ContainerInfo(
                title: "Điểm",
                subTitle: _correctAns.toString(),
              ),
              ContainerInfo(
                title: "Số câu trả lời đúng ",
                subTitle: "$_correctAns/4",
              ),
              ContainerInfo(
                title: "Số câu trả lời sai",
                subTitle: "${4 - _correctAns}/4",
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 32),
                child: RaisedButton(
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckResult(
                          results: results,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Kiểm tra kết quả",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getCorrectAns() {
    results.forEach((e) {
      if (e.answer == e.correctAns) _correctAns++;
    });
  }
}

class ContainerInfo extends StatelessWidget {
  var title;
  var subTitle;

  ContainerInfo({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      padding: EdgeInsets.all(16),
      height: 80,
      child: Row(
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black)),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                subTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepPurpleAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
