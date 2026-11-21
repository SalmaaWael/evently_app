import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class PickLocation extends StatefulWidget {
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  // متغير عشان نخزن فيه المكان اللي اليوزر اختاره
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Location")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(30.0444, 31.2357), // القاهرة
          initialZoom: 13.0,
          onTap: (tapPosition, point) {
            // لما اليوزر يدوس على الخريطة، بنحدث المكان المختار
            setState(() {
              _pickedLocation = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.evently_app',
          ),
          // لو فيه مكان مختار، اعرضي الماركر
          if (_pickedLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _pickedLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: _pickedLocation != null
          ? FloatingActionButton.extended(
        onPressed: () {
          // لما يدوس تأكيد، نرجع المكان للصفحة اللي قبلنا
          Navigator.pop(context, _pickedLocation);
        },
        icon: const Icon(Icons.check),
        label: const Text("Confirm Location"),
      )
          : null, // نخفي الزرار لو مفيش مكان مختار
    );
  }
}