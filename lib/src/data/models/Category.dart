import 'package:flutte_demo/src/data/moor/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

class CategoryModel {
  int id;
  String name;
  String des;

  CategoryModel({this.id, this.name, this.des});

  CategoryCompanion convert() {
    return CategoryCompanion(
      name: Value(this.name),
      description: Value(this.des),
      id: Value(this.id),
    );
  }
}

List<CategoryCompanion> convertToCategories(List<CategoryModel> cats) {
  var list = List<CategoryCompanion>();
  if (cats == null || cats.isEmpty) return list;
  cats.forEach((e) {
    list.add(e.convert());
  });
  return list;
}
