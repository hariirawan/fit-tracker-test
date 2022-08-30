import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/core/models/users.dart';
import 'package:flutter/material.dart';

class UserViewmodel with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('users');

  UserProfile _profile =
      UserProfile(fullName: "", dateOfBirth: '', height: 0, gender: "L");

  UserProfile get profile => _profile;

  Future<void> getProfile() async {
    if (auth.currentUser != null) {
      try {
        final result = await productCollection.doc(auth.currentUser?.uid).get();
        final newData = result.data() as Map<String, dynamic>;
        _profile = UserProfile(
            fullName: newData["fullName"],
            dateOfBirth: newData["dateOfBirth"],
            height: newData['height'],
            gender: newData["L"]);
      } catch (e) {}

      notifyListeners();
    }
  }
}
