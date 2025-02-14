import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> tasks = [];
  List<String> completedTasks = [];

  /// หน้าต่างเพิ่มรายการวัตถุดิบ
  void _addTask() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1F1F39),
          title: Text(
            'เพิ่มวัตถุดิบของฉัน',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          content: TextField(
            controller: controller,
            style: TextStyle(fontSize: 18, color: Colors.white),
            decoration: InputDecoration(hintText: 'พิมพ์ชื่อวัตถุดิบ'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ยกเลิก',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    tasks.add(controller.text);
                  });
                }
                Navigator.pop(context);
              },
              child: Text(
                'เพิ่ม',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleTask(int index) {
    setState(() {
      completedTasks.add(tasks[index]);
      tasks.removeAt(index);
    });
  }

  void _toggleCompletedTask(int index) {
    setState(() {
      tasks.add(completedTasks[index]);
      completedTasks.removeAt(index);
    });
  }

  void _removeCompletedTask(int index) {
    setState(() {
      completedTasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F39),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'แผนของฉัน',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: tasks.isEmpty && completedTasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ยังไม่มีแผนการ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'คุณยังไม่เพิ่มแผนใดๆ ที่ต้องทำ',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tasks.isNotEmpty) ...[
                    Text('ต้องทำ (${tasks.length})',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    SizedBox(height: 8),
                    ...tasks.asMap().entries.map((entry) {
                      int index = entry.key;
                      String task = entry.value;
                      return Card(
                        color: Color(0xFF2F2F4F),
                        child: ListTile(
                          title:
                              Text(task, style: TextStyle(color: Colors.white)),
                          leading: IconButton(
                            icon: Icon(Icons.radio_button_unchecked,
                                color: Colors.white),
                            onPressed: () => _toggleTask(index),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                  SizedBox(height: 16),
                  if (completedTasks.isNotEmpty) ...[
                    Text('สำเร็จ (${completedTasks.length})',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    SizedBox(height: 8),
                    ...completedTasks.asMap().entries.map((entry) {
                      int index = entry.key;
                      String task = entry.value;
                      return Card(
                        color: Color(0xFF2F2F4F),
                        child: ListTile(
                          title: Text(
                            task,
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 2,
                            ),
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.check_circle,
                                color: Color(0xFF3D5CFF)),
                            onPressed: () => _toggleCompletedTask(index),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeCompletedTask(index),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        shape: CircleBorder(),
        elevation: 10,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add, color: Colors.white, size: 36),
      ),
    );
  }
}
