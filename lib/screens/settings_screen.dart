import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // ใช้ listen: true

    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งค่า'),
      ),
      body: Column(
        children: [
          _buildSettingItem(context, 'ภาษา'),
          _buildSettingItem(context, 'เกี่ยวกับทุกภาษา'),
          _buildSettingItem(context, 'ธีม', isThemeSwitch: true),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title,
      {bool isThemeSwitch = false}) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return ListTile(
      title: Text(title),
      trailing: isThemeSwitch
          ? Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            )
          : Icon(Icons.chevron_right),
    );
  }
}
