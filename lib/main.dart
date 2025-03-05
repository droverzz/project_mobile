import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/search_camera_screen.dart';
import 'screens/todo_screen.dart';
import 'screens/bookmark/bookmark_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.theme,
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
    final bottomNavTheme = Theme.of(context).bottomNavigationBarTheme;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Bottom Navigation Bar
          Container(
            padding: const EdgeInsets.only(top: 20), 
            decoration: BoxDecoration(
              color: bottomNavTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
      
              selectedItemColor: bottomNavTheme.selectedItemColor,
              unselectedItemColor: bottomNavTheme.unselectedItemColor,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'หน้าแรก'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark), label: 'บันทึกเมนู'),
                BottomNavigationBarItem(
                    icon: SizedBox.shrink(), label: ''), 
                BottomNavigationBarItem(
                    icon: Icon(Icons.format_list_numbered), label: 'วางแผน'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'ตั้งค่า'),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),

          // Floating Camera Button
          Positioned(
            top: -20, 
            child: GestureDetector(
              onTap: () => _onItemTapped(2),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bottomNavTheme.selectedItemColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
