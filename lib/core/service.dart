import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/core/model/weather.dart';

String apiKey = "b4d62c0ed862f7101de78412ad7ce926";

class WeatherService {
  Future<List<DailyWeather>> getForecastData(String cityName) async {
    final queryParameters = {
      "q": cityName,
      "appid": apiKey,
      "units": "metric",
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/forecast', queryParameters);

    var res = await http.get(uri);

    List<DailyWeather> weathers = [];
    var body = jsonDecode(res.body);
    List list = body['list'];
    for (var i = 0; i < list.length; i = i + 8) {
      weathers.add(
        DailyWeather(
            temperature: list[i]['main']['temp'],
            humidity: double.parse(list[i]['main']['humidity'].toString()),
            mainWeather: list[i]['weather'][0]['main']),
      );
    }
    return weathers;
  }

  Future<String> getCurrentCityName() async {
    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemarks[0].locality;

    return city ?? "";
  }
}
