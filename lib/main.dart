import 'dart:async';
import 'package:flutter/material.dart';
import 'src/ProAreaApp.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    new Future.delayed(
        const Duration(seconds: 2),
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProAreaApp()),
        ));

  }

  @override
  Widget build(BuildContext context) {
    return
      new Center(
        child:  Image.asset( 'twosecpic.png'
          ),
    );
  }
}
