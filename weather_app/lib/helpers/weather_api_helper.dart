import 'dart:convert';
import '../models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherAPIHelper {
  WeatherAPIHelper._();
  static final WeatherAPIHelper weatherAPIHelper = WeatherAPIHelper._();

  Future<Weather?> fetchWeatherData({required String city}) async {
    final String BASE_URL = "https://api.openweathermap.org/data/2.5";
    final String END_POINT =
        "/weather?q=$city,in&appid=bb26f7713d3661dcbc1cefc1819b1758";

    http.Response res = await http.get(Uri.parse(BASE_URL + END_POINT));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(res.body);

      Weather weather = Weather.fromJSON(json: decodedData);

      return weather;
    }
    return null;
  }
}
