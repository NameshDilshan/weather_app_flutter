import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/weather_model.dart';

class WeatherApiClient{
  Future<Weather>? getCurrentWeather(String? location) async{
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=5ca184503a427e8489d2c0c47377ddd0");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    return Weather.fromJson(body);
  }
}