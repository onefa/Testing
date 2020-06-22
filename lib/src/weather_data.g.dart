// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) {
  return WeatherData(
    json['cnt'] as int,
    json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    json['list'] as List,
  );
}

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'cnt': instance.cnt,
      'city': instance.city,
      'list': instance.listItem,
    };

ListData _$ListDataFromJson(Map<String, dynamic> json) {
  return ListData(
    json['main'] == null
        ? null
        : Main.fromJson(json['main'] as Map<String, dynamic>),
    json['weather'] as List,
    json['wind'] == null
        ? null
        : Wind.fromJson(json['wind'] as Map<String, dynamic>),
    json['rain'] == null
        ? null
        : Rain.fromJson(json['rain'] as Map<String, dynamic>),
    json['snow'] == null
        ? null
        : Snow.fromJson(json['snow'] as Map<String, dynamic>),
    json['dt_txt'] as String,
  );
}

Map<String, dynamic> _$ListDataToJson(ListData instance) => <String, dynamic>{
      'main': instance.main,
      'wind': instance.wind,
      'rain': instance.rain,
      'snow': instance.snow,
      'dt_txt': instance.dtTxt,
      'weather': instance.weatherList,
    };

Main _$MainFromJson(Map<String, dynamic> json) {
  return Main(
    (json['temp'] as num)?.toDouble(),
    (json['feels_like'] as num)?.toDouble(),
    (json['temp_min'] as num)?.toDouble(),
    (json['temp_max'] as num)?.toDouble(),
    (json['pressure'] as num)?.toDouble(),
    (json['humidity'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.doubleTemp,
      'feels_like': instance.doubleFeelslike,
      'temp_min': instance.doubleTempMin,
      'temp_max': instance.doubleTempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    json['id'] as int,
    json['main'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
    };

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind(
    (json['speed'] as num)?.toDouble(),
    json['deg'] as int,
  );
}

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };

Rain _$RainFromJson(Map<String, dynamic> json) {
  return Rain(
    (json['3h'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RainToJson(Rain instance) => <String, dynamic>{
      '3h': instance.x3h,
    };

Snow _$SnowFromJson(Map<String, dynamic> json) {
  return Snow(
    (json['3h'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SnowToJson(Snow instance) => <String, dynamic>{
      '3h': instance.x3h,
    };

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    json['id'] as int,
    json['name'] as String,
    json['coord'] == null
        ? null
        : Coord.fromJson(json['coord'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coord': instance.coord,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) {
  return Coord(
    (json['lat'] as num)?.toDouble(),
    (json['lon'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };
