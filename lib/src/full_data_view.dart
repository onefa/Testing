import 'package:flutter/material.dart';
import 'package:flutterproarea/src/weather_base_item.dart';

class FullDataView extends StatelessWidget {
  final WeatherDBItem fullData;

  FullDataView(this.fullData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(fullData.city,
                      maxLines: 2,),
                      centerTitle: true,),
      body: Center(
          child: Column(
            children: <Widget>[
              Text(fullData.date),
              Text(fullData.description),
              Text('Humidity: ' + fullData.humidity.toString()),
              Text('Pressure: ' + fullData.pressure.toString()),
              Text('Temperature: ' + fullData.temperature.toString()),


      ],
          )
      ),
    );
  }
}