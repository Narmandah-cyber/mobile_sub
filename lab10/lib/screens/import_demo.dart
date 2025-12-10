import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImportDemoScreen extends StatefulWidget {
  const ImportDemoScreen({super.key});

  @override
  State<ImportDemoScreen> createState() => _ImportDemoScreenState();
}

class _ImportDemoScreenState extends State<ImportDemoScreen> {
  String data = "Press Fetch";

  Future<void> fetchData() async {
    final uri = Uri.https('jsonplaceholder.typicode.com', '/todos/1');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() => data = json.decode(response.body).toString());
    } else {
      setState(() => data = "Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Import Demo — http")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: fetchData,
              child: const Text("Fetch JSON"),
            ),
            const SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: Text(data))),
          ],
        ),
      ),
    );
  }
}
