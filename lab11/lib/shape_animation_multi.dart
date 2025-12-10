import 'package:flutter/material.dart';

class ShapeAnimationMulti extends StatefulWidget {
  const ShapeAnimationMulti({super.key});
  @override
  State<ShapeAnimationMulti> createState() => _ShapeAnimationMultiState();
}

class _ShapeAnimationMultiState extends State<ShapeAnimationMulti>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationTop;
  late Animation<double> animationLeft;
  double posTop = 0;
  double posLeft = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animationLeft = Tween<double>(begin: 0, end: 150).animate(controller);
    animationTop = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        moveBall();
      });
  }

  void moveBall() {
    setState(() {
      posTop = animationTop.value;
      posLeft = animationLeft.value;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Animation Controller'),
        actions: [
          IconButton(
            icon: const Icon(Icons.run_circle),
            onPressed: () {
              controller.reset();
              controller.forward();
            },
          ),
        ],
      ),
      body: Stack(children: [
        Positioned(left: posLeft, top: posTop, child: const Ball())
      ]),
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration:
          const BoxDecoration(color: Colors.deepOrange, shape: BoxShape.circle),
    );
  }
}
