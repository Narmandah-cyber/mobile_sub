import 'package:flutter/material.dart';
import 'models/pizza.dart';
import 'services/http_helper.dart';
import 'screens/pizza_detail_screen.dart';

void main() {
  runApp(const PizzaApp());
}

class PizzaApp extends StatelessWidget {
  const PizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza CRUD - Chapter 9 Style',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PizzaHomePage(),
    );
  }
}

class PizzaHomePage extends StatefulWidget {
  const PizzaHomePage({super.key});

  @override
  State<PizzaHomePage> createState() => _PizzaHomePageState();
}

class _PizzaHomePageState extends State<PizzaHomePage> {
  final HttpHelper helper = HttpHelper();
  List<Pizza> pizzas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPizzas();
  }

  Future<void> loadPizzas() async {
    setState(() => isLoading = true);
    final List<Pizza> fetched = await helper.getPizzaList();
    setState(() {
      pizzas = fetched;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pizzas.isEmpty
              ? const Center(child: Text('No pizzas found'))
              : ListView.builder(
                  itemCount: pizzas.length,
                  itemBuilder: (context, index) {
                    final pizza = pizzas[index];
                    return Dismissible(
                      key: Key(pizza.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) async {
                        await helper.deletePizza(pizza.id ?? 0);
                        setState(() {
                          pizzas.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pizza deleted')),
                        );
                      },
                      child: ListTile(
                        title: Text(pizza.pizzaName),
                        subtitle: Text('${pizza.description} - €${pizza.price}'),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PizzaDetailScreen(pizza: pizza, isNew: false),
                            ),
                          );
                          loadPizzas(); // Refresh after edit
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PizzaDetailScreen(pizza: Pizza(), isNew: true),
            ),
          );
          loadPizzas(); // This fixes the create button!
        },
      ),
    );
  }
}