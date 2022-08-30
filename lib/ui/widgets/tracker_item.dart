import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrackerItem extends StatelessWidget {
  final String createdAt;
  final int weight;
  final Function? onPress;
  final Function? onEdit;
  TrackerItem(
      {required this.createdAt,
      required this.weight,
      required this.onPress,
      this.onEdit});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.parse(createdAt.toString());
    String date = DateFormat('EEEE yyyy-MM-dd').format(now);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              Text(
                "$weight Kg",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                  child: const Icon(Icons.edit),
                  onTap: () {
                    onEdit!();
                  }),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  child: const Icon(Icons.delete),
                  onTap: () {
                    onPress!();
                  })
            ],
          )
        ],
      ),
    );
  }
}
