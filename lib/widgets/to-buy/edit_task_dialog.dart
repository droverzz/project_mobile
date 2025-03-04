import 'package:flutter/material.dart';

class EditTaskDialog extends StatelessWidget {
  final String currentTask;
  final Function(String) onTaskUpdated;

  const EditTaskDialog(
      {super.key, required this.currentTask, required this.onTaskUpdated});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextEditingController controller = TextEditingController(text: currentTask);

    return AlertDialog(
      title: Text('แก้ไขแผนของฉัน'),
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
              onTaskUpdated(controller.text);
              Navigator.pop(context);
            }
          },
          child: Text('บันทึก',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
