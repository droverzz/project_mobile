import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_group_project/helpers/food_guru.dart';
import 'package:flutter_application_group_project/helpers/menu_db.dart';
import 'package:flutter_application_group_project/models/recipe.dart';
import 'package:flutter_application_group_project/screens/recipe_detail_screen.dart';
import 'package:flutter_application_group_project/screens/recipes_browse.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFood extends StatefulWidget {
  const SearchFood({super.key});

  @override
  State<SearchFood> createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: _controller,
      onChanged: (text) => setState(() {}),
      focusNode: focusNode,
      style: GoogleFonts.kanit(
        color: theme.textTheme.bodyMedium!.color,
      ),
      decoration: InputDecoration(
        labelStyle: GoogleFonts.kanit(
          color: theme.textTheme.bodyMedium!.color,
        ),
        labelText: 'ค้นหาด้วยชื่อ/วัตถุดิบ || 🤤 Food Guru',
        border: OutlineInputBorder(),
      ),
      onTapOutside: (pointer) => focusNode.unfocus(),
      onSubmitted: (value) async {
        try {
          _loadingDialog(context);
          final llmGeneratedRecipes =
              await FoodGuru().findRecipes(_controller.text);
          final fromNameRecipes =
              MenuDbJson().getRecipesFromRecipeName(_controller.text);
          final fromIngredientsRecipes =
              MenuDbJson().getRecipesFromIngredientName(_controller.text);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipesBrowse(
                llmRecipes: llmGeneratedRecipes,
                nameRecipes: fromNameRecipes,
                ingredientRecipes: fromIngredientsRecipes,
              ),
            ),
          );
        } catch (e) {
          Navigator.pop(context);
          _errorDialog(context);
        }
      },
    );
  }
}

void _loadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text('กำลังโหลดข้อมูล...'),
          ],
        ),
      );
    },
  );
}

void _errorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('ไม่สามารถเชื่อมต่อกับ Food Guru ได้'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ปิด'),
          ),
        ],
      );
    },
  );
}
