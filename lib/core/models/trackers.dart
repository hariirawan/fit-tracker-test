import 'package:cloud_firestore/cloud_firestore.dart';

class Trackers {
  String refrenceID;
  int weight;
  String createdAt;

  Trackers(
      {required this.refrenceID,
      required this.weight,
      required this.createdAt});
}
