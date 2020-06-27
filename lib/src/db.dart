import 'dart:async';
import 'dart:core';
import 'package:flutterproarea/src/weather_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutterproarea/src/weather_base_item.dart';
import 'package:flutterproarea/src/weather_api_data.dart';

class DB {

  static final String _dbName = 'paweather.db';
  String path;
  static Database _database;

  static final weatherBase = 'weather_base';
  static final userID = 'userID';
  static final city  = 'city';
  static final cityID = 'cityID';
  static final date  = 'date';
  static final description  = 'description';
  static final temperature  = 'temperature';
  static final windSpeed  = 'wind_speed';
  static final windDegree  = 'wind_deg';
  static final rain  = 'rain';
  static final snow  = 'snow';
  static final pressure  = 'pressure';
  static final humidity = 'humidity';
  static final dateCityID = 'dateCityID';

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
                '''CREATE TABLE $weatherBase ($userID INTEGER,
                                              $city TEXT, 
                                              $cityID INTEGER,
                                              $date TEXT, 
                                              $description TEXT, 
                                              $temperature INTEGER, 
                                              $windSpeed REAL, 
                                              $windDegree INTEGER, 
                                              $rain REAL, 
                                              $snow REAL, 
                                              $pressure INTEGER, 
                                              $humidity  INTEGER,
                                              $dateCityID TEXT UNIQUE                                              
                                              )'''
            );
          }
      );
  
  }

  static _insert(WeatherDBItem dbItem) async {

    final db = await database;
    return await db.insert(weatherBase, dbItem.toMap()
        , conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<WeatherDBItem>> _getfromDB(String field, List value) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(weatherBase,
                                                           where: '$field=?',
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
      if (WeatherList.cityName != _dataFromAPI.city.name) {
        WeatherList.cityName = _dataFromAPI.city.name;
      }

      _translateResult.add(WeatherDBItem(
        city: _dataFromAPI.city.name,
        cityID: _dataFromAPI.city.id,
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

    return await _getfromDB(DB.city, cityName);

  }


 Future close() async {
   final db = await database;
   await db.execute(
       'DROP TABLE $weatherBase'
   );
 }


}