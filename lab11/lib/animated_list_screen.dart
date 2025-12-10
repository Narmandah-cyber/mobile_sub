import 'package:flutter/material.dart';

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});
  @override
  State<AnimatedListScreen> createState() => _AnimatedListScreenState();
}

class _AnimatedListScreenState extends State<AnimatedListScreen> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<int> _items = List<int>.generate(5, (i) => i + 1);
  int counter = 5;

  Widget fadeListTile(BuildContext context, int item, Animation<double> animation) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
      child: Card(
        child: ListTile(
          title: Text('Pizza $item'),
          onTap: () {
            final index = _items.indexOf(item);
            if (index != -1) removePizza(index);
          },
        ),
      ),
    );
  }

  void insertPizza() {
    listKey.currentState!.insertItem(_items.length, duration: const Duration(seconds: 1));
    _items.add(++counter);
  }

  void removePizza(int index) {
    final removedItem = _items[index];
    listKey.currentState!.removeItem(
      index,
      (context, animation) => fadeListTile(context, removedItem, animation),
      duration: const Duration(seconds: 1),
    );
    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: insertPizza,
          )
        ],
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return fadeListTile(context, _items[index], animation);
        },
      ),
    );
  }
}
