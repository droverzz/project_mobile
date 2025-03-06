import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  List<String> categories = ['สุขภาพ', 'อาหารคีโต', 'มังสวิรัติ', 'ลดน้ำหนัก'];
  List<String> selectedCategories = [];
  RangeValues calorieRange = RangeValues(100, 500);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final secondaryColor = theme.colorScheme.secondary;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ตัวกรองการค้นหา',
                style: theme.textTheme.titleLarge,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text('หมวดหมู่', style: theme.textTheme.titleMedium),
          Wrap(
            spacing: 8,
            children: categories.map((category) {
              bool isSelected = selectedCategories.contains(category);
              return ChoiceChip(
                label: Text(category, style: TextStyle(color: Colors.white)),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedCategories.add(category);
                    } else {
                      selectedCategories.remove(category);
                    }
                  });
                },
                selectedColor: secondaryColor,
                backgroundColor: Color(0xFF858597),
                shape: StadiumBorder(),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text('จำนวนแคลอรี่', style: theme.textTheme.titleMedium),
          RangeSlider(
            values: calorieRange,
            min: 0,
            max: 1000,
            divisions: 20,
            labels: RangeLabels(
              '${calorieRange.start.round()} แคล',
              '${calorieRange.end.round()} แคล',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                calorieRange = values;
              });
            },
            activeColor: secondaryColor,
            inactiveColor: isDark ? Colors.white : Colors.grey[300],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCategories.clear();
                    calorieRange = RangeValues(100, 500);
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF858597),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('ค่าเริ่มต้น',
                    style: TextStyle(color: Color(0xFFFCF7F8))),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? Color(0xFFEC4751) : Color(0xFFA31621),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('ยืนยันตัวกรอง',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
