import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/pizza.dart';
import '../services/http_helper.dart';

class PizzaDetailScreen extends StatefulWidget {
  final Pizza pizza;
  final bool isNew;

  const PizzaDetailScreen({super.key, required this.pizza, required this.isNew});

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _imageController;
  String resultMessage = '';

  final helper = HttpHelper();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pizza.pizzaName);
    _descController = TextEditingController(text: widget.pizza.description);
    _priceController = TextEditingController(text: widget.pizza.price.toString());
    _imageController = TextEditingController(text: widget.pizza.imageUrl);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _savePizza() async {
    if (!_formKey.currentState!.validate()) return;

    Pizza pizza = Pizza(
      id: widget.pizza.id,
      pizzaName: _nameController.text,
      description: _descController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      imageUrl: _imageController.text,
    );

    String jsonResponse = widget.isNew
        ? await helper.postPizza(pizza)
        : await helper.putPizza(pizza);

    final Map<String, dynamic> responseMap = json.decode(jsonResponse);
    setState(() {
      resultMessage = responseMap['message'] ?? 'Success!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: const Text('Pizza Detail'),
),      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (resultMessage.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    color: Colors.green[100],
                    child: Text(
                      resultMessage,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Pizza Name', border: OutlineInputBorder()),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price (€)', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v!.isEmpty) return 'Required';
                    if (double.tryParse(v) == null) return 'Invalid number';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(labelText: 'Image URL (optional)', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
  onPressed: _savePizza,
  child: Text(widget.isNew ? 'Send Post' : 'Update Pizza'),
)
              ],
            ),
          ),
        ),
      ),
    );
  }
}