
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:neighbouring/Component/food.dart';
import 'package:neighbouring/Component/forecast.dart';
import 'package:neighbouring/Component/map.dart';
import 'package:neighbouring/Component/places.dart';
class Navbar extends StatefulWidget {
  final String lat;
  final String long;

  const Navbar({Key? key, required this.lat, required this.long}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final Location location = Location();
  int currentTabIndex = 0;
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  LocationData _locationData = LocationData.fromMap({'latitude': 22.5726, 'longitude': 88.3639});


  late List<Widget> pages;
  @override
  void initState() {
    pages = [
      Forecaste(lat: widget.lat, long: widget.long),
      Food(lat: widget.lat, long: widget.long),
      Places(lat: widget.lat, long: widget.long),
      MapScreen(lat: widget.lat, long: widget.long),
    ];
    // TODO: implement initState
if(widget.lat== (22.5726).toString()) {
  requestLocationPermission();
}

  super.initState();
  }


  Future<void> requestLocationPermission() async{
    final PermissionStatus status = await location.requestPermission();
    setState(() {
      _permissionStatus=status;
       debugPrint(_permissionStatus.toString());
    });
    if(status==PermissionStatus.granted){
      getLocation();
    }
  }

  Future<void> getLocation() async {
    try {
      final LocationData locationData = await location.getLocation();
      setState(() {
        _locationData = locationData;

        updateForecaste(_locationData.latitude.toString(), _locationData.longitude.toString());
      });
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  void updateForecaste(String latitude, String longitude) {
    setState(() {
      // Update the Forecaste widget with the new location
      pages[0] = Forecaste(lat: latitude, long: longitude);
      pages[1] = Food(lat: latitude, long: longitude);
      pages[2] = Places(lat: latitude, long: longitude);
      pages[3] = MapScreen(lat: latitude, long: longitude);

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor:     Colors.white,
        color: Colors.blueAccent,
        animationDuration:const Duration(microseconds: 500),
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