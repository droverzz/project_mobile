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
    final theme = Theme.of(context);
    TextEditingController controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // ignore: deprecated_member_use
          backgroundColor: theme.dialogBackgroundColor,
          title: Text(
            'เพิ่มวัตถุดิบของฉัน',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: controller,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: 'พิมพ์ชื่อวัตถุดิบ',
              hintStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.white54),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ยกเลิก', style: theme.textTheme.bodyLarge),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() => tasks.add(controller.text));
                }
                Navigator.pop(context);
              },
              child: Text('เพิ่ม', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.transparent,
        elevation: 0,
        title: Text(
          'แผนของฉัน',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: tasks.isEmpty && completedTasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ยังไม่มีแผนการ', style: theme.textTheme.bodyLarge),
                  SizedBox(height: 8),
                  Text('คุณยังไม่เพิ่มแผนใดๆ ที่ต้องทำ', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tasks.isNotEmpty) ...[
                    Text('ต้องทำ (${tasks.length})', style: theme.textTheme.titleMedium),
                    SizedBox(height: 8),
                    ...tasks.asMap().entries.map((entry) {
                      int index = entry.key;
                      String task = entry.value;
                      return Card(
                        color: theme.cardColor,
                        child: ListTile(
                          title: Text(task, style: theme.textTheme.bodyLarge),
                          leading: IconButton(
                            icon: Icon(Icons.radio_button_unchecked, color: theme.iconTheme.color),
                            onPressed: () => _toggleTask(index),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                  SizedBox(height: 16),
                  if (completedTasks.isNotEmpty) ...[
                    Text('สำเร็จ (${completedTasks.length})', style: theme.textTheme.titleMedium),
                    SizedBox(height: 8),
                    ...completedTasks.asMap().entries.map((entry) {
                      int index = entry.key;
                      String task = entry.value;
                      return Card(
                        color: theme.cardColor,
                        child: ListTile(
                          title: Text(
                            task,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 2,
                            ),
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.check_circle, color: Colors.green),
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
        backgroundColor: theme.colorScheme.primary,
        child: Icon(Icons.add, color: Colors.white, size: 36),
      ),
    );
  }
}
