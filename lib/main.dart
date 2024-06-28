import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_now/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
      title: "WEATHER NOW",
      debugShowCheckedModeBanner: false,
    );
  }
}
