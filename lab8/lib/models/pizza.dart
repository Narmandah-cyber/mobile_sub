class Pizza {
  int? id;
  String pizzaName;
  String description;
  double price;
  String imageUrl;

  Pizza({
    this.id,
    this.pizzaName = '',
    this.description = '',
    this.price = 0.0,
    this.imageUrl = '',
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      pizzaName: json['pizzaName']?.toString() ?? 'No name',
      description: json['description']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaName': pizzaName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}