import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipeDetail/add_to_buy.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save video to...'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPlaylistItem('Watch later'),
              _buildPlaylistItem('ไทย'),
              _buildPlaylistItem('En'),
              Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // ปิด Dialog
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaylistItem(String title) {
    return ListTile(
      leading: Checkbox(value: false, onChanged: (bool? value) {}),
      title: Text(title),
      trailing: Icon(Icons.lock), // ไอคอนแม่กุญแจ 🔒
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: recipe.imagePath.isEmpty
                  ? Image.asset(
                      'assets/images/food_placeholder.png',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      recipe.imagePath,
                      fit: BoxFit.cover,
                    ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.bookmark_add),
                onPressed: () => _showSaveDialog(context), // เรียก Dialog
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      recipe.isLlmGenerated
                          ? Text('สร้างโดย Food Guru',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold))
                          : Text('จากฐานข้อมูล',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('${recipe.totalCalories} แคล',
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                      Divider(),
                      Text('ส่วนผสม',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      ...recipe.ingredients.map((ingredient) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(ingredient.name,
                                    style: TextStyle(fontSize: 16)),
                                Row(
                                  children: [
                                    Text(
                                        '${ingredient.quantity} ${ingredient.unit}',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.red)),
                                    SizedBox(width: 10),
                                    AddToBuyButton(
                                        ingredientName: ingredient.name),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Divider(),
                      Text('วิธีทำ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      ...recipe.instructions
                          .asMap()
                          .entries
                          .map((entry) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${entry.key + 1}. ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Expanded(
                                      child: Text(entry.value,
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                  ],
                                ),
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
