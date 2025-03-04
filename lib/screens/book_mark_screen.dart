import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/personalList/add_recipe_list_dialog.dart';
import '../widgets/personalList/edit_recipe_list_dialog.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookMarkScreen> {
  List<String> playlists = [];

  @override
  void initState() {
    super.initState();
    _loadPlaylistsFromFile();
  }

  /// ดึง path ของไฟล์ JSON ที่ใช้เก็บข้อมูล
  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/playlists.json';
  }

  /// บันทึกข้อมูลลงไฟล์ JSON
  Future<void> _savePlaylistsToFile() async {
    final filePath = await _getFilePath();
    final file = File(filePath);
    await file.writeAsString(jsonEncode(playlists));
  }

  /// โหลดข้อมูลจากไฟล์ JSON
  Future<void> _loadPlaylistsFromFile() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        setState(() {
          playlists = List<String>.from(jsonDecode(contents));
        });
      }
    } catch (e) {
      print("Error loading playlists: $e");
    }
  }

  /// เพิ่มรายการอาหารส่วนตัวเรียใช้ widgets add_recipe_list
  void _addPlaylist() {
    showDialog(
      context: context,
      builder: (context) => AddPlaylistDialog(
        onAdd: (name) {
          setState(() => playlists.add(name));
          _savePlaylistsToFile();
        },
      ),
    );
  }
  /// แก้ไขรายการอาหารส่วนตัวเรียใช้ widgets add_recipe_list
  void _editPlaylist(int index) {
    showDialog(
      context: context,
      builder: (context) => EditPlaylistDialog(
        initialName: playlists[index],
        onEdit: (name) {
          setState(() => playlists[index] = name);
          _savePlaylistsToFile();
        },
      ),
    );
  }

  void _deletePlaylist(int index) {
    setState(() => playlists.removeAt(index));
    _savePlaylistsToFile(); // บันทึกไฟล์
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          "บันทึกเมนู",
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: playlists.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ไม่มีรายการบันทึก', style: theme.textTheme.bodyLarge),
                    SizedBox(height: 8),
                    Text(
                      'คุณยังไม่ได้บันทึกรายการอาหาร',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.hintColor),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            playlists[index],
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: PopupMenuButton<String>(
                            color: theme.cardColor,
                            onSelected: (value) {
                              if (value == "edit") _editPlaylist(index);
                              if (value == "delete") _deletePlaylist(index);
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: "edit",
                                child: Row(
                                  children: [
                                    Icon(Icons.edit,
                                        color: theme.iconTheme.color, size: 20),
                                    SizedBox(width: 8),
                                    Text("แก้ไขชื่อ",
                                        style: theme.textTheme.bodyMedium),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: "delete",
                                child: Row(
                                  children: [
                                    Icon(Icons.delete,
                                        color: theme.iconTheme.color, size: 20),
                                    SizedBox(width: 8),
                                    Text("ลบ",
                                        style: theme.textTheme.bodyMedium),
                                  ],
                                ),
                              ),
                            ],
                            icon: Icon(Icons.more_vert,
                                color: theme.iconTheme.color),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPlaylist,
        shape: CircleBorder(),
        elevation: 10,
        backgroundColor: theme.primaryColor,
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary, size: 36),
      ),
    );
  }
}
