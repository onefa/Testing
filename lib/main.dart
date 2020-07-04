/*
All application features is available with registration and sign in.
While user not signed in, background monitoring and saving weather forecast
not available.
Until user == null, only current weather forecast feature would be present.
If "User" button pressed, customer can sign in with email/password, Google
or Facebook account (or press "Free" button for return to Userless application
features)
 */






import 'dart:async';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutterproarea/src/enter_point.dart';
import 'package:flutterproarea/src/w_styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  runApp(new MaterialApp(
    title: 'WeatherBase',
    theme: ThemeData(
      primaryColor: WStyles.mainBackColor,
      textTheme: TextTheme(bodyText1: TextStyle(color: WStyles.lightFontColor)),
    ),
    home: EnterPoint(),
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
          MaterialPageRoute(builder: (context) => EnterPoint()),
        ));

  }

  @override
  Widget build(BuildContext context) {
    return
      new Center(
        child:  Image.asset('src/images/twosecpic.png'),
    );
  }
}




