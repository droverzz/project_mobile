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

  void _addTask() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('เพิ่มแผนของฉัน'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'พิมพ์สิ่งที่ต้องทำ'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ยกเลิก'),
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
              child: Text('เพิ่ม'),
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                color: Colors.black54,
                child: ListTile(
                  title: Text(task, style: TextStyle(color: Colors.white)),
                  leading: Checkbox(
                    value: false,
                    onChanged: (_) => _toggleTask(index),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 16),
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
                color: Colors.black54,
                child: ListTile(
                  title: Text(task,
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough)),
                  leading: Icon(Icons.check_circle, color: Colors.blue),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeCompletedTask(index),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
