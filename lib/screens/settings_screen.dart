import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'ตั้งค่า',
          style: theme.textTheme.headlineSmall, 
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // _buildSettingItem(context, 'ภาษา'),
          // _buildSettingItem(context, 'เกี่ยวกับแอปพลิเคชัน'),
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
