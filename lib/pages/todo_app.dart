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

  bool flow = true;

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

  void orderTasks() {
    if (flow) {
      todoDatabase.todoList.sort(
          (a, b) => a['title'].toString().compareTo(b['title'].toString()));
    } else {
      todoDatabase.todoList.sort(
          (a, b) => b['title'].toString().compareTo(a['title'].toString()));
    }
    setState(() {
      flow = !flow;
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
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.blueGrey,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Tasks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: orderTasks,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white54),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.sort_by_alpha_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
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
            ),
          ),
        ],
      ),
    );
  }
}
