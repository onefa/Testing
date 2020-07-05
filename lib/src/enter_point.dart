import 'package:flutter/material.dart';
import 'package:flutterproarea/src/authorization_page.dart';
import 'package:flutterproarea/src/weather_base_item.dart';
import 'package:flutterproarea/src/weather_list.dart';
import 'package:provider/provider.dart';

class EnterPoint extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final bool isLoggedIn = user != null;

    if (isLoggedIn) {
      print('============================================');
      print ('USER NOT NULL: ' + user.outerID.toString());
      print('email: ' + user.email.toString());
      print('name: ' + user.name.toString());
      print('============================================');
    }
        else print('user == null');

    return isLoggedIn ? WeatherList() : AutorizationPage();

  }
}