class Bookmark {
  final String name;
  final String description;
  final List<String> savedRecipes;

  Bookmark(
      {required this.name,
      required this.description,
      required this.savedRecipes});

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      name: json['name'],
      description: json['description'],
      savedRecipes: List<String>.from(json['saved_recipes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'saved_recipes': savedRecipes,
    };
  }
}
