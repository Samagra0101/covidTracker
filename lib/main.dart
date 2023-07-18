import 'package:flutter/material.dart';
import 'package:covid_app/view/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CovidApp',
      home: SplashScreen(),
    );
  }
}
