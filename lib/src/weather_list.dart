import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproarea/src/weather_base_item.dart';
import 'package:flutterproarea/src/weather_api_data.dart';
import 'package:flutterproarea/src/full_data_view.dart';
import 'package:flutterproarea/src/api_key.dart';
import 'package:flutterproarea/src/db.dart';


class WeatherList extends StatefulWidget {
  static String cityName = '';

  @override
  State<StatefulWidget> createState() {
    return _WeatherListState();
  }

}

class _WeatherListState extends State<WeatherList> {
  int userID = 0;
  List<WeatherDBItem> dataList;

  String language = 'ru';


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

      body: _buildList(),

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
            + WeatherList.cityName.toString() + '&APPID='
            + appID + '&lang='
            + language + '&units=metric');
    if (response.statusCode == 200) {
      Map weatherDataJson = jsonDecode(response.body);

      // For correct display ru/en names of city WeatherList.cityName value
      // changes within DB.transferToBase on actual
      DB.transferToBase(WeatherData.fromJson(weatherDataJson), userID);

      await DB.transferFromBase(WeatherList.cityName).then((listFromBase) => getData(listFromBase));

      }


  }

  getData(List<WeatherDBItem> listFromBase) {

    listFromBase.forEach((element) {
      print('GET DATA: ' + element.toMap().toString());
    });


    dataList = [];
    setState(() {
      dataList.addAll(listFromBase);
    });

  }

  _changeCity(String cityName) {
    WeatherList.cityName = cityName;
    _loadWeather();
  }

  _changeUser() {
    return null;
  }

  _changeLanguage() {
//    DB.db.close();
    language == 'ru' ? language = 'en' : language = 'ru';
    _loadWeather();
  }

  ListView _buildList() {
      return ListView.builder(
          itemCount: dataList == null ? 0 : dataList.length,
          itemBuilder: (BuildContext context, int index) {
            WeatherDBItem data = dataList[index];
            return ListTile(
              onTap: () =>
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => FullDataView(data))),
              title: Text(data.date),
              subtitle: Text(data.description),
              leading: CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  child: Text(data.temperature.toString())),
              trailing: CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,
                  child: Text(data.temperature.toString())),
            );
          }
      );
  }


}