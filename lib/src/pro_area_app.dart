import 'package:flutter/material.dart';
import 'package:flutterproarea/src/weather_list.dart';

class ProAreaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WeatherBase',
        theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: WeatherList()
    );
  }
}

