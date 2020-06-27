import 'dart:async';
import 'dart:core';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutterproarea/src/weather_base_item.dart';
import 'package:flutterproarea/src/weather_data.dart';

class DB {

  static final String _dbName = 'paweather.db';
  String path;
  static Database _database;

  static final weatherBase = 'weather_base';
  static final userIDINTEGER = 'userID';
  static final cityTEXT  = 'city';
  static final dateTEXT  = 'date';
  static final descriptionTEXT  = 'description';
  static final temperatureINTEGER  = 'temperature';
  static final windSpeedREAL  = 'wind_speed';
  static final windDegreeINTEGER  = 'wind_deg';
  static final rainREAL  = 'rain';
  static final snowREAL  = 'snow';
  static final pressureINTEGER  = 'pressure';
  static final humidityINTEGER = 'humidity';

  DB._();
  static final DB db = DB._();

  static Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  static init() async {
      String databasePath = await getDatabasesPath();
      String path = join(databasePath, _dbName);
      return await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            await db.execute(
                '''CREATE TABLE $weatherBase ($userIDINTEGER INTEGER,
                                              $cityTEXT TEXT, 
                                              $dateTEXT TEXT, 
                                              $descriptionTEXT TEXT, 
                                              $temperatureINTEGER INTEGER, 
                                              $windSpeedREAL REAL, 
                                              $windDegreeINTEGER INTEGER, 
                                              $rainREAL REAL, 
                                              $snowREAL REAL, 
                                              $pressureINTEGER INTEGER, 
                                              $humidityINTEGER  INTEGER)'''
            );
          }
      );
  
  }

  static _insert(WeatherDBItem dbItem) async {

    final db = await database;
    return await db.insert(weatherBase, dbItem.toMap());
  }

  static updateWithDate(WeatherDBItem dbItem) async {
      final db = await database;
      return await db.update(weatherBase, dbItem.toMap(),
                  where: '$dateTEXT = ?', whereArgs: [dbItem.date]);
  }

  static Future<List<WeatherDBItem>> _getfromDB(String field, List value) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(weatherBase,
                                                           where: '$field = ?',
                                                           whereArgs: value,
                                                           );

    List<WeatherDBItem> outList = [];
    maps.forEach((element) {
      outList.add(WeatherDBItem.fromMap(element));
    });

    return outList;

  }



  static transferToBase(WeatherData _dataFromAPI, int userID) {
    List<WeatherDBItem> _translateResult = [];
    _dataFromAPI.list.forEach((listItem) {
      _translateResult.add(WeatherDBItem(
        city: _dataFromAPI.city.name,
        userID: userID,
        date: listItem.dtTxt,
        description: listItem.weather.description,
        temperature: listItem.main.temp,
        windSpeed: listItem.wind.speed,
        windDegree: listItem.wind.deg,
        rain: listItem.rain == null ? null : listItem.rain.x3h,
        snow: listItem.snow == null ? null : listItem.snow.x3h,
        pressure: listItem.main.pressure,
        humidity: listItem.main.humidity,
      ));
    });

    _translateResult.forEach((_translatedItem) async {
      int n = await _insert(_translatedItem);
    });
  }


  static Future<List<WeatherDBItem>> transferFromBase(String city) async {
    List cityName = [];
    cityName.add(city);

    return await _getfromDB(cityTEXT, cityName);

  }


// Future close() async => database.close();


}