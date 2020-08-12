import 'package:flutte_demo/src/data/moor/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

class UserModel {
  int id;
  String name;
  DateTime date;
  String image = "";

  UserModel({this.name, this.date, this.image});

  UserCompanion convert() {
    return UserCompanion(
      name: Value(this.name),
      date: Value(this.date),
      image: Value(image),
    );
  }
}
