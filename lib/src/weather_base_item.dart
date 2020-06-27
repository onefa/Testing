import 'package:flutterproarea/src/db.dart';
import 'package:path/path.dart';

class WeatherDBItem {

  String city;
  int cityID;
  int userID;
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
      this.userID,
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
      DB.userID: userID,
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
        userID: map[DB.userID],
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
