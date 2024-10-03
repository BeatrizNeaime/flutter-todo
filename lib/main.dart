import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/pages/todo_app.dart';
import 'package:todo_app/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        routes: {
          '/': (context) => const SplashScreen(),
          '/todo': (context) => const ToDoApp(),
        });
  }
}
