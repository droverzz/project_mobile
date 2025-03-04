import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import '../widgets/add_task_dialog.dart';
import '../widgets/edit_task_dialog.dart';
import '../widgets/confirm_delete_dialog.dart';


class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> tasks = [];
  List<String> completedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  /// ดึง path ของไฟล์ JSON ที่ใช้เก็บข้อมูล
  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/todo_data.json';
  }

  /// บันทึกข้อมูลลงไฟล์ JSON
  Future<void> _saveTasks() async {
    final file = File(await _getFilePath());
    final data = {'tasks': tasks, 'completedTasks': completedTasks};
    await file.writeAsString(jsonEncode(data));
  }

  /// โหลดข้อมูลจากไฟล์ JSON
  Future<void> _loadTasks() async {
    try {
      final file = File(await _getFilePath());
      if (!await file.exists()) return;

      final data = jsonDecode(await file.readAsString());
      setState(() {
        tasks = List<String>.from(data['tasks']);
        completedTasks = List<String>.from(data['completedTasks']);
      });
    } catch (e) {
      print('Error loading tasks: $e');
    }
  }

  /// เพิ่มข้อมูลวัตถุดิบ จาก widget หน้า add_task_dialog
  void _addTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialog(
          onTaskAdded: (newTask) {
            setState(() => tasks.add(newTask));
            _saveTasks();
          },
        );
      },
    );
  }

  /// เปลี่ยนสถานะเป็น Done
  void _toggleTask(int index) {
    setState(() {
      completedTasks.add(tasks[index]);
      tasks.removeAt(index);
      _saveTasks();
    });
  }

  /// เปลี่ยนสถานะกลับ
  void _toggleCompletedTask(int index) {
    setState(() {
      tasks.add(completedTasks[index]);
      completedTasks.removeAt(index);
      _saveTasks();
    });
  }

  /// แก้ไขข้อมูล ดึง widgets หน้า edit_task_dialog มาใช้
  void _editTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return EditTaskDialog(
          currentTask: tasks[index],
          onTaskUpdated: (updatedTask) {
            setState(() {
              tasks[index] = updatedTask;
            });
            _saveTasks();
          },
        );
      },
    );
  }

  /// ฟังก์ชันสำหรับแสดง Dialog ยืนยันการลบ
  void _confirmDeleteTask({required int index, required bool isCompleted}) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmDeleteDialog(
          taskName: isCompleted ? completedTasks[index] : tasks[index],
          onConfirm: () {
            if (isCompleted) {
              _removeCompletedTask(index);
            } else {
              _removeTask(index);
            }
          },
        );
      },
    );
  }

  /// ลบข้อมูลจาก task
  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
      _saveTasks();
    });
  }

  /// ลบข้อมูลจาก complete task
  void _removeCompletedTask(int index) {
    setState(() {
      completedTasks.removeAt(index);
      _saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text('แผนของฉัน', style: theme.textTheme.headlineSmall),
        centerTitle: false,
      ),
      body: tasks.isEmpty && completedTasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ยังไม่มีแผนการ', style: theme.textTheme.bodyLarge),
                  SizedBox(height: 8),
                  Text('คุณยังไม่เพิ่มแผนใดๆ ที่ต้องทำ',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey)),
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
                        style: theme.textTheme.titleMedium),
                    SizedBox(height: 8),
                    ...tasks.asMap().entries.map((entry) {
                      int index = entry.key;
                      String task = entry.value;
                      return Card(
                        color: theme.cardColor,
                        child: ListTile(
                          title: Text(task, style: theme.textTheme.bodyLarge),
                          leading: IconButton(
                            icon: Icon(Icons.radio_button_unchecked,
                                color: theme.iconTheme.color),
                            onPressed: () => _toggleTask(index),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editTask(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDeleteTask(
                                    index: index, isCompleted: false),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                  SizedBox(height: 16),
                  if (completedTasks.isNotEmpty) ...[
                    Text('สำเร็จ (${completedTasks.length})',
                        style: theme.textTheme.titleMedium),
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
                            onPressed: () => _confirmDeleteTask(
                                index: index, isCompleted: true),
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
