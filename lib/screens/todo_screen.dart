import 'package:flutter/material.dart';

class toDoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('โปรไฟล์')),
      body: Center(
        child: Text('นี่คือหน้าข้อมูลส่วนตัว', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
