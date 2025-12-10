import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  final String title;
  const DetailScreen({super.key, required this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.amber,
              child: Hero(
                tag: 'cup$index',
                child: const Icon(Icons.free_breakfast, size: 96),
              ),
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
