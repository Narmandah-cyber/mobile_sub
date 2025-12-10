import 'package:flutter/material.dart';
import 'package:area/area.dart';
import 'package:lab10/widgets/app_text_field.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final TextEditingController w = TextEditingController();
  final TextEditingController h = TextEditingController();

  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Using Local Package")),
      body: Column(
        children: [
          AppTextField(w, "Width"),
          AppTextField(h, "Height"),
          ElevatedButton(
            onPressed: () {
              double width = double.tryParse(w.text) ?? 0;
              double height = double.tryParse(h.text) ?? 0;

              setState(() => result = calculateAreaRect(width, height));
            },
            child: const Text("Calculate Area"),
          ),
          const SizedBox(height: 20),
          Text("Result: $result"),
        ],
      ),
    );
  }
}
