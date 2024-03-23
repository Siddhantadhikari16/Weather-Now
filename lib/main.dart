import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_now/Themes/theme_constants.dart';
import 'package:weather_now/screens/home_screen.dart';
import 'Themes/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  void themeListener() {
    print("Theme listener triggered");
    if (mounted) {
      setState(() {
        // Handle theme change if necessary
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const HomeScreen(),
      title: "WEATHER NOW",
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}
