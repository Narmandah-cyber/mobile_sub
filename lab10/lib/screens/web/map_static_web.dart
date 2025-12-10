import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenWeb extends StatefulWidget {
  const MapScreenWeb({super.key});

  @override
  State<MapScreenWeb> createState() => _MapScreenWebState();
}

class _MapScreenWebState extends State<MapScreenWeb> {
  late GoogleMapController controller;

  static const CameraPosition initial = CameraPosition(
    target: LatLng(47.9188, 106.9177),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Static Map (Web)")),
      body: GoogleMap(
        initialCameraPosition: initial,
        onMapCreated: (c) => controller = c,
      ),
    );
  }
}
