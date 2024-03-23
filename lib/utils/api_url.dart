import 'package:weather_now/api/api_key.dart';

String apiURL(var lat, var lon) {
  String url;
  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=179e2260f583c2831cecf60ceb1caadd&units=metric&exclude=minutely";

  return url;
}
