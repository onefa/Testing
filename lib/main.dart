import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutterproarea/src/authorization_service.dart';
import 'package:flutterproarea/src/enter_point.dart';
import 'package:flutterproarea/src/fcm.dart';
import 'package:flutterproarea/src/weather_base_item.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();


  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WeatherBase',
    builder: BotToastInit(),
    navigatorObservers: [BotToastNavigatorObserver()],
    home: AnimatedSplashScreen(
            centered: true,
            splash: Image.asset('twosecpic.png'),
            nextScreen: MyApp(),
            duration: 2000,
          )
    )
  );
}

class MyApp extends StatefulWidget {
  static List<int> alarmAPISavedCities = [];
  static final maxSavedCities = 7;
  static final loadNewForecastMinutes = 30;
  @override
  _MyAppState createState() => new _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FCM().initMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<DBUser>.value(
      value: AuthService().currentFirebaseUser,
      child: EnterPoint(),
    );
  }

}




