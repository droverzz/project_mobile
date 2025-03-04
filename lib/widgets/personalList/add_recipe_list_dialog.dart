import 'package:flutter/material.dart';

class AddPlaylistDialog extends StatelessWidget {
  final Function(String) onAdd;

  const AddPlaylistDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextEditingController controller = TextEditingController();

    return AlertDialog(
      // ignore: deprecated_member_use
      backgroundColor: theme.dialogBackgroundColor,
      title: Text(
        "ตั้งชื่อ Playlist",
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
              onAdd(controller.text);
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
