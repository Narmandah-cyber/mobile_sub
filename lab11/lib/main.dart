import 'package:flutter/material.dart';

import 'my_animation.dart';
import 'shape_animation.dart';
import 'shape_animation_multi.dart';
import 'fade_transition_screen.dart';
import 'animated_list_screen.dart';
import 'dismissible_screen.dart';
import 'list_screen.dart'; 

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapter 12 Animations Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),

      // home: const MyAnimation(),                // AnimatedContainer
      // home: const ShapeAnimation(),             // Single AnimationController
      // home: const ShapeAnimationMulti(),        // Multiple Tweens
      // home: const FadeTransitionScreen(),       // FadeTransition
      // home: const AnimatedListScreen(),         // AnimatedList
      // home: const DismissibleScreen(),          // Dismissible list
      home: ListScreen(),                          // Hero animation (default)

      routes: {
        '/implicit': (context) => const MyAnimation(),
        '/controller': (context) => const ShapeAnimation(),
        '/multi': (context) => const ShapeAnimationMulti(),
        '/fade': (context) => const FadeTransitionScreen(),
        '/alist': (context) => const AnimatedListScreen(),
        '/dismiss': (context) => const DismissibleScreen(),
        '/hero': (context) => ListScreen(),
      },
    );
  }
}
