import 'package:flutterproarea/src/weather_data.dart';

abstract class WeatherBaseItem {
  static String weatherBase = 'weather_base';
  static String cityTEXT  = 'city';
  static String dateTEXT  = 'date';
  static String temperatureINTEGER  = 'temperature';
  static String descriptionTEXT  = 'description';
  static String windSpeedREAL  = 'wind_speed';
  static String windDegreeINTEGER  = 'wind_deg';
  static String rainREAL  = 'rain';
  static String snowREAL  = 'snow';
  static String pressureINTEGER  = 'pressure';
  static String humidityINTEGER = 'humidity';

}

class WeatherToBaseItem {
  WeatherData weather;

  WeatherToBaseItem(this.weather);

  Map<String, dynamic> toMap() {

    Map<String, dynamic> mapResult;
    weather.list.map((ListData item) => {
      mapResult = {
        WeatherBaseItem.cityTEXT: this.weather.city.name,
        WeatherBaseItem.dateTEXT: item.dtTxt,
        WeatherBaseItem.descriptionTEXT: item.weather.description,
        WeatherBaseItem.temperatureINTEGER: item.main.temp,
        WeatherBaseItem.windSpeedREAL: item.wind.speed,
        WeatherBaseItem.windDegreeINTEGER: item.wind.deg,
        WeatherBaseItem.rainREAL: item.rain,
        WeatherBaseItem.snowREAL: item.snow,
        WeatherBaseItem.pressureINTEGER: item.main.pressure,
        WeatherBaseItem.humidityINTEGER: item.main.humidity
      }

    });
    return mapResult;
  }
}

class WeatherFromBaseItem {

  String city;
  String date;
  String description;
  int temperature;
  double windSpeed;
  int windDegree;
  double rain;
  double snow;
  int pressure;
  int humidity;


  WeatherFromBaseItem(
      this.city,
      this.date,
      this.description,
      this.temperature,
      this.windSpeed,
      this.windDegree,
      this.rain,
      this.snow,
      this.pressure,
      this.humidity);

  static WeatherFromBaseItem fromMap(Map<String, dynamic> map) {

    return WeatherFromBaseItem(
        map [WeatherBaseItem.cityTEXT],
        map [WeatherBaseItem.dateTEXT],
        map [WeatherBaseItem.descriptionTEXT],
        map [WeatherBaseItem.temperatureINTEGER],
        map [WeatherBaseItem.windSpeedREAL],
        map [WeatherBaseItem.windDegreeINTEGER],
        map [WeatherBaseItem.rainREAL],
        map [WeatherBaseItem.snowREAL],
        map [WeatherBaseItem.pressureINTEGER],
        map [WeatherBaseItem.humidityINTEGER]
    );
  }

}