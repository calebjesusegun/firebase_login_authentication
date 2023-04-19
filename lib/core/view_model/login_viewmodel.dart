import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  String? getUserId() {
    return auth.currentUser?.uid;
  }

  String getEmail() {
    return auth.currentUser!.email!;
  }

  Future<String?> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // log('The password is too weak');
      }
      return e.message;
    } catch (e) {
      // log(e.toString());
      return e.toString();
    }
  }

  void logout() async {
    await auth.signOut();
    notifyListeners();
  }
}
