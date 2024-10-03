import 'package:hive/hive.dart';

class TodoDatabase {
  final box = Hive.box('box');
  List todoList = [];

  void createInitialData() {
    todoList = [
      {
        'title': 'Brush teeth',
        'isDone': false,
      },
    ];
  }

  void loadData() {
    todoList = box.get('TODOLIST');
  }

  void updateData() {
    box.put('TODOLIST', todoList);
  }

  void deleteData(int index) {
    todoList.removeAt(index);
    updateData();
  }

  void addData(String title) {
    todoList.add({
      'title': title,
      'isDone': false,
    });
    updateData();
  }
}
