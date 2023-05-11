import 'dart:io';

import 'package:firebase_login_authentication/core/navigation/navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../navigation/route.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    if (Platform.isIOS) {
      //Requires IOS permission
      await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    // ignore: unused_element
    Future getDeviceToken() async {
      var deviceToken = "";
      await FirebaseMessaging.instance.getToken().then((token) {
        deviceToken = token!;
      });
      return deviceToken;
    }

    // This function routes to a screen named home if the data property received has a type of home
    void handleMessage(RemoteMessage message) {
      if (message.data['type'] == 'home') {
        AppNavigator.pushNamedReplacement(homeRoute);
      }
    }

    Future<void> backgroundMessage() async {
      // This retrieves any message which caused the application to open from a terminated state
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      // To handle routing we need to check if the push notification response message contains a data property from the backend to specify the "type" of screen to navigate to when the user clicks on the notification
      if (initialMessage != null) {
        handleMessage(initialMessage);
      }

      // This handles any interaction when the app is open but in the background and not terminated through a stream listener
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    }
  }
}
