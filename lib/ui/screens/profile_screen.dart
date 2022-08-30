import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/core/viewmodels/login_viewmodel.dart';
import 'package:fit_tracker/core/viewmodels/user_viewmodel.dart';
import 'package:fit_tracker/ui/widgets/button_style.dart';
import 'package:fit_tracker/ui/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserViewmodel userProvider;

  @override
  void initState() {
    UserViewmodel userViewmodel =
        Provider.of<UserViewmodel>(context, listen: false);
    userViewmodel.getProfile();
    super.initState();
  }

  Widget itemProfile({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: text14(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: text14(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of(context);
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Profile"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            itemProfile(
                label: "Nama Lengkap",
                value: userProvider.profile.fullName.toString()),
            itemProfile(
                label: "Tanggal Lahir",
                value: userProvider.profile.dateOfBirth.toString()),
            itemProfile(
                label: "Jenis Kelamin",
                value: userProvider.profile.gender == "L"
                    ? "Laki-laki"
                    : "Perempuan"),
            itemProfile(
                label: "Tinggi Badan",
                value: userProvider.profile.height.toString() + " cm"),
            ElevatedButton(
                onPressed: () {
                  loginViewModel.signOut();
                },
                style: btnStyle(),
                child: Text("Keluar"))
          ],
        ),
      ),
    );
  }
}
