import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/core/models/users.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  UserModel? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(user.uid, user.email);
  }

  Future<UserModel?> signIn(String email, String password) async {
    final credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }
}
