import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_now/controller/global_controller.dart';
import 'package:weather_now/widgets/Current_Weather_Widget.dart';
import 'package:weather_now/widgets/Daily_Data_Widget.dart';
import 'package:weather_now/widgets/header_widget.dart';
import 'package:weather_now/widgets/hourly_data_widget.dart';
import 'package:weather_now/widgets/slider_widget.dart';
import '../Themes/theme_manager.dart';

ThemeManager _themeManager = ThemeManager();


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        actions: [
          Switch(
            value: _themeManager.themeMode == ThemeMode.dark,
            onChanged: (newValue) {
              _themeManager.toggleTheme(newValue);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? Center(
                child:Image.asset("assets/loading_screen.gif",
                height: 200,
                width: 200),
              )
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(),
                    const HeaderWidget(),
                    CurrentWeatherWidget(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeather()),
            
                    HourlyDataWidget(
                        weatherDataHourly: globalController
                            .getWeatherData()
                            .getHourlyWeather()),
                    DailyDataWidget(
                        weatherDataDaily: globalController
                            .getWeatherData()
                            .getDailyWeather()),
                    const SizedBox(
                      height: 10,
                    ),
                    ComfortLevel(weatherDataCurrent: globalController
                        .getWeatherData()
                        .getCurrentWeather()),
                    // const Center(
                    //   child: Padding(
                    //     padding: EdgeInsets.only(bottom: 20),
                    //     child: Text(
                    //       "CREATED BY SIDDHANT ADHIKARI",
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontStyle: FontStyle.italic,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )),
      ),
    );
  }
}
