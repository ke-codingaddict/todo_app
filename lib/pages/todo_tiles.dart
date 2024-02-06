// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTiles extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;

  Function(bool?)? onChanged;
  Function(BuildContext) deleteFunction;

  ToDoTiles({
    super.key,
    required this.taskName,
    required this.onChanged,
    required this.taskCompleted,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [
        SlidableAction(
          onPressed: deleteFunction,
          icon: Icons.delete,
          backgroundColor: Colors.red.shade400,
          borderRadius: BorderRadius.circular(15),
        )
      ]),
      child: Container(
        child: Center(
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Text(
                taskName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        margin: EdgeInsets.only(
          top: 25,
          right: 25,
          left: 25,
        ),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
    );
  }
}
