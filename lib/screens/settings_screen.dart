import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ตั้งค่า')),
      body: Center(
        child: Text('นี่คือหน้าตั้งค่า', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
