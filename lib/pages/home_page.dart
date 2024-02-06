// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:practise_tutorial/data/database.dart';
import 'package:practise_tutorial/pages/alert_dialogue.dart';
import 'package:practise_tutorial/pages/todo_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('myBox');

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(
      () {
        db.toDoList[index][1] = !db.toDoList[index][1];
      },
    );
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
      db.updateDatabase();
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TO DO APP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: createNewTask,
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.deepPurple[200],
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTiles(
            taskName: db.toDoList[index][0],
            onChanged: (value) => checkBoxChanged(value, index),
            taskCompleted: db.toDoList[index][1],
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
