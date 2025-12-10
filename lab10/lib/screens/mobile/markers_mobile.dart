import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// Replace with your free OpenTripMap API key
const String otpApiKey = "YOUR_OPENTRIPMAP_API_KEY";

class MarkersScreenMobile extends StatefulWidget {
  const MarkersScreenMobile({super.key});

  @override
  State<MarkersScreenMobile> createState() => _MarkersScreenMobileState();
}

class _MarkersScreenMobileState extends State<MarkersScreenMobile> {
  final TextEditingController _searchCtrl = TextEditingController();
  GoogleMapController? _mapController;

  Set<Marker> markers = {};
  static const LatLng ubCenter = LatLng(47.9188, 106.9177);

  Future<void> searchPlaces() async {
    final query = _searchCtrl.text.trim();
    if (query.isEmpty) return;

    final url =
        "https://api.maptiler.com/maps/streets-v4/style.json?key=5oJtenGwgd5bhnR9IGTS";

    final res = await http.get(Uri.parse(url));
    final data = jsonDecode(res.body);

    if (data["features"] == null) return;

    Set<Marker> newMarkers = {};
    for (var f in data["features"]) {
      final props = f["properties"];
      final geom = f["geometry"];
      if (geom == null || geom["coordinates"] == null) continue;

      final lon = geom["coordinates"][0];
      final lat = geom["coordinates"][1];
      final name = props["name"] ?? "Unknown";

      newMarkers.add(Marker(
        markerId: MarkerId(name + lat.toString()),
        position: LatLng(lat, lon),
        infoWindow: InfoWindow(title: name),
      ));
    }

    setState(() => markers = newMarkers);

    if (markers.isNotEmpty) {
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(markers.first.position, 14));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Markers — OpenTripMap")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: const InputDecoration(
                      labelText: "Search (restaurant, cafe, museum...)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: searchPlaces,
                  child: const Text("Go"),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(target: ubCenter, zoom: 13),
              markers: markers,
              onMapCreated: (c) => _mapController = c,
            ),
          ),
        ],
      ),
    );
  }
}
