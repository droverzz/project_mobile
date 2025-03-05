import 'package:flutter/material.dart';

class SearchCameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'ค้นหา',
        style: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.onSurface, // ใช้สีของ primary color
        ),
      )),
      body: Center(
        child: Text('นี่คือหน้าค้นหา', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
