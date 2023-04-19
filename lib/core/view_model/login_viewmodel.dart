import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
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
      isUserLoggingIn(false);
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
}
