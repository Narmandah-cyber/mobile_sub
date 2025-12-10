import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LatLng ubCenter = LatLng(47.9188, 106.9177);

    return Scaffold(
      appBar: AppBar(title: const Text("OpenStreetMap (Static)")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: ubCenter,
          initialZoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
