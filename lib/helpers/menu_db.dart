import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/recipe.dart';

abstract class MenuDb {
  Future<void> loadJsonData(String path);

  Iterable<String> search(String keyword);
}

class MenuDbJson implements MenuDb {
  dynamic menuData;

  static final MenuDbJson _instance = MenuDbJson._internal();

  factory MenuDbJson() {
    return _instance;
  }

  MenuDbJson._internal();

  Future<void> loadJsonData(String path) async {
    String jsonString = await rootBundle.loadString(path);
    final jsonResult = jsonDecode(jsonString);
    this.menuData = jsonResult;
    print(jsonResult);
  }

  Iterable<String> search(String keyword) {
    if (menuData == null || menuData["meals"] == null) {
      return [];
    }

    Iterable<String> resultByName = menuData["meals"]
        .where((item) => item["name"]
            .toString()
            .toLowerCase()
            .contains(keyword.toLowerCase()))
        .map((item) => item["name"].toString())
        .cast<String>();
    Iterable<String> resultByIngredients = menuData["meals"]
        .where((dynamic item) {
          return (item["ingredients"] as List<dynamic>).any((dynamic ingres) {
            // Explicitly cast `ingres["ingredient"]` to `String`
            return (ingres["name"] as String)
                .toLowerCase()
                .contains(keyword.toLowerCase());
          });
        })
        .map((dynamic item) => item["name"].toString())
        .cast<String>();

    Iterable<String> combinedResults = [
      "--- จากชื่ออาหาร ---",
      ...resultByName,
      "--- จากส่วนประกอบ ---",
      ...resultByIngredients,
    ];

    return combinedResults;
  }

  Iterable<Recipe> searchRecipe(String keyword) {
    if (menuData == null || menuData["meals"] == null) {
      return [];
    }

    Iterable<Recipe> resultByName = menuData["meals"]
        .where((item) => item["name"]
            .toString()
            .toLowerCase()
            .contains(keyword.toLowerCase()))
        .map((item) => Recipe.fromJson(item))
        .cast<Recipe>();
    Iterable<Recipe> resultByIngredients = menuData["meals"]
        .where((dynamic item) {
          return (item["ingredients"] as List<dynamic>).any((dynamic ingres) {
            // Explicitly cast `ingres["ingredient"]` to `String`
            return (ingres["name"] as String)
                .toLowerCase()
                .contains(keyword.toLowerCase());
          });
        })
        .map((dynamic item) => Recipe.fromJson(item))
        .cast<Recipe>();

    Iterable<Recipe> combinedResults = [
      Recipe.fromJson({
        "name": "--- ถาม Food Guru ---",
        "description": "",
        "ingredients": [],
        "instructions": [],
        "total_calories": 0,
        "image_path": "",
      }),
      Recipe.fromJson({
        "name": "--- จากชื่ออาหาร ---",
        "description": "",
        "ingredients": [],
        "instructions": [],
        "total_calories": 0,
        "image_path": "",
      }),
      ...resultByName,
      Recipe.fromJson({
        "name": "--- จากส่วนประกอบ ---",
        "description": "",
        "ingredients": [],
        "instructions": [],
        "total_calories": 0,
        "image_path": "",
      }),
      ...resultByIngredients,
    ];

    return combinedResults;
  }

  Recipe? getByRecipeName(String recipeName) {
    if (menuData == null || menuData["meals"] == null) {
      return null;
    }

    final recipe = menuData["meals"]
        .firstWhere((item) => item["name"].toString() == recipeName, orElse: () => null);
    if (recipe == null) {
      return null;
    }

    return Recipe.fromJson(recipe);
  }

  Iterable<Recipe> getRandomRecipes(int count) {
    if (menuData == null || menuData["meals"] == null) {
      return [];
    }

    List<dynamic> randomMeals = [];
    for (int i = 0; i < count; i++) {
      randomMeals.add(menuData["meals"][i]);
    }

    return randomMeals.map((item) => Recipe.fromJson(item)).cast<Recipe>();
  }
}
