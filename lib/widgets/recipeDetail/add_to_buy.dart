import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class AddToBuyButton extends StatelessWidget {
  final String ingredientName;

  const AddToBuyButton({Key? key, required this.ingredientName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_circle, color: Colors.green),
      onPressed: () => _addToToDoList(context),
    );
  }

  /// ฟังก์ชันเพิ่มส่วนผสมลงใน To-Do List และแสดง Snackbar
  Future<void> _addToToDoList(BuildContext context) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/todo_data.json');

    List<String> tasks = [];

    // โหลด task เก่ามาก่อน
    if (await file.exists()) {
      final data = jsonDecode(await file.readAsString());
      tasks = List<String>.from(data['tasks']);
    }

    // เพิ่มวัตถุดิบเข้าไปใน tasks
    tasks.add(ingredientName);
    final updatedData = jsonEncode({'tasks': tasks, 'completedTasks': []});
    await file.writeAsString(updatedData);

    // แสดง Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('เพิ่ม "$ingredientName" ลงใน To-Do List แล้ว!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
