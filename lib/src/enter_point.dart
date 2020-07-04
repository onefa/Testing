import 'package:flutter/material.dart';
import 'package:flutterproarea/src/authorization.dart';
import 'package:flutterproarea/src/pro_area_app.dart';

class EnterPoint extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = false;

    return isLoggedIn ? ProAreaApp() : AutorizationPage();

  }
}