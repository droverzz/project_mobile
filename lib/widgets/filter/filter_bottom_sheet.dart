import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  List<String> categories = ['สุขภาพ', 'อาหารคีโต', 'มังสวิรัติ', 'ลดน้ำหนัก'];
  List<String> selectedCategories =
      []; // เปลี่ยนเป็น List สำหรับเลือกหลายหมวดหมู่
  RangeValues calorieRange = RangeValues(100, 500);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Colors.white,
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // color: Colors.black
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text('หมวดหมู่',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // color: Colors.black
              )),
          Wrap(
            spacing: 8,
            children: categories.map((category) {
              bool isSelected = selectedCategories.contains(category);
              return ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedCategories.add(category); // เพิ่มหมวดหมู่ที่เลือก
                    } else {
                      selectedCategories
                          .remove(category); // ลบหมวดหมู่ที่ยกเลิกการเลือก
                    }
                  });
                },
                // selectedColor: Colors.blue,
                // backgroundColor: Colors.grey[300],
                // labelStyle:
                //     TextStyle(color: isSelected ? Colors.white : Colors.black),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text('จำนวนแคลอรี่',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // color: Colors.black
              )),
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
            activeColor: Colors.blue,
            inactiveColor: Colors.grey[300],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCategories.clear(); // รีเซ็ตหมวดหมู่ที่เลือก
                    calorieRange =
                        RangeValues(100, 500); // รีเซ็ตค่าปริมาณแคลอรี่
                  });
                },
                child: Text('ค่าเริ่มต้น',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.blue,
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
