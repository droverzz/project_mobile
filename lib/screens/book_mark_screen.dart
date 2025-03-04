import 'package:flutter/material.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookMarkScreen> {
  List<String> playlists = [];

  void _addPlaylist() {
    final theme = Theme.of(context);
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            // ignore: deprecated_member_use
            theme.dialogBackgroundColor, 
        title: Text(
          "ตั้งชื่อ Playlist",
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: "ชื่อ Playlist",
            hintStyle:
                theme.textTheme.bodyMedium?.copyWith(color: Colors.white54),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("ยกเลิก", style: theme.textTheme.bodyLarge),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => playlists.add(controller.text));
                Navigator.pop(context);
              }
            },
            child: Text("บันทึก",
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _editPlaylist(int index) {
    final theme = Theme.of(context);
    TextEditingController controller =
        TextEditingController(text: playlists[index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // ignore: deprecated_member_use
        backgroundColor: theme.dialogBackgroundColor,
        title: Text(
          "แก้ไขชื่อ Playlist",
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: "ชื่อ Playlist",
            hintStyle:
                theme.textTheme.bodyMedium?.copyWith(color: Colors.white54),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("ยกเลิก", style: theme.textTheme.bodyLarge),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => playlists[index] = controller.text);
                Navigator.pop(context);
              }
            },
            child: Text("บันทึก",
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _deletePlaylist(int index) {
    setState(() => playlists.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // ใช้ Theme ของแอป

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // ใช้สีของ theme
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor, // ใช้สี app bar
        elevation: 0,
        title: Text(
          "บันทึกเมนู",
          style: theme.textTheme.headlineSmall, // ใช้ theme text
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
                    Text(
                      'ไม่มีรายการบันทึก',
                      style: theme.textTheme.bodyLarge, // ใช้ text theme
                    ),
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
                      color: theme.cardColor, // ใช้สีจาก theme
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
                            color: theme.cardColor, // ใช้สีจาก theme
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
        backgroundColor: theme.primaryColor, // ใช้สี primary จาก theme
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary, size: 36),
      ),
    );
  }
}
