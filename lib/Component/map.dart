import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // This is for latitude and longitude coordinates.
import 'package:url_launcher/url_launcher.dart';
class MapScreen extends StatefulWidget {
  String?lat;
  String ?long;
  MapScreen({super.key,required this.lat,required this.long});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];

    double? latitude = double.tryParse(widget.lat!);
    double? longitude = double.tryParse(widget.long!);


    if (latitude != null && longitude != null) {
      markers.add(
        Marker(
          width: 30.0,
          height: 30.0,
          point: LatLng(latitude, longitude),
          builder: (ctx) => Container(
            child: const Icon(
              Icons.location_on,
              size: 30.0,
              color: Colors.blue,
            ),
          ),
        ),
      );
    }
    return  Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.blue.shade800,
        title: Center(child: Text("Map")),
      ),
      body: SingleChildScrollView(

        child: SafeArea(

          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                elevation: 3.0,
                margin: const EdgeInsets.fromLTRB(10, 8,10, 5),
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),

                    child: const Center(child: Text("Your Position On The Map ",style: TextStyle(
                      color: Colors.brown,
                      fontFamily: "CedarvilleCursive"
                    ),))),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10)
                ),



                child: FlutterMap(

                  options: MapOptions(

                    center: LatLng(latitude??20.5937,longitude?? 78.9629),
                    zoom: 11.2,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap: () async {
                            const url = 'https://openstreetmap.org/copyright';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: markers,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
