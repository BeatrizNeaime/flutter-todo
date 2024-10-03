import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  const ToDoTile({
    super.key,
    required this.title,
    required this.completed,
    required this.onChanged,
    required this.onDeleted,
  });

  final String title;
  final bool completed;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDeleted,
              icon: Icons.delete,
              backgroundColor: Colors.red[400]!,
              borderRadius: BorderRadius.circular(12),
              autoClose: true,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: completed ? Colors.blueGrey[400] : Colors.blueGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: completed,
                onChanged: onChanged,
                activeColor: Colors.white,
                checkColor: Colors.blueGrey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: completed ? Colors.white70 : Colors.white,
                    decoration: completed ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
