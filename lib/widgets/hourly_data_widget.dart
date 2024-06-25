import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_now/controller/global_controller.dart';
import 'package:weather_now/model/weather_data_hourly.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({Key? key, required this.weatherDataHourly})
      : super(key:key);

  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 10),
          child: const Text("TODAY",
              style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18)),
        ),
        hourlyList()
      ],
    );
  }

  Widget hourlyList(){
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length>12?
        20:weatherDataHourly.hourly.length,
        itemBuilder: (context,index){
          return Obx(() => GestureDetector(
            onTap: (){
              cardIndex.value=index;
            },
              child: Container(
                width: 80,
              margin: const EdgeInsets.only(left: 20,right: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
                 gradient: cardIndex.value == index
                     ? const LinearGradient(
                     begin:Alignment.topLeft,
                     end: Alignment.bottomRight,colors:[
               Colors.black,
               Colors.black,
             ]):null),
                child: HourlyDetails(
                  temp: weatherDataHourly.hourly[index].temp!,
                  timeStamp: weatherDataHourly.hourly[index].dt!,
                  weatherIcon: weatherDataHourly.hourly[index].weather![0].icon!,
                ),
              )));
        },
      ),
    );
  }
}





class HourlyDetails extends StatelessWidget {
 int temp;
 int timeStamp;
 String weatherIcon;
 
 String getTime(final timeStamp){
   DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp*1000);
   String x = DateFormat('jm').format(time);
   return x;
 }
 HourlyDetails({Key?key, required this.timeStamp, required this.temp, required this.weatherIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(getTime(timeStamp),style:const TextStyle(color: Colors.lightBlueAccent, fontWeight:FontWeight.bold)),
        Image.asset("assets/weather/$weatherIcon.png",
          height:40,
          width: 40,),
        Text("$temp°",style:const TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.bold)),
      ],
    );
  }
}
