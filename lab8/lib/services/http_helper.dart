// lib/services/http_helper.dart
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pizza.dart';

class HttpHelper {
  HttpHelper._internal();
  static final HttpHelper _instance = HttpHelper._internal();
  factory HttpHelper() => _instance;

  // YOUR REAL WORKING URL (November 2025)
  final String baseUrl = 'https://4dqz0.wiremockapi.cloud/pizzalist';
  // If you didn't set a path, use this instead:
  // final String baseUrl = 'https://4dqz0.wiremockapi.cloud/';

  Future<List<Pizza>> getPizzaList() async {
    try {
      final response = await http.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Pizza.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }

  Future<String> postPizza(Pizza pizza) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pizza.toJson()),
    );
    return response.body;
  }

  Future<String> putPizza(Pizza pizza) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pizza.toJson()),
    );
    return response.body;
  }

  Future<String> deletePizza(int id) async {
    final response = await http.delete(Uri.parse(baseUrl));
    return response.body;
  }
}