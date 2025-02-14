import 'package:flutter/material.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookMarkScreen> {
  List<String> playlists = [];

  void _addPlaylist() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1F1F39),
        title: Text(
          "ตั้งชื่อ Playlist",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(fontSize: 18, color: Colors.white),
          decoration: InputDecoration(hintText: "ชื่อ Playlist"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("ยกเลิก",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => playlists.add(controller.text));
                Navigator.pop(context);
              }
            },
            child: Text("บันทึก",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _editPlaylist(int index) {
    TextEditingController controller =
        TextEditingController(text: playlists[index]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1F1F39),
        title: Text(
          "แก้ไขชื่อ Playlist",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        content: TextField(
            controller: controller,
            style: TextStyle(fontSize: 18, color: Colors.white),
            decoration: InputDecoration(hintText: "ชื่อ Playlist")),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "ยกเลิก",
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => playlists[index] = controller.text);
                Navigator.pop(context);
              }
            },
            child: Text(
              "บันทึก",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
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
    return Scaffold(
      backgroundColor: Color(0xFF1F1F39),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("บันทึกเมนู",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: playlists.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ไม่มีรายการบันทึก',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    SizedBox(height: 8),
                    Text('คุณยังไม่ได้บันทึกรายการอาหาร',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
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
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            playlists[index],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          // หมุน 90 องศา
                          child: PopupMenuButton<String>(
                            color: Color(0xFF363636),
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
                                        color: Colors.white,
                                        size: 20), // ไอคอนแก้ไข
                                    SizedBox(
                                        width:
                                            8), // ระยะห่างระหว่างไอคอนกับข้อความ
                                    Text(
                                      "แก้ไขชื่อ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: "delete",
                                child: Row(
                                  children: [
                                    Icon(Icons.delete,
                                        color: Colors.white,
                                        size: 20), // ไอคอนลบ
                                    SizedBox(
                                        width:
                                            8), // ระยะห่างระหว่างไอคอนกับข้อความ
                                    Text(
                                      "ลบ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            icon: Icon(Icons.more_vert, color: Colors.black),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.list, color: Colors.white, size: 18),
                                SizedBox(width: 4),
                                Text("0",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ],
                            ),
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
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add, color: Colors.white, size: 36),
      ),
    );
  }
}
