import 'package:flutterproarea/src/db.dart';

class WeatherDBItem {

  String city;
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
      DB.cityTEXT: city,
      DB.userIDINTEGER: userID,
      DB.dateTEXT: date,
      DB.descriptionTEXT: description,
      DB.temperatureINTEGER: temperature,
      DB.windSpeedREAL: windSpeed,
      DB.windDegreeINTEGER: windDegree,
      DB.rainREAL: rain,
      DB.snowREAL: snow,
      DB.pressureINTEGER: pressure,
      DB.humidityINTEGER: humidity,
    };
  }


  factory WeatherDBItem.fromMap(Map<String, dynamic> map) =>
    WeatherDBItem(
        city: map[DB.cityTEXT],
        userID: map[DB.userIDINTEGER],
        date: map[DB.dateTEXT],
        description: map[DB.descriptionTEXT],
        temperature: map[DB.temperatureINTEGER],
        windSpeed: map[DB.windSpeedREAL],
        windDegree: map[DB.windDegreeINTEGER],
        rain: map[DB.rainREAL],
        snow: map[DB.snowREAL],
        pressure: map[DB.pressureINTEGER],
        humidity: map[DB.humidityINTEGER],
    );


}
