import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_group_project/helpers/food_guru.dart';
import 'package:flutter_application_group_project/helpers/menu_db.dart';
import 'package:flutter_application_group_project/models/recipe.dart';
import 'package:flutter_application_group_project/screens/recipe_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFood extends StatefulWidget {
  final String initialKeyword;

  const SearchFood({super.key, required this.initialKeyword});

  @override
  State<SearchFood> createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialKeyword;
  }

  @override
  void didUpdateWidget(covariant SearchFood oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the initialKeyword has changed
    _controller.text = widget.initialKeyword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        final searchResult = MenuDbJson().searchRecipe(textEditingValue.text);
        return searchResult.map((e) => e.name).toList();
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        textEditingController.text = _controller.text;
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
        );
      },
      onSelected: (value) async {
        if (value == '--- ถาม Food Guru ---') {
          try {
            _loadingDialog(context);
            final stream =
                FoodGuru().provider.sendMessageStream(_controller.text);
            var response = await stream.join();
            final json = jsonDecode(response);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RecipeDetailScreen(recipe: Recipe.fromJson(json['recipe'])),
              ),
            );
          } catch (e) {
            Navigator.pop(context);
            _errorDialog(context);
          }
          return;
        }
        final recipe = MenuDbJson().getByRecipeName(value);
        if (recipe != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(recipe: recipe),
            ),
          );
        }
        setState(() {
          _controller.text = value;
        });
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
