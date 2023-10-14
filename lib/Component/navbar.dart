import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:neighbouring/Component/food.dart';
import 'package:neighbouring/Component/forecast.dart';
import 'package:neighbouring/Component/map.dart';
import 'package:neighbouring/Component/places.dart';
class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentTabIndex = 0;
  final List<Widget> pages = [
    Forecaste(),
    Food(),
    Places(),
  MapScreen(),
  ];
  late Widget currentPage;
  late Forecaste forecaste;
  late Food food;
  late Places places;
  late MapScreen mapScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor:     Colors.white,
        color: Colors.blueAccent,
        animationDuration: Duration(microseconds: 500),
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(Icons.cloud_circle,color: Colors.white,),
          Icon(Icons.food_bank,color: Colors.white,),
          Icon(Icons.attractions,color: Colors.white,),
          Icon(Icons.place,color: Colors.white,),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}