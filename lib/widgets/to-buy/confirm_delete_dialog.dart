import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String taskName;
  final VoidCallback onConfirm;

  const ConfirmDeleteDialog({
    super.key,
    required this.taskName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text('ยืนยันการลบ'),
      content: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: 'คุณต้องการลบรายการ '),
            TextSpan(
              text: '" $taskName "',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ' ใช่ไหม?'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('ยกเลิก', style: theme.textTheme.bodyLarge),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text('ลบ',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
