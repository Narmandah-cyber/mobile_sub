import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MarkersScreen extends StatefulWidget {
  const MarkersScreen({super.key});

  @override
  State<MarkersScreen> createState() => _MarkersScreenState();
}

class _MarkersScreenState extends State<MarkersScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<Marker> markers = [];
  final LatLng ubCenter = LatLng(47.9188, 106.9177);

  Future<void> searchPlaces() async {
    final query = _searchCtrl.text.trim();
    if (query.isEmpty) return;

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search.php?q=$query+Ulaanbaatar&format=jsonv2');

    final res = await http.get(url, headers: {'User-Agent': 'FlutterMapDemo'});
    final data = jsonDecode(res.body);

    List<Marker> newMarkers = [];

    for (var place in data) {
      final lat = double.tryParse(place['lat'] ?? '');
      final lon = double.tryParse(place['lon'] ?? '');
      if (lat != null && lon != null) {
        newMarkers.add(
          Marker(
            width: 40,
            height: 40,
            point: LatLng(lat, lon),
            child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
          ),
        );
      }
    }

    setState(() => markers = newMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Markers)")),
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
            child: FlutterMap(
              options: MapOptions(
                initialCenter: ubCenter,
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: markers),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
