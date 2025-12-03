import 'package:flutter/material.dart';
import '../random_bloc.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({super.key});
  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  final _bloc = RandomNumberBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLoC Random Number')),
      body: Center(
        child: StreamBuilder<int>(
          stream: _bloc.randomNumber,
          initialData: 0,
          builder: (context, snapshot) {
            return Text(
              'Random: ${snapshot.data}',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () => _bloc.generateRandom.add(null),
      ),
    );
  }
}