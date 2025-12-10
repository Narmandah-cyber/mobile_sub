import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationMapMobile extends StatefulWidget {
  const LocationMapMobile({super.key});

  @override
  State<LocationMapMobile> createState() => _LocationMapMobileState();
}

class _LocationMapMobileState extends State<LocationMapMobile> {
  late Future<LatLng> future;

  @override
  void initState() {
    super.initState();
    future = getLocation();
  }

  Future<LatLng> getLocation() async {
    Location loc = Location();
    bool enabled = await loc.serviceEnabled();
    if (!enabled) {
      enabled = await loc.requestService();
      if (!enabled) return const LatLng(47.9188, 106.9177);
    }
    PermissionStatus perm = await loc.hasPermission();
    if (perm == PermissionStatus.denied) {
      perm = await loc.requestPermission();
    }
    final data = await loc.getLocation();
    return LatLng(data.latitude ?? 47.9188, data.longitude ?? 106.9177);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location + Map (Mobile)")),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: snapshot.data as LatLng,
              zoom: 14,
            ),
          );
        },
      ),
    );
  }
}
