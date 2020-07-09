import 'package:flutter/material.dart';

class WStyles {
  static final mainBackColor = Color.fromRGBO(60, 60, 85, 1);
  static final titleColor = Colors.white70;
  static final lightFontColor = Colors.white;
  static final darkFontColor = Colors.black87;

  static final lightBackColor = Color.fromRGBO(132, 176, 132, 1);
  static final darkBackColor = Color.fromRGBO(50, 50, 75, 1);

  static final lightDecorColor = Colors.white70;
  static final midDecorColor = Colors.white54;
  static final darkDecorColor = Colors.black54;

  //List
  static final listRowsPerScreen = 9;
  double listItemExtent (BuildContext context) {
    double itemExtent = MediaQuery.of(context).size.height/listRowsPerScreen;
    if (MediaQuery.of(context).size.height < MediaQuery.of(context).size.width) {
      itemExtent *= 1.5;
    }
    return itemExtent;
  }
  static final listTextColor = Colors.black;
  static final listBackgroundColor = Colors.white60;
  static final listSelectedTextColor = Colors.black;
  static final listSelectedBackgroundColor = Colors.greenAccent;


  //Border
  static final BorderSide borderFocusSide = BorderSide(color: WStyles.lightDecorColor,
      width: 3);
  static final BorderSide borderEnabledSide = BorderSide(color: WStyles.midDecorColor,
      width: 1);


  //Text
  static final TextStyle titleTextStyle = TextStyle(color: WStyles.titleColor ,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold);

  static final TextStyle hintLightTextStyle = TextStyle(fontWeight: FontWeight.normal,
                                          fontSize: 20,
                                          color: Colors.white54);

  static final TextStyle inputFieldTextStyle = TextStyle(fontWeight: FontWeight.normal,
                                          fontSize: 20,
                                          color: WStyles.lightFontColor);

  static final TextStyle notificationTextStyle = TextStyle(fontWeight: FontWeight.normal,
                                          fontSize: 20,
                                          color: WStyles.darkFontColor,
                                          );

  //Button
  static final buttonBackColor = WStyles.lightBackColor;
  static final buttonSplashColor = WStyles.darkBackColor;
  static final buttonHighlightColor = WStyles.darkBackColor;

  static final TextStyle buttonDarkTextStyle = TextStyle(fontWeight: FontWeight.bold,
                                                     fontSize: 20,
                                                     color: WStyles.darkFontColor);
  static final TextStyle buttonLightTextStyle = TextStyle(fontWeight: FontWeight.normal,
                                                     fontSize: 16,
                                                     color: WStyles.lightFontColor);

  // Toast
  static final toastAlarmBackgroundColor = Colors.redAccent;
  static final toastAlarmTextColor = Colors.yellow;
  static final toastAlarmFontSize = 14.0;

  static final toastInfoBackgroundColor = Colors.blue;
  static final toastInfoTextColor = Colors.white;
  static final toastInfoFontSize = 14.0;

}