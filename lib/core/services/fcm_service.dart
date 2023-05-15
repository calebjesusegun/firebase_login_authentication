import 'package:firebase_login_authentication/core/services/network_service.dart';
import 'package:firebase_login_authentication/core/services/push_notification_service.dart';

import '../app/app_locator.dart';

class FcmService {
  final _pushMessagingNotification = locator<PushNotificationService>();
  final _networkHelper = locator<NetworkServiceRepository>();

  final url = "https://fcm.googleapis.com/fcm/send";
  final _domain = "fcm.googleapis.com";
  final _subDomain = "fcm/send";
  final _serverKey =
      "AAAAoL2iqiM:APA91bFEDxadsr28hvgNspJ0PS0gmE8y40kxn7d9RJNshLpgGxgmTqQIFzPHE9WE7NrVerUbSboPJhSZUzAKra-8Ca810STWfAZQgpG1OHc04-ke57SO_1trUZQnJcUALtq-6NZM9JkL";

// Method to send push notification
  Future sendPushNotification() async {
    Map<String, String> header = {
      'Authorization': 'key=$_serverKey',
      'Content-type': 'application/json',
      'Accept': '/',
    };

    var deviceToken = _pushMessagingNotification.deviceToken;

    var fakeBody = {
      "to": deviceToken,
      "mutuable_content": true,
      "priority": "high",
      "data": {
        "title": "Login Successful",
        "body":
            "You are successfully authenticated into the app. Click on the push notification pop-up to navigate to the homepage",
        "type": "home",
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
      },
      "notification": {
        "title": "Login Successful",
        "body":
            "You are successfully authenticated into the app. Click on the push notification pop-up to navigate to the homepage"
      }
    };

    //"to":
    //    "ftkr7KJNSSaJQ2opGUbp5A:APA91bHjz2pWUesDt_7I6-Ig-hLHGIlJQFGgDQ79o5YYIfgfSDTAKjY0f5pL4i3LfivDl_IRGIPIPzCoJWumS6uARV3coq-HX8bKpZOvTwx4pyGKVjm-Jlv2hvCYlktnrMcr9HxcUa-c",
    //"priority": "high",

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
