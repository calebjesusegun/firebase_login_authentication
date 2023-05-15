import 'package:firebase_login_authentication/core/services/network_service.dart';
import 'package:firebase_login_authentication/core/services/push_notification_service.dart';

import '../app/app_locator.dart';

class FcmService {
  final _pushMessagingNotification = locator<PushNotificationService>();
  final _networkHelper = locator<NetworkServiceRepository>();

  final url = "https://fcm.googleapis.com/fcm/send";
  final _domain = "fcm.googleapis.com";
  final _subDomain = "fcm/send";
  final _serverKey = "<SERVER KEY>";

// Method to send push notification
  Future sendPushNotification() async {
    Map<String, String> header = {
      'Authorization': 'key=$_serverKey',
      'Content-type': 'application/json',
      'Accept': '/',
    };

    var deviceToken = _pushMessagingNotification.deviceToken;

    var body = {
      "to": deviceToken,
      "priority": "high",
      "notification": {
        "title": "Login Successful",
        "body":
            "You are successfully authenticated into the app. Click on the push notification pop-up to navigate to the homepage",
        "sound": "default"
      },
      "data": {
        "title": "Login Successful",
        "body":
            "You are successfully authenticated into the app. Click on the push notification pop-up to navigate to the homepage",
        "type": "home",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    };

    var data = await _networkHelper.postData(
      domain: _domain,
      subDomain: _subDomain,
      header: header,
      isJson: true,
      body: body,
    );
    return data;
  }
}
