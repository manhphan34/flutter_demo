import 'package:flutte_demo/src/data/moor/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

class UserModel {
  int id;
  String name;
  DateTime date;

  UserModel({this.name, this.date});

  UserCompanion convert() {
    return UserCompanion(
      name: Value(this.name),
      date: Value(this.date),
    );
  }
}
