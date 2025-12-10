import 'package:flutter/material.dart';

class DevDepsScreen extends StatelessWidget {
  const DevDepsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dev Dependencies")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "dev_dependencies:\n"
          "- Used only during development\n"
          "- Not included in release builds\n"
          "- Examples: flutter_test, build_runner, lint, flutter_lints\n\n"
          "Add using: flutter pub add --dev package_name",
        ),
      ),
    );
  }
}
