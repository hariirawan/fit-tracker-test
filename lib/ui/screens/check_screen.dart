import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/core/viewmodels/login_viewmodel.dart';
import 'package:fit_tracker/ui/screens/home_screen.dart';
import 'package:fit_tracker/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginViewModel>(context);
    return StreamBuilder<User?>(
        stream: authProvider.streamAuthStatus,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null ? LoginScreen() : HomeScreen();
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
