
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:neighbouring/model/food_model.dart';

class Foodapi {
  List<foodModel> list = [];

  Future<void> getFoodDataList(lat, lng) async {
    try {
      // Define your RapidAPI key and API endpoint URL
      const apiKey = '621f84515fmsh8f2eb5cfbd49899p1d3690jsn6dec2261face';
      const apiUrl =
          'https://travel-advisor.p.rapidapi.com/restaurants/list-by-latlng'; // Replace with the API endpoint URL.

      // Define the parameters you want to include
      final Map<String,String> queryParams = {
        "latitude": lat,
        "longitude": lng,
        // Add other parameters as needed
      };

      final uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

      var response = await http.get(
        uri,
        headers: {
          'X-RapidAPI-Key': apiKey,
        },
      );
      var jsonData = jsonDecode(response.body);

      jsonData["data"].forEach((element){
        String imagesString="";
        if(element["name"]!=null && element["address"]!=null) {
          if (element.containsKey("photo") && element["photo"] is Map) {
            final photo = element["photo"];
            // if (photo.containsKey("images") && photo["images"] is Map) {
            final images = photo["images"];
            final large = images["large"];
            final url = large["url"];
             imagesString = url.toString();

            // }
          }
          foodModel foodmodel = foodModel(
            cuisine: element['cuisine'] ?? [],
            name: element['name'],
            ranking: element['ranking'],
            // cuisine: element['cuisine'],
            location: element['address'],
            rating: element['rating'],
            photo:imagesString,
           // photo: "https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
          );
          list.add(foodmodel);


        }
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
