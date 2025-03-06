import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_group_project/helpers/menu_db.dart';
import 'package:flutter_application_group_project/screens/camera/take_picture_screen.dart';
import 'package:provider/provider.dart';
import 'theme/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/search_camera_screen.dart';
import 'screens/todo_screen.dart';
import 'screens/bookmark/bookmark_screen.dart';
import 'screens/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(
        camera: firstCamera,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    final menuDbJson = MenuDbJson();

    return FutureBuilder(
      future: menuDbJson.loadJsonData('assets/meals.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error loading data')),
            ),
          );
        } else {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeProvider.theme,
                home: BottomNavScreen(camera: camera),
              );
            },
          );
        }
      },
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  final CameraDescription camera;

  const BottomNavScreen({super.key, required this.camera});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(),
      BookMarkScreen(),
      SearchCameraScreen(),
      ToDoList(),
      SettingsScreen(),
    ];
  }

  void _pushCameraScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: widget.camera),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      _pushCameraScreen();
    }
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
              enableFeedback: false,
              selectedFontSize: 14,
              selectedItemColor: bottomNavTheme.selectedItemColor,
              unselectedItemColor: bottomNavTheme.unselectedItemColor,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'หน้าแรก'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark), label: 'บันทึกเมนู'),
                BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
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
