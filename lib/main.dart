import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/search_camera_screen.dart';
import 'screens/todo_screen.dart';
import 'screens/book_mark_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavScreen(),
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    BookMarkScreen(),
    SearchCameraScreen(),
    ToDoList(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF1F1F39),
        selectedItemColor: Color(0xFFEC4751),
        unselectedItemColor: Color(0xFFB8B8D2),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าแรก'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'บันทึกเมนู'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera), label: 'สกแกนวัตถุดิบ'),
          BottomNavigationBarItem(icon: Icon(Icons.format_list_numbered), label: 'วางแผน'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'ตั้งค่า'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
