import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // عشان نكتب خطوط الطول والعرض

class Maps extends StatelessWidget {
  const Maps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(30.0444, 31.2357), // القاهرة
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // سيرفر الخرائط المجاني
            userAgentPackageName: 'com.example.evently_app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(30.0444, 31.2357),
                width: 80,
                height: 80,
                child: Icon(Icons.location_on, color: Colors.blue, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}