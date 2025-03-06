import 'package:flutter/material.dart';

class EditPlaylistDialog extends StatelessWidget {
  final String initialName;
  final Function(String) onEdit;

  const EditPlaylistDialog(
      {Key? key, required this.initialName, required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextEditingController controller = TextEditingController(text: initialName);

    return AlertDialog(
      title: Text(
        "แก้ไขชื่อ Playlist",
        style:
            theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      content: TextField(
        controller: controller,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: 'พิมพ์ชื่อใหม่',
          hintStyle: TextStyle(color: Colors.grey[400]), // สีที่อ่อนลง
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("ยกเลิก", style: theme.textTheme.bodyLarge),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onEdit(controller.text);
              Navigator.pop(context);
            }
          },
          child: Text("บันทึก",
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
