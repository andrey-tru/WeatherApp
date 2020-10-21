import 'dart:convert';
import 'Weather.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static String _apiKey = '{YOUR_API_KEY}';

  Future<Weather> getWeather(city) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&lang=ru&units=metric&appid=$_apiKey';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error : ${response.reasonPhrase}');
    }
  }

  Future<List<Weather>> getWeekWeather(city) async {
    var url =
        'http://api.openweathermap.org/data/2.5/forecast?q=$city&lang=ru&units=metric&appid=$_apiKey';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Weather> data = (jsonData['list'] as List<dynamic>)
          .map((item) {
            return Weather.fromJson(item);
      }).toList();
      return data;
    } else {
      throw Exception('Error : ${response.reasonPhrase}');
    }
  }
}
