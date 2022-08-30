import 'package:fit_tracker/core/viewmodels/activity_viewmodel.dart';
import 'package:fit_tracker/ui/widgets/button_style.dart';
import 'package:fit_tracker/ui/widgets/date_box.dart';
import 'package:fit_tracker/ui/widgets/decoration_textfield.dart';
import 'package:fit_tracker/ui/widgets/item_activity.dart';
import 'package:fit_tracker/ui/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

enum Status { active, nonactive }

class _ActivityScreenState extends State<ActivityScreen> {
  late ActivityViewmodel activityProvider;
  final TextEditingController _name = TextEditingController();
  Status? _character = Status.active;

  @override
  void initState() {
    ActivityViewmodel activityProvider =
        Provider.of<ActivityViewmodel>(context, listen: false);

    activityProvider.getData();
    super.initState();
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  TextField(
                    controller: _name,
                    keyboardType: TextInputType.number,
                    decoration:
                        decorationTextfield(hintText: "Nama Aktifitas Anda"),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ListTile(
                        title: const Text('Active'),
                        contentPadding: EdgeInsets.all(0),
                        leading: Radio<Status>(
                          value: Status.active,
                          groupValue: _character,
                          onChanged: (Status? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      )),
                      Expanded(
                        child: ListTile(
                          dense: false,
                          title: const Text('Non Active'),
                          leading: Radio<Status>(
                            value: Status.nonactive,
                            groupValue: _character,
                            onChanged: (Status? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: btnStyle(),
                    child: const Text("Simpan"),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    activityProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text("Aktifitas Harian"),
      ),
      body: activityProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const Dates(),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Aktifitas Hari Ini",
                        style: text16(fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {
                          _showModalBottomSheet(context);
                        },
                        child: Text(
                          "Tambah",
                          style: text16(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                    children: List.generate(
                        activityProvider.listActivity.length, (index) {
                  final listAct = activityProvider.listActivity[index];
                  return ItemActivity(
                    name: listAct.name,
                    status: listAct.status,
                    onTap: () {
                      activityProvider.updateStatus(
                          listAct.id, !listAct.status);
                    },
                  );
                }))
              ],
            ),
    );
  }
}

class Dates extends StatelessWidget {
  const Dates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DateBox> dateBox = [];
    DateTime date = DateTime.parse('2022-08-29');

    for (var i = 0; i < 6; i++) {
      dateBox.add(DateBox(date: date));
      date = date.add(const Duration(days: 1));
    }

    return Container(
      width: double.infinity,
      color: Colors.green,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: dateBox,
      ),
    );
  }
}
