import 'package:flutter/material.dart';
import 'package:flutterproarea/src/w_styles.dart';
import 'package:flutterproarea/src/weather_base_item.dart';

class FullDataView extends StatelessWidget {
  final WeatherDBItem fullData;

  FullDataView(this.fullData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(fullData.city,
                      maxLines: 2,
                      ),
          backgroundColor: WStyles.mainBackColor,
          centerTitle: true,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
                SizedBox(height: 40,),
                  Text(fullData.date, style: TextStyle(fontSize: 22, height: 1.2),),
                  Text(fullData.description, style: TextStyle(fontSize: 18, height: 1.2),),
                  Text('Температура: ' + fullData.temperature.toString()),
                  Text('Дождь: ' + fullData.rain.toString()),
                  Text('Снег: ' + fullData.snow.toString()),
                  Text('Скорость ветра: ' + fullData.windSpeed.toString()),
                  Text('Направление ветра: ' + fullData.windDegree.toString()),
                  Text('Влажность: ' + fullData.humidity.toString()),
                  Text('Давление: ' + fullData.pressure.toString()),
            ],
          )
      ),
    );
  }
}