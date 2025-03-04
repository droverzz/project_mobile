import 'package:flutter/material.dart';

class EditTaskDialog extends StatelessWidget {
  final String currentTask;
  final Function(String) onTaskUpdated;

  const EditTaskDialog({super.key, required this.currentTask, required this.onTaskUpdated});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: currentTask);

    return AlertDialog(
      title: Text('แก้ไขแผนของฉัน'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'พิมพ์ชื่อใหม่'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('ยกเลิก'),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onTaskUpdated(controller.text);
              Navigator.pop(context);
            }
          },
          child: Text('บันทึก'),
        ),
      ],
    );
  }
}
