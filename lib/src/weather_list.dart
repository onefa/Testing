import 'dart:ui';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:flutterproarea/src/authorization_page.dart';
import 'package:flutterproarea/src/authorization_service.dart';
import 'package:flutterproarea/src/enter_point.dart';
import 'package:flutterproarea/src/w_styles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutterproarea/src/weather_base_item.dart';
import 'package:flutterproarea/src/weather_api_data.dart';
import 'package:flutterproarea/src/full_data_view.dart';
import 'package:flutterproarea/src/api_key.dart';
import 'package:flutterproarea/src/db.dart';
import 'package:geolocator/geolocator.dart';
import '../main.dart';

class WeatherList extends StatefulWidget {
  static String cityName = '';
  static int cityID;
  static String language = ui.window.locale.toString().substring(0,2);
  static bool newEntry = true;
  static bool logOut = false;

  @override
  State<StatefulWidget> createState() {
    return _WeatherListState();
  }

}

Future<void> getFromAPIBackground(int cityID) async {
  if (cityID != null) {
    await getWeatherFromAPI(cityID: cityID);
  }
}

Future<void> getWeatherFromAPI({String cityName, int cityID, double latitude, double longitude}) async {
  String appID = ApiKey().key;
  String language = WeatherList.language;
  String request = 'http://api.openweathermap.org/data/2.5/forecast?';

  if (cityName != null) {
    request += 'q=$cityName';
  } else if (cityID != null) {
    request += 'id=$cityID';
  } else if (latitude != null && longitude != null) {
    request += 'lat=$latitude&lon=$longitude';
  }

  request += '&APPID=' + appID.toString() + '&lang=' + language.toString() + '&units=metric';
  final response = await http.get(request);
  if (response.statusCode == 200) {
    Map weatherDataJson = jsonDecode(response.body);
    DB.transferToBase(WeatherAPIData.fromJson(weatherDataJson));
  }
  return;
}

class _WeatherListState extends State<WeatherList> {

  List<WeatherDBItem> dataList;
  TextEditingController cityNameController = TextEditingController();
  ScrollController scrollController = ScrollController();
  double scrollOffset;
  double listItemExtent;
  int indexNow;
  Icon dropDownIcon = Icon(Icons.access_time);
  bool dropDownHourly = true;
  DBUser nowUser;

  copyUserData() async {
    nowUser =  await EnterPoint.futureUser;
    WeatherList.cityID = nowUser.userCityID;
    if (nowUser.userCityID != null) {
      _getCityIDWeather();
    } else {
      _getLocationWeather();
    }
    WeatherList.newEntry = false;
  }

  @override
  Widget build(BuildContext context) {

    if (WeatherList.logOut) {
      WeatherList.logOut = false;
      return AutorizationPage();
    }

    listItemExtent = WStyles().listItemExtent(context);
    if (WeatherList.newEntry) copyUserData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: WStyles.mainBackColor,
        title: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(0),
              ),
            ),
            fillColor: WStyles.darkBackColor,
            filled: true,
            hintText: WeatherList.cityName,
            hintStyle: WStyles.hintLightTextStyle,
          ),

          style: WStyles.inputFieldTextStyle,
          controller: cityNameController,
          onFieldSubmitted: (String cityName) => _getCityWeather(),
        ),

        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: _hourlyDailyList(),
          ),

          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: FlatButton(
              child: Text(WeatherList.language),
              onPressed: () => _changeLanguage(),
            ),
          )
        ],
      ),

      body: _buildList(),

      floatingActionButton: FloatingActionButton.extended(
        label: Text('LogOUT'),
        onPressed: () => _logOutLogic(),
      )
    );
  }

  _logOutLogic() {
    AuthService().logOutFirebase();
    WeatherList.newEntry = true;
    WeatherList.cityID = null;
    WeatherList.cityName = '';
    EnterPoint.freeUser = null;
    setState(() {
      WeatherList.logOut = true;
    });
  }

  _hourlyDailyList() {
    return DropdownButton<bool>(
      icon: dropDownIcon,
      iconEnabledColor: WStyles.lightDecorColor,
      onChanged: (bool newValue) {
        setState(() {
          dropDownHourly = newValue;
          dropDownIcon = dropDownHourly ? Icon(Icons.access_time) : Icon(Icons.calendar_today);
          _getData();
        });
      },
      items: <bool>[true, false]
          .map<DropdownMenuItem<bool>>((bool hourly) {
        return DropdownMenuItem<bool>(
          value: hourly,
          child: hourly ? Icon(Icons.access_time) : Icon(Icons.calendar_today),
        );
      }).toList(),
    );
  }

  _getCityIDWeather() async {
    await getWeatherFromAPI(cityID: WeatherList.cityID);
    _alarmAPIControl();
    _getData();
  }

  _getLocationWeather() async {
    Position position = await Geolocator().getCurrentPosition();
    await getWeatherFromAPI(latitude: position.latitude, longitude: position.longitude);
    _getData();
    nowUser.setCityID(WeatherList.cityID);
    await DB.insertUser(nowUser);
  }

  _getCityWeather() async {
    if (cityNameController.text.isNotEmpty) WeatherList.cityName = cityNameController.text;
    cityNameController.clear();
    _getData();
    await getWeatherFromAPI(cityName: WeatherList.cityName);
    nowUser.setCityID(WeatherList.cityID);
    await DB.insertUser(nowUser);
    _alarmAPIControl();
    _getData();
  }

  _alarmAPIControl() async {
    if ( ! MyApp.alarmAPISavedCities.contains(WeatherList.cityID) ) {
      if (MyApp.alarmAPISavedCities.length >= MyApp.maxSavedCities)
        await AndroidAlarmManager.cancel(MyApp.alarmAPISavedCities.removeAt(0));
      MyApp.alarmAPISavedCities.add(WeatherList.cityID);
      await AndroidAlarmManager.periodic(Duration(minutes: MyApp.loadNewForecastMinutes), WeatherList.cityID, getFromAPIBackground);
    }
  }

  _getData() async {
    List<WeatherDBItem> listFromBase = await DB.transferFromBase(WeatherList.cityName);

    dataList = [];
    if (dropDownHourly) {
      dataList.addAll(listFromBase);
    } else {
      listFromBase.forEach((element) {
        DateTime itemDateTime = DateTime.parse(element.date);
        if (dataList.isNotEmpty) {
          DateTime lastInList = DateTime.parse(dataList[dataList.length-1].date);
          if (itemDateTime.day != lastInList.day &&
              itemDateTime.hour == 12) {
            dataList.add(element);
          }
        } else {
          dataList.add(element);
        }
      });
    }

    WeatherList.cityID = dataList[dataList.length-1].cityID;

    setState(() {
      var now = DateTime.now();
      indexNow = -1;
      DateTime itemDateTime;
      do {
        ++indexNow;
        itemDateTime = DateTime.parse(dataList[indexNow].date);
      } while ((indexNow < dataList.length) &&
          !(itemDateTime.year == now.year &&
            itemDateTime.month == now.month &&
            itemDateTime.day == now.day &&
            (!dropDownHourly || (0 <= (now.hour - itemDateTime.hour) &&
            (now.hour - itemDateTime.hour) < 3))));

      scrollOffset = indexNow * listItemExtent;
      });
  }

  _changeLanguage() {
    WeatherList.language == 'ru' ? WeatherList.language = 'en' : WeatherList.language = 'ru';
    _getCityWeather();
  }

  _buildList() {
    var buildedList = ListView.builder(
        controller: scrollController,
        itemExtent: listItemExtent,
        itemCount: dataList == null ? 0 : dataList.length,
        itemBuilder: (BuildContext context, int index) {
          WeatherDBItem data = dataList[index];
          bool selectItem  = indexNow == index ? true : false;

          return ListTileTheme(
            selectedColor: WStyles.listSelectedTextColor,
            textColor: WStyles.listTextColor,
            child: Container(
                color: selectItem ? WStyles.listSelectedBackgroundColor : WStyles.listBackgroundColor,
                child: ListTile(
                  selected: selectItem,
                  onTap: () =>
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => FullDataView(data))),
                  title: Text(data.date),
                  subtitle: Text(data.description),
                  leading: CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent,
                      child: Text(data.temperature.toString())),
                )
            ),
          );
        }
    );

    _scrollToNow();
    return buildedList;
  }

  _scrollToNow() async {
    if (scrollOffset != null) {
      await scrollController.animateTo(
            scrollController.initialScrollOffset + scrollOffset,
            curve: Curves.linear, duration: Duration(milliseconds: 500));
    }
  }

}

