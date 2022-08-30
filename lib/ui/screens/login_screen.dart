import 'package:fit_tracker/core/viewmodels/login_viewmodel.dart';
import 'package:fit_tracker/ui/widgets/button_style.dart';
import 'package:fit_tracker/ui/widgets/decoration_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Masuk"),
              const Text("Silahkan masukkan akunmu"),
              const SizedBox(
                height: 17,
              ),
              TextField(
                controller: _username,
                decoration:
                    decorationTextfield(hintText: "Masukkan alamat email"),
              ),
              const SizedBox(
                height: 23,
              ),
              TextField(
                controller: _password,
                obscureText: true,
                decoration:
                    decorationTextfield(hintText: "Masukkan kata sandi"),
              ),
              const SizedBox(
                height: 23,
              ),
              ElevatedButton(
                onPressed: () {
                  authService.signIn(_username.text, _password.text);
                },
                style: btnStyle(),
                child: const Text("Masuk"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
