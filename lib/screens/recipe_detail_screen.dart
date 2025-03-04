import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset(
              height: recipe.imagePath == ''
                  ? 200
                  : null,
              recipe.imagePath == ''
                  ? 'assets/images/food_placeholder.png'
                  : recipe.imagePath),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '- ${recipe.description}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'ส่วนประกอบ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: recipe.ingredients
                .asMap()
                .entries
                .map((entry) => Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${entry.key + 1}. ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '${entry.value.name} --> ${entry.value.quantity} ${entry.value.unit}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'ขั้นตอนการทำ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: recipe.instructions
                .asMap()
                .entries
                .map((entry) => Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${entry.key + 1}. ${entry.value}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'จำนวนแคลอรี่ทั้งหมด: ${recipe.totalCalories}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.bookmark_add),
      ),
    );
  }
}
