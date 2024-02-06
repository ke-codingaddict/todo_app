import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  final _mybox = Hive.box('myBox');

  void createInitialData() {
    toDoList = [
      ['Make Tutorial', false],
      ['Join Udemy Friday Class', false],
    ];
  }
//Load Database

  void loadData() {
    toDoList = _mybox.get("TODOLIST");
  }

//Update Database
  void updateDatabase() {
    _mybox.put("TODOLIST", toDoList);
  }
}
