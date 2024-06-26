import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_now/controller/global_controller.dart';
import 'package:weather_now/model/weather_data_hourly.dart';
import 'package:geocoding/geocoding.dart';

class HourlyDataWidget extends StatefulWidget {
  final WeatherDataHourly weatherDataHourly;
  const HourlyDataWidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  @override
  State<HourlyDataWidget> createState() => _HourlyDataWidgetState();
}

class _HourlyDataWidgetState extends State<HourlyDataWidget> {
  String city = "";

  RxInt cardIndex = GlobalController().getIndex();

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          city,
          style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            height: 2,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 10),
          child: const Text("TODAY",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        ),
        hourlyList()
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.weatherDataHourly.hourly.length > 12
            ? 20
            : widget.weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(() => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                width: 80,
                margin: const EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    gradient: cardIndex.value == index
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                                Colors.black,
                                Colors.black,
                              ])
                        : null),
                child: HourlyDetails(
                  temp: widget.weatherDataHourly.hourly[index].temp!,
                  timeStamp: widget.weatherDataHourly.hourly[index].dt!,
                  weatherIcon:
                      widget.weatherDataHourly.hourly[index].weather![0].icon!,
                ),
              )));
        },
      ),
    );
  }
}

class HourlyDetails extends StatefulWidget {
  int temp;
  int timeStamp;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon});

  @override
  State<HourlyDetails> createState() => _HourlyDetailsState();
}

class _HourlyDetailsState extends State<HourlyDetails> {
  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(getTime(widget.timeStamp),
            style: const TextStyle(
                color: Colors.lightBlueAccent, fontWeight: FontWeight.bold)),
        Image.asset(
          "assets/weather/${widget.weatherIcon}.png",
          height: 40,
          width: 40,
        ),
        Text("${widget.temp}°",
            style: const TextStyle(
                color: Colors.lightBlueAccent, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
