import 'package:firebase_core/firebase_core.dart';
import 'package:fit_tracker/core/viewmodels/activity_viewmodel.dart';
import 'package:fit_tracker/core/viewmodels/login_viewmodel.dart';
import 'package:fit_tracker/core/viewmodels/user_viewmodel.dart';
import 'package:fit_tracker/core/viewmodels/weight_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fit_tracker/ui/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewmodel()),
        ChangeNotifierProvider(create: (context) => WeightViewmodel()),
        ChangeNotifierProvider(create: (context) => ActivityViewmodel()),
      ],
      child: MaterialApp(
        title: 'Flutter Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/',
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
