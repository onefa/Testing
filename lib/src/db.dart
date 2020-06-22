import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:flutterproarea/src/weather_base_item.dart';

abstract class DB{
  static Database _db;
  static int  get _version => 1;
  static Future<void> init() async {
    if (_db != null) return;
    try {
      String _path = await getDatabasesPath() + 'proarea';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch(excpt) {
      print(excpt);
    }
  }

  static void onCreate(Database db, int version) async =>
      await db.execute('CREATE TABLE '
                      + WeatherBaseItem.weatherBase + ' ('
                      + WeatherBaseItem.cityTEXT + ' TEXT, '
                      + WeatherBaseItem.dateTEXT + ' TEXT, '
                      + WeatherBaseItem.descriptionTEXT + ' TEXT, '
                      + WeatherBaseItem.temperatureINTEGER + ' INTEGER, '
                      + WeatherBaseItem.windSpeedREAL + ' REAL, '
                      + WeatherBaseItem.windDegreeINTEGER + ' INTEGER, '
                      + WeatherBaseItem.rainREAL + ' REAL, '
                      + WeatherBaseItem.snowREAL + ' REAL, '
                      + WeatherBaseItem.pressureINTEGER + ' INTEGER, '
                      + WeatherBaseItem.humidityINTEGER + ' INTEGER)'
      );

}



