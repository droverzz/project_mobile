import 'package:flutter/material.dart';

class toDoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('วางแผน')),
      body: Center(
        child: Text('นี่คือหน้าวางแผน', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
