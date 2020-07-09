import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterproarea/src/db.dart';
import 'package:path/path.dart';

class DBUser {
  String outerID;
  int userCityID;
  String userName;
  String userEmail;

  DBUser({
        this.outerID,
        this.userCityID,
        this.userName,
        this.userEmail});

  DBUser.fromFirebase(FirebaseUser user) {
    outerID = user.uid;
    userName = user.displayName != null ? user.displayName : null;
    userEmail = user.email != null ? user.email : null;
  }

  setCityID(int cityID) {
    this.userCityID = cityID;
  }

  Map<String, dynamic> toMap() {
    return {
      DB.outerID: outerID,
      DB.userCityID: userCityID,
      DB.userName: userName,
      DB.userEmail: userEmail,
    };
  }

  factory DBUser.fromMap(Map<String, dynamic> map) =>
      DBUser(
        outerID: map[DB.outerID],
        userCityID: map[DB.userCityID] != null ? map[DB.userCityID] : null,
        userName: map[DB.userName] != null ? map[DB.userName] : null,
        userEmail: map[DB.userEmail] != null ? map[DB.userEmail] : null,
      );

}

class WeatherDBItem {

  String city;
  int cityID;
  String date;
  String description;
  int temperature;
  double windSpeed;
  int windDegree;
  double rain;
  double snow;
  int pressure;
  int humidity;

  WeatherDBItem({
      this.city,
      this.cityID,
      this.date,
      this.description,
      this.temperature,
      this.windSpeed,
      this.windDegree,
      this.rain,
      this.snow,
      this.pressure,
      this.humidity});

  Map<String, dynamic> toMap() {
    return {
      DB.city: city,
      DB.cityID: cityID,
      DB.date: date,
      DB.description: description,
      DB.temperature: temperature,
      DB.windSpeed: windSpeed,
      DB.windDegree: windDegree,
      DB.rain: rain,
      DB.snow: snow,
      DB.pressure: pressure,
      DB.humidity: humidity,
      DB.dateCityID: join(date.toString(), cityID.toString())
    };
  }


  factory WeatherDBItem.fromMap(Map<String, dynamic> map) =>
    WeatherDBItem(
        city: map[DB.city],
        cityID: map[DB.cityID],
        date: map[DB.date],
        description: map[DB.description],
        temperature: map[DB.temperature],
        windSpeed: map[DB.windSpeed],
        windDegree: map[DB.windDegree],
        rain: map[DB.rain],
        snow: map[DB.snow],
        pressure: map[DB.pressure],
        humidity: map[DB.humidity],
    );

}
