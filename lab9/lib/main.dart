import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'stream.dart';
import 'random_bloc.dart';
import 'screens/random_screen.dart';

void main() => runApp(const StreamsApp());

class StreamsApp extends StatelessWidget {
  const StreamsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapter 10 - Streams',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;
  late NumberStream numberStream;
  late StreamSubscription subscription;
  int lastNumber = 0;
  String values = '';

  @override
  void initState() {
    super.initState();
    colorStream = ColorStream();
    numberStream = NumberStream();
    startColorStream();
    startNumberStream();
  }

  void startColorStream() {
    colorStream.getColors().listen((color) {
      setState(() => bgColor = color);
    });
  }

  void startNumberStream() {
    subscription = numberStream.controller.stream
        .asBroadcastStream()
        .listen((number) {
      setState(() {
        lastNumber = number;
        values += '$number - ';
      });
    });
    subscription.onError((error) => setState(() => lastNumber = -1));
    subscription.onDone(() => print('Stream closed'));
  }

  void addRandomNumber() {
    final random = Random().nextInt(10);
    if (!numberStream.controller.isClosed) {
      numberStream.addNumberToSink(random);
    } else {
      setState(() => lastNumber = -1);
    }
  }

  void stopStream() {
    numberStream.close();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chapter 10 - Streams Demo')),
      backgroundColor: bgColor,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 40),
              Text('Last Number: $lastNumber', style: const TextStyle(fontSize: 40, color: Colors.white)),
              Text(values, style: const TextStyle(fontSize: 24, color: Colors.white70)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: addRandomNumber,
                child: const Text('New Random Number', style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: stopStream,
                child: const Text('Stop Stream', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Go to BLoC Example'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RandomScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}