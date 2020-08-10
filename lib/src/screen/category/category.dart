import 'package:flutte_demo/src/data/moor/database.dart';
import 'package:flutte_demo/src/screen/quiz/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          WaveHeaderImage(),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 36),
            child: Text(
              "Chủ đề",
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
            margin: EdgeInsets.only(top: 36, right: 16),
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/images/question.png",
              width: 24,
              height: 24,
            ),
          ),
          Category(),
        ],
      ),
    );
  }
}

class Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryState();
  }
}

class _CategoryState extends State<Category> {
  var db = AppDatabase.getInstance().modesDao;
  List<CategoryData> categories;

  @override
  void initState() {
    super.initState();
    categories = List<CategoryData>();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: GridView.builder(
        itemCount: categories.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var item = categories[index];
          return Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(4.0)),
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Quizzes(
                                categoryData: item,
                              )));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Image.asset(
                        item.icon,
                        width: 48,
                        height: 48,
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          item.name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }

  void getData() async {
    await db.getCategories.then(
      (value) {
        setState(() {
          categories = value;
        });
      },
      onError: (err) {
        print(err);
      },
    );
  }
}

class WaveHeaderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Image.asset(
        "assets/images/header.jpg",
        fit: BoxFit.fill,
      ),
      clipper: BottomWaveClipper(),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
