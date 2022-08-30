import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/core/models/activity.dart';
import 'package:flutter/material.dart';

class ActivityViewmodel with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('activity');

  bool _isLoading = false;
  List<Activity> _listActivity = [];
  List<Activity> get listActivity => _listActivity;

  get isLoading => _isLoading;

  String? dateActive;

  Future<void> getData({String date = "29"}) async {
    if (auth.currentUser != null) {
      _isLoading = true;
      try {
        List<Activity> newData = [];
        final result = await productCollection
            .doc(auth.currentUser?.uid)
            .collection(date)
            .get();

        for (var element in result.docs) {
          Activity activityModel = Activity(
              id: element.reference.id,
              name: element.get("name"),
              status: element.get('status'));
          newData.add(activityModel);
        }
        _isLoading = false;
        _listActivity = newData;
      } catch (e) {
        _isLoading = false;
      }
      notifyListeners();
    }
  }

  Future<void> updateStatus(String id, bool status) async {
    if (auth.currentUser != null) {
      try {
        await productCollection
            .doc(auth.currentUser?.uid)
            .collection("29")
            .doc(id)
            .update({"status": status});
        getData();
      } catch (e) {}
    }
  }
}
