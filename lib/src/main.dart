import 'dart:async';

import 'package:flutte_demo/src/screen/home/Home.dart';
import 'package:flutte_demo/src/screen/register/register.dart';
import 'package:flutte_demo/src/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _isRegister().then((value) {
      if (!value)
        Timer(
          Duration(seconds: 3),
          () {
            print(value);
            Navigator.pushNamed(context, "/register");
          },
        );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
      appBar: null,
      body: FadeTransition(
        opacity: _animation,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Image.asset(
              'assets/images/splash_app.png',
              fit: BoxFit.fill,
              width: 300,
              height: 300,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _isRegister() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(IS_REGISTER) ?? false;
  }
}
