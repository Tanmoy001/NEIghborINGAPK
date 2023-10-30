import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class WeatherApi {
  String temp = "";
  String humidity = "";
  String airSpeed = "";
  String description = "";
  String main = "";
  String icon = "";
  String name = "";

  Future<void> getWeatherData(String lat ,String long) async {

    try {


      final uri = Uri.parse('https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat,$long?unitGroup=us&key=23FF36AZPE75SCTYHUPXH5U6U');

      var response = await http.get(
        uri,

      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);


        // Assign values to instance variables
        Map conditions = data["currentConditions"];
        temp =conditions["temp"].toString();
        humidity = conditions["humidity"].toString();
        airSpeed = conditions["windspeed"].toString();
        name = data["timezone"];
        // icon = condition["icon"];
        description = conditions["conditions"];
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
