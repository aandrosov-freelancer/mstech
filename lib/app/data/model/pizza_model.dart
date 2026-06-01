class PizzaModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final List<String> ingredients;

  PizzaModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.ingredients,
  });

  factory PizzaModel.fromJson(Map<String, dynamic> json) => PizzaModel(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    imageUrl: json['imageUrl'] as String,
    price: (json['price'] as num).toDouble(),
    ingredients: List<String>.from(json['ingredients'] as List),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'price': price,
    'ingredients': ingredients,
  };
}
