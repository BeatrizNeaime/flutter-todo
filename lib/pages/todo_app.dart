import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/data/database.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final _box = Hive.box('box');
  TodoDatabase todoDatabase = TodoDatabase();
  final _controller = TextEditingController();

  @override
  void initState() {
    if (_box.get('TODOLIST') == null) {
      todoDatabase.createInitialData();
      todoDatabase.updateData();
    } else {
      todoDatabase.loadData();
    }
    super.initState();
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      todoDatabase.todoList[index]['isDone'] =
          !todoDatabase.todoList[index]['isDone'];
      todoDatabase.todoList.sort(
          (a, b) => a['isDone'].toString().compareTo(b['isDone'].toString()));
      todoDatabase.updateData();
    });
  }

  void deleteTask(int index) {
    setState(() {
      todoDatabase.todoList.removeAt(index);
    });
  }

  void saveNewTask() {
    setState(() {
      todoDatabase.addData(_controller.text);
      _controller.clear();
      Navigator.pop(context);
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Center(
            child: Text(
              "To Do",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.blueGrey,
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 10.0),
          itemCount: todoDatabase.todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              title: todoDatabase.todoList[index]['title'],
              completed: todoDatabase.todoList[index]['isDone'],
              onChanged: (value) => checkboxChanged(value, index),
              onDeleted: (context) => deleteTask(index),
            );
          },
        ));
  }
}
