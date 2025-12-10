import 'package:flutter/material.dart';
import 'detail_screen.dart';

class ListScreen extends StatelessWidget {
  ListScreen({super.key});
  final List<String> items = List.generate(8, (i) => 'Cup #${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero List')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(tag: 'cup$index', child: const Icon(Icons.free_breakfast)),
            title: Text(items[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailScreen(index: index, title: items[index])),
              );
            },
          );
        },
      ),
    );
  }
}
