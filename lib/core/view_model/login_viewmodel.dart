import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_authentication/core/navigation/navigation.dart';
import 'package:flutter/material.dart';
import '../app/app_locator.dart';
import '../model/push_notification_model.dart';
import '../navigation/route.dart';
import '../services/fcm_service.dart';

class LoginViewModel extends ChangeNotifier {
  final _fcmService = locator<FcmService>();
  final auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  String? getUserId() {
    return auth.currentUser?.uid;
  }

  String getEmail() {
    return auth.currentUser!.email!;
  }

  void isUserLoggingIn(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    try {
      isUserLoggingIn(true);
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      isUserLoggingIn(false);
      return e.message;
    } catch (e) {
      isUserLoggingIn(false);
      return e.toString();
    }
  }

  void logout() async {
    await auth.signOut();
    notifyListeners();
  }

  Future sendPushNotification() async {
    try {
      var data = await _fcmService.sendPushNotification();
      isUserLoggingIn(false);
      notifyListeners();
      PushNotificationModel pushNotificationModel =
          PushNotificationModel.fromJson(data);
      if (pushNotificationModel.success == 1) {
        return data;
      }
    } catch (e) {
      AppNavigator.pushNamedReplacement(homeRoute);
    }
  }
}
