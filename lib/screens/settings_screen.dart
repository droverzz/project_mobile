import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F39),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'ตั้งค่า',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            _buildSettingItem(context, 'ภาษา'),
            _buildSettingItem(context, 'เกี่ยวกับทุกภาษา'),
            _buildSettingItem(context, 'ธีม'),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {
        // กำหนด action เมื่อกดปุ่ม
      },
    );
  }
}
