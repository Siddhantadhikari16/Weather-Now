import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_now/model/weather_data_daily.dart';

class DailyDataWidget extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyDataWidget({Key? key, required this.weatherDataDaily})
      : super(key: key);

  String getDay(final day){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day*1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 400,
        decoration:BoxDecoration(color:
        Colors.black,borderRadius: BorderRadius.circular(35))   ,
               child:Column(
                 children: [
                   const Padding(
                     padding: EdgeInsets.only(top: 10,left: 20),
                     child: Text("NEXT DAYS",style:
                     TextStyle(
                         color: Colors.white,
                         fontSize: 25,
                         fontWeight: FontWeight.bold)
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(bottom: 5,top: 5),
                     child: Container(
                       height: 1,
                      color: Colors.white,
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 10),
                     child: dailyList(),
                   ),
                 ],
               ),
      ),



    );

  }
  Widget dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
          itemCount: weatherDataDaily.daily.length > 7 ? 7
              : weatherDataDaily.daily.length,
      itemBuilder:(context,index){
            return Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(getDay(weatherDataDaily.daily[index].dt),
                            style: const TextStyle(
                                color:Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                            "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png"),
                      ),
                      Text(
                          "${weatherDataDaily.daily[index].temp!.max}°/${weatherDataDaily.daily[index].temp!.min}°",
                        style: const TextStyle(color:Colors.white,fontSize: 18),)
                    ],
                  )
                )
              ],
            );

      }),

    );
  }
}
