import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutterproarea/src/weather_data.dart';
import 'api_key.dart';


class WeatherList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _WeatherListState();
  }

}

class _WeatherListState extends State<WeatherList> {
  WeatherData dataList = WeatherData.start();
  String language = 'ru';
  String cityName = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(0),
              ),
            ),

            fillColor: Colors.black26,
            filled: true,
            hintText: 'Weather in City',
          ),

          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          onChanged: (String city) => _changeCity(city),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => null,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: FlatButton(
              child: Text(language),
              onPressed: () => _changeLanguage(),
            ),
          )
        ],

      ),

      body: Container(
        child: ListView(
          children: _buildList(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('User'),
        onPressed: () => _changeUser(),
      ),
    );
  }


  _loadWeather() async {
    String appID = ApiKey().key;
    final response = await http.get(
        'http://api.openweathermap.org/data/2.5/forecast?q='
            + cityName.toString() + '&APPID='
            + appID + '&lang='
            + language + '&units=metric');
    if (response.statusCode == 200) {
      Map weatherDataJson = jsonDecode(response.body);
      setState(() {
        dataList = WeatherData.fromJson(weatherDataJson);
      });
    }
  }

  _changeCity(String cityName) {
    this.cityName = cityName;
    _loadWeather();
  }

  _changeUser() {
    return null;
  }

  _changeLanguage() {
    language == 'ru' ? language = 'en' : language = 'ru';
    _loadWeather();
  }

  List<Widget> _buildList() {
      return dataList.list.map((ListData data) =>
          ListTile(
            title: Text(data.dtTxt),
            subtitle: Text(data.weather.description),
            leading: CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Text(data.main.tempMin.toString())),
            trailing: CircleAvatar(
                backgroundColor: Colors.lightBlueAccent,
                child: Text(data.main.tempMax.toString())),
          )).toList();
  }
}