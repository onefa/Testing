import 'dart:async';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutterproarea/src/authorization.dart';
import 'package:flutterproarea/src/pro_area_app.dart';

Future<void> main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await AndroidAlarmManager.initialize();

  runApp(new MaterialApp(
    home: AutorizationPage(),
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




