import 'package:flutter/material.dart';

class WStyles {
  static final mainBackColor = Color.fromRGBO(60, 60, 85, 1);
  static final titleColor = Colors.white70;
  static final lightFontColor = Colors.white;
  static final darkFontColor = Colors.black87;

  static final lightBackColor = Color.fromRGBO(132, 176, 132, 1);
  static final darkBackColor = Color.fromRGBO(60, 60, 85, 1);

  static final lightDecorColor = Colors.white70;
  static final midDecorColor = Colors.white54;
  static final darkDecorColor = Colors.black54;

  static final TextStyle titleTextStyle = TextStyle(color: WStyles.titleColor ,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold);

  static final TextStyle inputFieldHintTextStyle = TextStyle(fontWeight: FontWeight.normal,
                                                   fontSize: 20,
                                                   color: Colors.white38);

  static final TextStyle inputFieldTextStyle = TextStyle(fontWeight: FontWeight.bold,
                                               fontSize: 20,
                                               color: WStyles.lightFontColor);

  static final IconThemeData inputFieldIconThemeData = IconThemeData(color: WStyles.titleColor);


  static final BorderSide borderFocusSide = BorderSide(color: WStyles.lightDecorColor,
                                                       width: 3);
  static final BorderSide borderEnabledSide = BorderSide(color: WStyles.midDecorColor,
                                                         width: 1);

  static final buttonBackColor = WStyles.lightBackColor;
  static final buttonSplashColor = WStyles.darkBackColor;
  static final buttonHighlightColor = WStyles.darkBackColor;
  static final TextStyle buttonDarkTextStyle = TextStyle(fontWeight: FontWeight.bold,
                                                     fontSize: 20,
                                                     color: WStyles.darkFontColor);
  static final TextStyle buttonLightTextStyle = TextStyle(fontWeight: FontWeight.normal,
                                                     fontSize: 16,
                                                     color: WStyles.lightFontColor);

  static final toastAlarmBackgroundColor = Colors.redAccent;
  static final toastAlarmTextColor = Colors.yellow;
  static final toastAlarmFontSize = 14.0;

  static final toastInfoBackgroundColor = Colors.blue;
  static final toastInfoTextColor = Colors.white;
  static final toastInfoFontSize = 14.0;

}