import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  final Function(String) onTaskAdded;

  const AddTaskDialog({super.key, required this.onTaskAdded});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: Text('เพิ่มแผนของฉัน'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'พิมพ์ชื่อแผนที่ต้องทำ'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('ยกเลิก'),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onTaskAdded(controller.text);
              Navigator.pop(context);
            }
          },
          child: Text('เพิ่ม'),
        ),
      ],
    );
  }
}
