import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class getCord {
  String ?lat;
  String ?long;

  Future<void> getCordiData(String area) async {
    try {
      final uri = Uri.parse(
          'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$area?key=23FF36AZPE75SCTYHUPXH5U6U');

      var response = await http.get(
        uri,

      );
      debugPrint("api req");
      if (response.statusCode == 200) {
        debugPrint("api data");
        var data = jsonDecode(response.body);
        // debugPrint(data.toString());
        lat = data["latitude"].toString();
        // debugPrint(lat);
        long=data["longitude"].toString();
        // debugPrint(long);
      }
    }
    catch (e) {
      debugPrint("this is error $e");
    }
  }
}