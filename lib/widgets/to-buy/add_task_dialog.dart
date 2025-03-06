import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  final Function(String) onTaskAdded;

  const AddTaskDialog({super.key, required this.onTaskAdded});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: Text(
        'เพิ่มแผนของฉัน',
        style:
            theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'พิมพ์ชื่อใหม่',
          hintStyle: TextStyle(color: Colors.grey[400]), // สีที่อ่อนลง
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('ยกเลิก', style: theme.textTheme.bodyLarge),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onTaskAdded(controller.text);
              Navigator.pop(context);
            }
          },
          child: Text('เพิ่ม',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
