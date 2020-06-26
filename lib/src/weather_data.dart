import 'package:json_annotation/json_annotation.dart';
part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  int cnt;
  City city;
  @JsonKey(name: 'list')
  List listItem = [];
  @JsonKey(ignore: true)
  List<ListData> list = [];

  WeatherData.start() : this.list = [];
  WeatherData(this.cnt, this.city, this.listItem){
    for (int i = 0; i < cnt; i++) {
      list.add(ListData.fromJson(listItem[i]));
    }
  }
  factory WeatherData.fromJson(Map<String, dynamic> json) => _$WeatherDataFromJson(json);
}

@JsonSerializable()
class ListData {
  Main main;
  Wind wind;
  Rain rain;
  Snow snow;

  @JsonKey(name: 'dt_txt')
  String dtTxt;

  @JsonKey(name: 'weather')
  List weatherList;
  @JsonKey(ignore: true)
  Weather weather;

  ListData(this.main, this.weatherList, this.wind, this.rain, this.snow, this.dtTxt){
    weather = Weather.fromJson(weatherList[0]);
  }
  factory ListData.fromJson(Map<String, dynamic> json) => _$ListDataFromJson(json);
}

@JsonSerializable()
class Main {
  @JsonKey(name: 'temp')
  double doubleTemp;
  @JsonKey(ignore: true)
  int temp;

  @JsonKey(name: 'feels_like')
  double doubleFeelslike;
  @JsonKey(ignore: true)
  int feelsLike;

  @JsonKey(name: 'temp_min')
  double doubleTempMin;
  @JsonKey(ignore: true)
  int tempMin;

  @JsonKey(name: 'temp_max')
  double doubleTempMax;
  @JsonKey(ignore: true)
  int tempMax;

  int pressure;
  int humidity;

  Main(this.doubleTemp,
       this.doubleFeelslike,
       this.doubleTempMin,
       this.doubleTempMax,
       this.pressure,
       this.humidity) {

    this.temp = (doubleTemp).round();
    this.feelsLike = (doubleFeelslike).round();
    this.tempMin = (doubleTempMin).round();
    this.tempMax = (doubleTempMax).round();
  }
  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}

@JsonSerializable()
class Weather {
  int id;
  String main;
  String description;

  Weather(this.id, this.main, this.description);
  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
}

@JsonSerializable()
class Wind{
  double speed;
  int deg;

  Wind(this.speed, this.deg);
  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}

@JsonSerializable()
class Rain{
  @JsonKey(name: '3h')
  double x3h;

  Rain(this.x3h);
  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);
}

@JsonSerializable()
class Snow{
  @JsonKey(name: '3h')
  double x3h;

  Snow(this.x3h);
  factory Snow.fromJson(Map<String, dynamic> json) => _$SnowFromJson(json);
}



@JsonSerializable()
class City {
  int id;
  String name;
  Coord coord;

  City(this.id, this.name, this.coord);
  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@JsonSerializable()
class Coord {
  double lat;
  double lon;

  Coord(this.lat, this.lon);
  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}
