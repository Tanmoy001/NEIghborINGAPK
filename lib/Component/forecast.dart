import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neighbouring/Component/navbar.dart';
import 'package:neighbouring/service/getCord.dart';
import 'package:neighbouring/service/weatherapi.dart';

class Forecaste extends StatefulWidget {
 final String? lat;
 final String? long;
 const Forecaste({Key? key, required this.lat, required this.long}) : super(key: key);

  @override
  State<Forecaste> createState() => _ForecasteState();
}

class _ForecasteState extends State<Forecaste> {
  TextEditingController search = TextEditingController();
  bool _loading = true;
  String temperature = "";
  String hum = "";
  String air_speed = "";
  String des = "";
  String main = "";
  String icon = "";
  String name = "";
  String city = "Mumbai"; // Initialize with a default city
  String latitude = "";
  String longitude = "";
  // late String model;
  Future<void> startApp() async {
    WeatherApi instance = WeatherApi();
    // debugPrint("instance is loading");

    await instance.getWeatherData(
        widget.lat.toString(), widget.long.toString());

    temperature = instance.temp;
    hum = instance.humidity;
    air_speed = instance.airSpeed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;
    name = instance.name;

    setState(() {
      _loading = false;
    });
  }

  Future<void> getCondinate(String text) async {
    getCord newclass = getCord();
    await newclass.getCordiData(text);
    latitude = newclass.lat.toString();

    longitude = newclass.long.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp();
    // debugPrint(_loading.toString());
  }

  @override
  Widget build(BuildContext context) {
    var city_name = ["Mumbai", "Delhi", "Indore", "Kolkata", "Ranchi"];
    final random = Random();
    var Random_city = city_name[random.nextInt(city_name.length)];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Center(child: Text("ForeCaste")),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black26,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if ((search.text).replaceAll(' ', '') == '') {
                                // debugPrint('blank');
                              } else {
                                await getCondinate(search.text);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Navbar(
                                            lat: latitude.toString(),
                                            long: longitude.toString())));
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(2, 0, 5, 0),
                              child:
                                  const Icon(Icons.search, color: Colors.blue),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: search,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search '$Random_city'",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  padding: const EdgeInsets.all(26),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFFADD8E6), // Use the color code for #ADD8E6
                                    borderRadius: BorderRadius.circular(
                                        16), // 1rem equivalent to 16px

                                    border: Border.all(
                                      color: Colors.transparent, // Border color
                                      width: 2.0, // Border width
                                      // Border style, in this case "outset"
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(5, 2),
                                        blurRadius: 20,
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        spreadRadius: 0,
                                        // This shadow is outer.
                                      ),
                                      BoxShadow(
                                        offset: Offset(5, 2),
                                        blurRadius: 20,
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        spreadRadius: 0,
                                        // This shadow is outer.
                                      ),
                                    ],
                                  ),


                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 30, 0),
                                          child: const Icon(
                                            Icons.cloud,
                                            size: 40,
                                            color: Colors.white,
                                          )),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 10, 0),
                                        child: Column(
                                          children: [
                                            Text(
                                              des,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: (des.length < 8)
                                                      ? 18
                                                      : 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "in $name",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  height: 198,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFFADD8E6), // Use the color code for #ADD8E6
                                    borderRadius: BorderRadius.circular(
                                        16), // 1rem equivalent to 16px

                                    border: Border.all(
                                      color: Colors.transparent, // Border color
                                      width: 2.0, // Border width
                                      // Border style, in this case "outset"
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(5, 2),
                                        blurRadius: 20,
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        spreadRadius: 0,
                                        // This shadow is outer.
                                      ),
                                      BoxShadow(
                                        offset: Offset(5, 2),
                                        blurRadius: 20,
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        spreadRadius: 0,
                                        // This shadow is outer.
                                      ),
                                    ],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 8),
                                  padding: const EdgeInsets.all(26),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.thermostat_outlined,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            temperature,
                                            style: const TextStyle(
                                                fontSize: 80,
                                                color: Colors.white),
                                          ),
                                          const Text(
                                            "°F",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFFADD8E6), // Use the color code for #ADD8E6
                                    borderRadius: BorderRadius.circular(
                                        16), // 1rem equivalent to 16px

                                    border: Border.all(
                                      color: Colors.transparent, // Border color
                                      width: 2.0, // Border width
                                      // Border style, in this case "outset"
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(5, 2),
                                        blurRadius: 20,
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        spreadRadius: 0,
                                        // This shadow is outer.
                                      ),
                                      BoxShadow(
                                        offset: Offset(5, 2),
                                        blurRadius: 20,
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        spreadRadius: 0,
                                        // This shadow is outer.
                                      ),
                                    ],
                                  ),
                                  margin:
                                      const EdgeInsets.fromLTRB(13, 0, 5, 5),
                                  padding: const EdgeInsets.all(26),
                                  height: 180,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.wind_power_rounded,
                                              color: Colors.white)
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Text(air_speed,
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      const Text(
                                        "km/hr",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFFADD8E6), // Use the color code for #ADD8E6
                                    borderRadius: BorderRadius.circular(
                                        16), // 1rem equivalent to 16px

                                    border: Border.all(
                                      color: Colors.transparent, // Border color
                                      width: 2.0, // Border width
                                      // Border style, in this case "outset"
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(5, 2),
                                        blurRadius: 20,
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        spreadRadius: 0,
                                        // This shadow is outer.
                                      ),
                                      BoxShadow(
                                        offset: Offset(5, 2),
                                        blurRadius: 20,
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        spreadRadius: 0,
                                        // This shadow is outer.
                                      ),
                                    ],
                                  ),
                                  margin:
                                      const EdgeInsets.fromLTRB(5, 0, 13, 5),
                                  height: 180,
                                  padding: const EdgeInsets.all(26),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.water_drop,
                                              color: Colors.white)
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Text(hum,
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      const Text(
                                        "Percent",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Container(

                           margin: const EdgeInsets.fromLTRB(5, 0, 13, 5),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(26),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text("Made by Tanmoy Chowdhury"),
                              Text("©The codes are done by Tanmoy Chowdhury"),
                            ],
                          ),
                        ),
                      ],
                      // Your weather forecast widget here
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
