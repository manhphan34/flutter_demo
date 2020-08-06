import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
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
                          padding: EdgeInsets.only(right: 16,bottom: 8),
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
          appBar: AppBar(
            title: Text("Register"),
            centerTitle: true,
          ),
          body: Center(
            child: Text("Register"),
          ),
        ));
  }
}
