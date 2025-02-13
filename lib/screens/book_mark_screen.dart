import 'package:flutter/material.dart';

class BookMarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('บันทึกเมนู')),
      body: Center(
        child: Text('นี่คือหน้าบันทึกเมนู', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
