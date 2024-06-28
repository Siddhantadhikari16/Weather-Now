import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_now/model/weather_data_current.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeatherWidget({super.key, required this.weatherDataCurrent});

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  final _textController = TextEditingController();
  String city = '';
  bool cityFound = false;

  void getData() async {
    // Replace 'YOUR_API_KEY' with your actual OpenWeatherMap API key
    final uri = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=179e2260f583c2831cecf60ceb1caadd");
    try {
      final response = await get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final coorData = data['coord'];
        final lon = coorData['lon'];
        print(lon);
        final kelvinTemp = data['main']['temp'];
        final celsiusTemp = kelvinTemp - 273.15;

        setState(() {
          cityFound = true;
          widget.weatherDataCurrent.current.temp = celsiusTemp.round();
          widget.weatherDataCurrent.current.windSpeed = data['wind']['speed'];
          widget.weatherDataCurrent.current.humidity = data['main']['humidity'];
          widget.weatherDataCurrent.current.clouds = data['clouds']['all'];
          widget.weatherDataCurrent.current.weather = [
            Weather(
                main: data['weather'][0]['main'],
                description: data['weather'][0]['description'],
                icon: data['weather'][0]['icon']),
          ];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Please Enter A Valid City Name.'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
            // action: SnackBarAction(
            //   label: 'Ok',
            //   onPressed: () =>
            //       ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            // ),
          ),
        );
        setState(() {
          cityFound = false; // Reset cityFound flag on error
        });
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        temperatureAreaWidget(),
        currentWeatherInDetail(),
        searchBar(_textController)
      ],
    );
  }

  Widget temperatureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(
                    "assets/weather/${widget.weatherDataCurrent.current.weather![0].icon}.png",
                    fit: BoxFit.fill,
                    width: 80,
                    height: 80),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_searching_outlined,
                    color: Colors.amberAccent,
                  ),
                  cityFound
                      ? Text(' $city',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25))
                      : Container(),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 10),
          child: Container(
            height: 70,
            width: 2,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Container(
            width: 225,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text:
                        ("${widget.weatherDataCurrent.current.temp!.toInt()}°"),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 70,
                        color: Colors.white)),
                TextSpan(
                    text:
                        ("${widget.weatherDataCurrent.current.weather![0].description}"),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                      color: Colors.white,
                    ))
              ])),
            ),
          ),
        )
      ],
    );
  }

  Widget currentWeatherInDetail() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 60,
                width: 60,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Image.asset("assets/icons/wind.png"),
              ),
              Container(
                height: 60,
                width: 60,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Image.asset("assets/icons/cloud.png"),
              ),
              Container(
                height: 60,
                width: 60,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Image.asset("assets/icons/humidity.png"),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 70,
              height: 20,
              child: Center(
                child: Text(
                    "${widget.weatherDataCurrent.current.windSpeed}km/h",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              width: 60,
              height: 20,
              child: Center(
                child: Text("${widget.weatherDataCurrent.current.clouds}%",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              width: 60,
              height: 20,
              child: Center(
                child: Text("${widget.weatherDataCurrent.current.humidity}%",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget searchBar(TextEditingController textController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        CupertinoIcons.sun_haze_fill,
                        color: Colors.amber,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _textController.clear();
                          },
                          icon: const Icon(
                            CupertinoIcons.clear_circled_solid,
                            color: Colors.black,
                          )),
                      hintText: "Enter City Name",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(11),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              city = textController.text;
              getData();
            });
          },
          child: const Icon(
            CupertinoIcons.search_circle_fill,
            color: Colors.black,
            size: 40,
          ),
        ),
      ],
    );
  }
}
