import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_now/model/weather_data_current.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeatherWidget({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  // final _textController = TextEditingController();

  String city = '';
  void getData()async{
    Response response =await get("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=179e2260f583c2831cecf60ceb1caadd" as Uri);
    Map data = jsonDecode(response.body);
    Map coor_data = data['coord'];
    double lon = coor_data['lon'];
    print(lon);

  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set State Called");
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        temperatureAreaWidget(),
        currentWeatherInDetail(),
        // searchBar()
      ],
    );
  }

  Widget temperatureAreaWidget() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
                "assets/weather/${widget.weatherDataCurrent.current.weather![0].icon}.png",
                fit: BoxFit.fill,
                width: 80,
                height: 80),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 80, right: 10),
          child: Container(
            height: 70,
            width: 2,
            color: Colors.grey,
          ),
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: ("${widget.weatherDataCurrent.current.temp!.toInt()}°"),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 70,
                color: Colors.black,
              )),
          TextSpan(
              text:
                  ("${widget.weatherDataCurrent.current.weather![0].description}"),
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 13,
                color: Colors.black,
              ))
        ]))
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
                        color: Colors.lightBlueAccent,
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
                        color: Colors.lightBlueAccent,
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
                        color: Colors.lightBlueAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        )
      ],
    );
  }

  // Widget searchBar() {
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(top: 20,),
  //             child: Container(
  //                 height: 40,
  //                 width: 340,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(20),
  //                     border: Border.all(color: Colors.black)),
  //                 // child: Row(
  //                 //   children: [
  //                 //     GestureDetector(
  //                 //       onTap: () {
  //                 //         Navigator.pushNamed(context,"/homeScreen",arguments:{"searchText": _textController });
  //                 //       },
  //                 //       child: Padding(
  //                 //         padding: const EdgeInsets.all(8.0),
  //                 //         child: Icon(Icons.search, color: Colors.blue.shade800),
  //                 //       ),
  //                 //     ),
  //                 //     // Expanded(
  //                 //     //   child:
  //                 //     //       // TextField(
  //                 //     //       //   controller: _textController,
  //                 //     //       //   decoration:  InputDecoration(
  //                 //     //       //       border: InputBorder.none,
  //                 //     //       //       contentPadding: const EdgeInsets.all(12),
  //                 //     //       //       suffixIcon: IconButton(onPressed:(){
  //                 //     //       //         _textController.clear();
  //                 //     //       //       }, icon: const Icon(Icons.clear_rounded)),
  //                 //     //       //       hintText: "Enter Location"),
  //                 //     //       // ),
  //                 //     //   ),
  //                 //   ],
  //                 // )
  //                 //
  //                 ),
  //           ),
  //         ],
  //       ),
  //       ElevatedButton(
  //           onPressed:(){setState(() {
  //             getData();
  //             city = _textController.text;
  //           });
  //            },
  //           child: const Text("Search")
  //       )],
  //   );
  // }
  void fetch(){
print(city);
  }
}
