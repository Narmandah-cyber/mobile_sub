import 'package:flutter/material.dart';

import 'screens/import_demo.dart';
import 'screens/dev_deps.dart';
import 'screens/package_demo.dart';

import 'screens/map_static.dart';
import 'screens/location_map.dart';
import 'screens/markers.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapter 11 Demo - OSM',
      debugShowCheckedModeBanner: false,
      home: const HomeMenu(),
      routes: {
        '/import': (c) => const ImportDemoScreen(),
        '/dev': (c) => const DevDepsScreen(),
        '/package': (c) => const PackageScreen(),
        '/map': (c) => const MapScreen(),
        '/location': (c) => const LocationMapScreen(),
        '/markers': (c) => const MarkersScreen(),
      },
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'Import package (http)', 'route': '/import'},
      {'title': 'Dev dependencies', 'route': '/dev'},
      {'title': 'Use local package (area)', 'route': '/package'},
      {'title': 'OpenStreetMap (static)', 'route': '/map'},
      {'title': 'Location + Map', 'route': '/location'},
      {'title': 'Markers (Nominatim search)', 'route': '/markers'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Chapter 11 — Demos")),
      body: ListView(
        children: items.map((item) {
          return ListTile(
            title: Text(item['title']!),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, item['route']!),
          );
        }).toList(),
      ),
    );
  }
}
