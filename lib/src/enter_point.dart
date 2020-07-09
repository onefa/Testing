import 'package:flutter/material.dart';
import 'package:flutterproarea/src/authorization_page.dart';
import 'package:flutterproarea/src/weather_base_item.dart';
import 'package:flutterproarea/src/weather_list.dart';
import 'package:flutterproarea/src/db.dart';
import 'package:provider/provider.dart';

class EnterPoint extends StatelessWidget {

  static Future<DBUser> futureUser;
  static DBUser freeUser;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<DBUser>(context);
    bool isLoggedIn = user != null;

    if (isLoggedIn) futureUser = _checkUserInDB(user);
    return isLoggedIn ? WeatherList() : AutorizationPage();

  }

  Future<DBUser> _checkUserInDB (DBUser user) async {
    List<String> outerIDs = [];
    outerIDs.add(user.outerID);
    DBUser getUser = await DB.getUserFromDB(DB.outerID, outerIDs);
    if (getUser == null) await DB.insertUser(user);
    getUser = await DB.getUserFromDB(DB.outerID, outerIDs);
    return getUser;
  }

}