import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // refrence box

  final _myBox = Hive.box('my name');
  // run this method if this is the first time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial ", false],
      ["Do Exercise", false],
    ];
  }

  // to load the Data from the Data base

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  // update the Data from the DataBase

  void updateDataBase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
