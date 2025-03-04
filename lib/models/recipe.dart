class Recipe {
  String name;
  String description;
  List<Ingredient> ingredients;
  List<String> instructions;
  double totalCalories;
  String imagePath;

  Recipe({
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.totalCalories,
    this.imagePath = '',
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      description: json['description'],
      ingredients: (json['ingredients'] as List)
          .map((i) => Ingredient.fromJson(i))
          .toList(),
      instructions: List<String>.from(json['instructions']),
      totalCalories: (json['total_calories'] as num).toDouble(),
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
      'instructions': instructions,
      'total_calories': totalCalories,
      'image_path': imagePath,
    };
  }
}

class Ingredient {
  String name;
  double quantity;
  String unit;
  bool isOptional;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.isOptional,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'],
      isOptional: json['isOptional'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'isOptional': isOptional,
    };
  }
}