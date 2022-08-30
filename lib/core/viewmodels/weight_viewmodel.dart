import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tracker/core/models/trackers.dart';
import 'package:flutter/material.dart';

class WeightViewmodel with ChangeNotifier {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('fit-tracker');
  List<Trackers> _data = [];
  late Trackers trackerModel;

  List<Trackers> get dataTrackers => _data;

  Future getDataTracker() async {
    List<Trackers> newData = [];
    QuerySnapshot result =
        await productCollection.orderBy('createdAt', descending: true).get();

    for (var element in result.docs) {
      trackerModel = Trackers(
          refrenceID: element.reference.id,
          weight: element.get('weight'),
          createdAt: element.get('createdAt'));
      newData.add(trackerModel);
    }

    _data = newData;
    notifyListeners();
  }

  Future<void> addData({String? createdAt, int? weight}) async {
    try {
      DocumentReference result = await productCollection
          .add({'createdAt': createdAt, 'weight': weight});
      getDataTracker();
    } catch (e) {
      print(
        "error $e",
      );
    }
  }

  Future<void> deleteData(String id) async {
    productCollection.doc(id).delete().then((value) {
      getDataTracker();
    });
  }

  void updateData(String id, String weight) {
    productCollection
        .doc(id)
        .update({'weight': int.parse(weight)}).then((value) {
      getDataTracker();
    });
  }
}
