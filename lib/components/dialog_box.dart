import 'package:flutter/material.dart';
import 'package:todo_app/components/button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: const Text(
        'Add a new task',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'OpenSans',
        ),
      ),
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter task',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(label: "Cancel", onPressed: onCancel),
                Button(label: "Add", onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
