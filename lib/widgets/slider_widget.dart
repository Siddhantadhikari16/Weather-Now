import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_now/model/weather_data_current.dart';

class ComfortLevel extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const ComfortLevel({Key? key, required this.weatherDataCurrent})
      : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
      child: Container(
        height: 250,
        width: 50,
        decoration: const BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("COMFORT LEVEL",style: TextStyle(fontSize: 20,color: Colors.white)),
            ),
            SizedBox(
              height: 200,
              child: Column(
                children: [
                  Center(
                    child: SleekCircularSlider(
                      min: 0,
                      max: 100,
                      initialValue: weatherDataCurrent.current.humidity!.toDouble(),
                      appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(handlerSize: 0,trackWidth: 10,progressBarWidth: 15,shadowWidth: 0),
                        infoProperties: InfoProperties(
                          bottomLabelText: "Humidity",
                          bottomLabelStyle:const TextStyle(letterSpacing: 0.1,fontSize: 20,height: 1.5,color: Colors.white)
                        ),
                          animationEnabled: true,size: 150,
                          customColors: CustomSliderColors(
                              progressBarColor:Colors.black,
                              trackColor: Colors.white,)),

                    ),
                  ),
                  Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                          text: "Feels Like: ",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "${weatherDataCurrent.current.feelsLike}",style: const TextStyle(fontSize: 15,color: Colors.white, fontWeight: FontWeight.bold)
                            )])),
                      ),
                      Container(
                        height: 45,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:30),
                        child: RichText(
                            text: TextSpan(children: [
                                const TextSpan(
                                text: "UV Index: ",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "${weatherDataCurrent.current.uvIndex}",style: const TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)
                            )])),
                      )]  ,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
