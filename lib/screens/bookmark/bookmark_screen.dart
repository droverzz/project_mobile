import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../widgets/personalList/add_recipe_list_dialog.dart';
import '../../widgets/personalList/edit_recipe_list_dialog.dart';
import '../../models/bookmark.dart';
import 'bookmark_detail_screen.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookMarkScreen> {
  List<Bookmark> bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarksFromFile();
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/bookmarks.json';
  }

  Future<void> _saveBookmarksToFile() async {
    final filePath = await _getFilePath();
    final file = File(filePath);
    await file.writeAsString(jsonEncode(bookmarks.map((b) => b.toJson()).toList()));
  }

  Future<void> _loadBookmarksFromFile() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        setState(() {
          bookmarks = (jsonDecode(contents) as List)
              .map((json) => Bookmark.fromJson(json))
              .toList();
        });
      }
    } catch (e) {
      print("Error loading bookmarks: $e");
    }
  }

  void _addBookmark() {
    showDialog(
      context: context,
      builder: (context) => AddPlaylistDialog(
        onAdd: (name) {
          setState(() => bookmarks.add(Bookmark(name: name, description: '', savedRecipes: [])));
          _saveBookmarksToFile();
        },
      ),
    );
  }

  void _editBookmark(int index) {
    showDialog(
      context: context,
      builder: (context) => EditPlaylistDialog(
        initialName: bookmarks[index].name,
        onEdit: (name) {
          setState(() => bookmarks[index] = Bookmark(name: name, description: bookmarks[index].description, savedRecipes: bookmarks[index].savedRecipes));
          _saveBookmarksToFile();
        },
      ),
    );
  }

  void _deleteBookmark(int index) {
    setState(() => bookmarks.removeAt(index));
    _saveBookmarksToFile();
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
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: bookmarks.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ไม่มีรายการบันทึก', style: theme.textTheme.bodyLarge),
              SizedBox(height: 8),
              Text(
                'คุณยังไม่ได้บันทึกรายการอาหาร',
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
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
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookmarkDetailScreen(bookmark: bookmarks[index]),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        bookmarks[index].name,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: PopupMenuButton<String>(
                        color: theme.cardColor,
                        onSelected: (value) {
                          if (value == "edit") _editBookmark(index);
                          if (value == "delete") _deleteBookmark(index);
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: "edit",
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: theme.iconTheme.color, size: 20),
                                SizedBox(width: 8),
                                Text("แก้ไขชื่อ", style: theme.textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: "delete",
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: theme.iconTheme.color, size: 20),
                                SizedBox(width: 8),
                                Text("ลบ", style: theme.textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ],
                        icon: Icon(Icons.more_vert, color: theme.iconTheme.color),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBookmark,
        shape: CircleBorder(),
        elevation: 10,
        backgroundColor: theme.primaryColor,
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary, size: 36),
      ),
    );
  }
}