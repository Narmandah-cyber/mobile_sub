import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenMobile extends StatefulWidget {
  const MapScreenMobile({super.key});

  @override
  State<MapScreenMobile> createState() => _MapScreenMobileState();
}

class _MapScreenMobileState extends State<MapScreenMobile> {
  late GoogleMapController controller;

  static const CameraPosition initial = CameraPosition(
    target: LatLng(47.9188, 106.9177),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Static Map (Mobile)")),
      body: GoogleMap(
        initialCameraPosition: initial,
        onMapCreated: (c) => controller = c,
      ),
    );
  }
}
