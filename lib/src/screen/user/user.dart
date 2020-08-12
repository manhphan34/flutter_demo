import 'dart:io';

import 'package:flutte_demo/src/data/moor/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class User extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserState();
  }
}

class _UserState extends State<User> {
  var icon = [
    "assets/images/music.png",
    "assets/images/chef.png",
    "assets/images/fast.png",
    "assets/images/science.png",
    "assets/images/book.png",
    "assets/images/video.png",
  ];
  var db = AppDatabase.getInstance().modesDao;
  var picker = ImagePicker();
  File image;
  UserData _user;
  List<PointData> points;
  var _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    points = List<PointData>();
    getUser();
    getPoint();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure ?'),
              content: new Text('Do you want to exit app'),
              actions: [
                Row(
                  children: [
                    new GestureDetector(
                      onTap: () => SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop'),
                      child: Padding(
                        padding: EdgeInsets.only(right: 16, bottom: 8),
                        child: Text("YES"),
                      ),
                    ),
                    new GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Padding(
                          padding: EdgeInsets.only(right: 16, bottom: 8),
                          child: Text("NO"),
                        )),
                    SizedBox(height: 12),
                  ],
                )
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          body: Column(
        children: [
          Stack(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/header.jpg",
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                height: 250,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 53,
                          backgroundImage: imagePathIsNull()
                              ? AssetImage('assets/images/user.png')
                              : FileImage(File(_user.image)),
                        ),
                      ),
                      onTap: () {
                        updateImage();
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        _nameController.text,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 300,
            padding: EdgeInsets.only(left: 4, right: 4),
            child: GridView.builder(
              itemCount: 6,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                PointData item;
                if (points != null)
                  points.forEach((element) {
                    if (element.idCat == index+1) item = element;
                  });
                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.pinkAccent),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        icon[index],
                        width: 32,
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(item == null ? "0/4" : "${item.point}/4"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/category");
              },
              color: Colors.deepPurpleAccent,
              child: Text(
                "Start Quiz",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  void updateImage() async {
    print("update");
    final picketFile = await picker.getImage(source: ImageSource.gallery);
    await db.updateUser(_user.id, picketFile.path).then((value) => getUser());
  }

  bool imagePathIsNull() {
    if (_user == null || _user.image == null || _user.image.isEmpty) {
      return true;
    }
    return false;
  }

  void getUser() async {
    await db.getUser.then((value) {
      setState(() {
        _nameController.text = value[0].name;
        _user = value[0];
      });
    });
  }

  void getPoint() async {
    await db.getPoints.then((value) {
      print(value.length.toString());
      setState(() {
        if (value != null) points = value;
      });
    });
  }
}
