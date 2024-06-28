import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_now/controller/global_controller.dart';
import 'package:weather_now/widgets/Current_Weather_Widget.dart';
import 'package:weather_now/widgets/Daily_Data_Widget.dart';
import 'package:weather_now/widgets/header_widget.dart';
import 'package:weather_now/widgets/hourly_data_widget.dart';
import 'package:weather_now/widgets/slider_widget.dart';



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
      backgroundColor: const Color.fromRGBO(254, 255, 255, 1),
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          // only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(30))                      ,
                          color: Color.fromRGBO(11, 163, 255, 3)
                        ),
                        child: Column(
                          children: [
                            const HeaderWidget(),
                        CurrentWeatherWidget(
                            weatherDataCurrent: globalController
                                .getWeatherData()
                                .getCurrentWeather()),
                          ],
                        ),
                      ),
                    ),
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
