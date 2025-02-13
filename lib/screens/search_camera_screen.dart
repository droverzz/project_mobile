import 'package:flutter/material.dart';

class SearchCameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ค้นหา')),
      body: Center(
        child: Text('นี่คือหน้าค้นหา', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
