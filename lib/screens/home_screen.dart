import 'package:flutter/material.dart';
import 'package:flutter_application_group_project/helpers/menu_db.dart';
import 'package:flutter_application_group_project/models/recipe.dart';
import 'package:flutter_application_group_project/screens/recipe_detail_screen.dart';
import 'package:flutter_application_group_project/widgets/recipe_card.dart';
import 'package:flutter_application_group_project/widgets/search/search_food.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final randomRecipe = MenuDbJson().getRandomRecipes(4);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'หน้าแรก',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface, // ใช้สีของ primary color
          ), // ใช้ theme text
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
                decoration: BoxDecoration(
                  color: theme.cardColor, // ใช้สีของ theme
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SearchFood(initialKeyword: "")),
            SizedBox(height: 20),

            // เมนูมาแรงวันนี้
            Text(
              'เมนูแนะนำ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface, // ใช้สี primary
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                randomRecipe.elementAtOrNull(0) != null
                    ? RecipeCard(recipe: randomRecipe.elementAt(0))
                    : Container(),
                randomRecipe.elementAtOrNull(1) != null
                    ? RecipeCard(recipe: randomRecipe.elementAt(1))
                    : Container(),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                randomRecipe.elementAtOrNull(2) != null
                    ? RecipeCard(recipe: randomRecipe.elementAt(2))
                    : Container(),
                randomRecipe.elementAtOrNull(3) != null
                    ? RecipeCard(recipe: randomRecipe.elementAt(3))
                    : Container(),
              ],
            ),
            SizedBox(height: 20),

            // รายการค้นหาล่าสุด
            Text(
              'รายการค้นหาล่าสุด',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface, // ใช้สี primary
              ),
            ),
            SizedBox(height: 10),

            _buildRecentSearch(context, 'ปีกไก่', '3 วันที่แล้ว'),
            _buildRecentSearch(context, 'หมู, กระเทียม', '21 ม.ค. 2025'),
          ],
        ),
      ),
    );
  }

  // รายการค้นหาล่าสุด
  Widget _buildRecentSearch(BuildContext context, String title, String date) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor, // ใช้สีของ theme
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary, // ใช้สี primary
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.kanit(
                    textStyle: theme.textTheme.bodyLarge?.copyWith()),
              ),
              Text(
                date,
                style: GoogleFonts.kanit(
                    textStyle: theme.textTheme.bodyMedium?.copyWith()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
