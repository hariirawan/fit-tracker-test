import 'package:fit_tracker/core/viewmodels/activity_viewmodel.dart';
import 'package:fit_tracker/ui/widgets/text_style.dart';
import 'package:fit_tracker/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateBox extends StatelessWidget {
  final bool isActive;
  final DateTime date;
  const DateBox({Key? key, this.isActive = false, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActivityViewmodel activityProvider =
        Provider.of<ActivityViewmodel>(context);

    return InkWell(
      onTap: () {
        activityProvider.getData(date: date.day.toString());
        activityProvider.dateActive = date.day.toString();
      },
      child: Container(
        width: 55,
        height: 80,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: activityProvider.dateActive == date.day.toString()
                ? Colors.green[800]
                : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(daysOfWeek[date.weekday]!),
            const SizedBox(
              height: 8,
            ),
            Text(
              date.day.toString().padLeft(2, '0'),
              style: text16(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
