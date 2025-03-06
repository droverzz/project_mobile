import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_group_project/screens/recipe_detail_screen.dart';

import '../models/recipe.dart';

class RecipesBrowse extends StatelessWidget {
  final List<Recipe> llmRecipes;
  final List<Recipe> nameRecipes;
  final List<Recipe> ingredientRecipes;

  const RecipesBrowse(
      {super.key,
      required this.llmRecipes,
      required this.nameRecipes,
      required this.ingredientRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ผลลัพธ์การค้นหา'),
        ),
        body: Container(
          child: Column(
            children: [
              Divider(),
              SizedBox(height: 10),
              Text('สูตรจาก Food Guru'),
              SizedBox(height: 15),
              ...llmRecipes.map((recipe) => ListTile(
                    leading: ClipOval(
                      child: Image.asset(
                        'assets/images/food_placeholder.png',
                        width: 50, // Adjust the width and height as needed
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(recipe.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                  )),
              Text('สูตรจากชื่ออาหาร'),
              SizedBox(height: 15),
              ...nameRecipes.map((recipe) => ListTile(
                    leading: ClipOval(
                      child: Image.asset(
                        recipe.imagePath,
                        width: 50, // Adjust the width and height as needed
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(recipe.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                  )),
              Text('สูตรจากชื่อวัตถุดิบ'),
              SizedBox(height: 15),
              ...ingredientRecipes.map((recipe) => ListTile(
                    leading: ClipOval(
                      child: Image.asset(
                        recipe.imagePath,
                        width: 50, // Adjust the width and height as needed
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(recipe.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ));
  }
}
