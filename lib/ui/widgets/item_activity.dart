import 'package:fit_tracker/ui/widgets/text_style.dart';
import 'package:flutter/material.dart';

class ItemActivity extends StatelessWidget {
  final String name;
  final bool status;
  final Function onTap;

  const ItemActivity(
      {Key? key, required this.name, required this.status, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: text16(fontWeight: FontWeight.bold),
            ),
            Text(
              "22:00",
              style: text16(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: status ? Colors.green : Colors.grey[200]),
            child: Icon(
              Icons.check,
              color: status ? Colors.white : Colors.grey[300],
            ),
          ),
        )
      ]),
    );
  }
}
