import 'package:flutter/material.dart';

class DismissibleScreen extends StatefulWidget {
  const DismissibleScreen({super.key});
  @override
  State<DismissibleScreen> createState() => _DismissibleScreenState();
}

class _DismissibleScreenState extends State<DismissibleScreen> {
  final List<String> sweets = [
    'Petit Four','Cupcake','Donut','Éclair','Froyo','Gingerbread',
    'Honeycomb','Ice Cream Sandwich','Jelly Bean','KitKat'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dismissible Example')),
      body: ListView.builder(
        itemCount: sweets.length,
        itemBuilder: (context, index) {
          final item = sweets[index];
          return Dismissible(
            key: Key(item),
            background: const ColoredBox(color: Colors.red),
            child: ListTile(title: Text(item)),
            onDismissed: (direction) {
              setState(() {
                sweets.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}
