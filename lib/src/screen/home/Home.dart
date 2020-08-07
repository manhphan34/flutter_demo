import 'package:flutte_demo/src/data/moor/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  var db = AppDatabase.getInstance().modesDao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Text("Home"),
          RaisedButton(
            onPressed: getData,
            child: Text("Test"),
          )
        ],
      ),
    );
  }

  void getData() async{
    await db.getCategories.then(
      (value) => print(value),
      onError: (err) {
        print(err);
      },
    );
  }
}
