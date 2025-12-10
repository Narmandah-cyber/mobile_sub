import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapWeb extends StatelessWidget {
  const LocationMapWeb({super.key});

  @override
  Widget build(BuildContext context) {
    const LatLng ubCenter = LatLng(47.9188, 106.9177);

    return Scaffold(
      appBar: AppBar(title: const Text("Location + Map (Web)")),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: ubCenter,
          zoom: 14,
        ),
      ),
    );
  }
}
