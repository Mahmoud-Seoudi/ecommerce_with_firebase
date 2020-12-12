import 'package:flutter/material.dart';
import 'package:store_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // remove banner from screen
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
