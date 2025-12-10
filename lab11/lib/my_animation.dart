import 'package:flutter/material.dart';

class MyAnimation extends StatefulWidget {
  const MyAnimation({super.key});
  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation> {
  int iteration = 0;
  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red
  ];
  final List<double> sizes = [100, 125, 150, 175, 200];
  final List<double> tops = [0, 50, 100, 150, 200];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Container'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                iteration = (iteration < 4) ? (iteration + 1) : 0;
              });
            },
          )
        ],
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          width: sizes[iteration],
          height: sizes[iteration],
          margin: EdgeInsets.only(top: tops[iteration]),
          decoration: BoxDecoration(
            color: colors[iteration],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
