import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterproarea/src/w_styles.dart';

class FCM {

    static final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    FCM();
    initMessaging() {

      firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> message) async {
            if (message['notification'] != null) {
              var notification = message['notification'];
              _notificationToast(notification);
            }
            return;
          },
          onLaunch: (Map<String, dynamic> message) async {
            return;
          },
          onResume: (Map<String, dynamic> message) async {
            return;
          }
      );
      firebaseMessaging.setAutoInitEnabled(true);
      firebaseMessaging.requestNotificationPermissions();
    }

    _notificationToast(var notification) {
      BotToast.showNotification(
        title: (text()) => Text(notification['title'],
              style: WStyles.notificationTextStyle,),
        subtitle: (text()) => Text(notification['body'],
              style: WStyles.notificationTextStyle,),
        duration: Duration(seconds: 30),
        contentPadding: EdgeInsets.all(50.0),
        align: Alignment.center,
        enableSlideOff: true,
      );
    }

}