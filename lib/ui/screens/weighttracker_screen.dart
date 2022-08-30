import 'package:fit_tracker/core/viewmodels/weight_viewmodel.dart';
import 'package:fit_tracker/ui/widgets/button_style.dart';
import 'package:fit_tracker/ui/widgets/decoration_textfield.dart';
import 'package:fit_tracker/ui/widgets/tracker_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeightTrackerScreen extends StatefulWidget {
  const WeightTrackerScreen({Key? key}) : super(key: key);

  @override
  State<WeightTrackerScreen> createState() => _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends State<WeightTrackerScreen> {
  final TextEditingController _weightController = TextEditingController();
  late WeightViewmodel provider;
  String refrenceID = '';

  @override
  void initState() {
    WeightViewmodel provider =
        Provider.of<WeightViewmodel>(context, listen: false);
    provider.getDataTracker();
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
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration:
                        decorationTextfield(hintText: "Masukkan berat badan"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (refrenceID != '') {
                        provider.updateData(refrenceID, _weightController.text);
                        refrenceID = '';
                      } else {
                        final now = DateTime.now();
                        provider.addData(
                            createdAt: now.toString(),
                            weight: int.parse(_weightController.text));
                      }
                      _weightController.text = "";
                      Navigator.pop(context);
                    },
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
    provider = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          title: const Text("Berat (kg)"),
          actions: [
            InkWell(
              onTap: () => _showModalBottomSheet(context),
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                children: List.generate(
                    provider.dataTrackers.length,
                    (index) => TrackerItem(
                          createdAt: provider.dataTrackers[index].createdAt,
                          weight: provider.dataTrackers[index].weight,
                          onEdit: () {
                            _showModalBottomSheet(context);
                            refrenceID =
                                provider.dataTrackers[index].refrenceID;
                            _weightController.text =
                                provider.dataTrackers[index].weight.toString();
                          },
                          onPress: () => provider.deleteData(
                              provider.dataTrackers[index].refrenceID),
                        )),
              ),
            ],
          ),
        ));
  }
}
