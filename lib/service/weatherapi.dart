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
    debugPrint("api activ");
    try {
      // Define your RapidAPI key and API endpoint URL
      // const apiKey = '27702d5d27msh98284803884f185p156085jsn9f40a7f2295a';
      // const apiUrl =
      //     'https://weatherapi-com.p.rapidapi.com/current.json'; // Replace with the API endpoint URL.
      //
      // // Define the parameters you want to include
      // final Map<String, String> queryParams = {
      //   'q': location,
      //   // Add other parameters as needed
      // };

      final uri = Uri.parse('https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat,$long?unitGroup=us&key=23FF36AZPE75SCTYHUPXH5U6U');

      var response = await http.get(
        uri,

      );
      debugPrint("api req");
      if (response.statusCode == 200) {
        debugPrint("api data");
        var data = jsonDecode(response.body);
        // debugPrint(data.toString());
        // Map locationData = data["location"];
        // Map current = data["current"];
        // Map condition = current["condition"];

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
