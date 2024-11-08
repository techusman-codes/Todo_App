// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/data_base.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // to refrensce the box

  final _myBox = Hive.box('myBox');

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // this is the firts time ever oepnung the app then create a Defaut data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // there is already exist Data
      db.loadData();
    }
    super.initState();
  }

  // Text Editing Controller
  final _controller = TextEditingController();
  // list of all Todo Task

  // List toDoList = [
  //
  // ];

  // lets create our Method for checkBox

  void checkedBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // Save New Task

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // delete Task

  void deleteTask(int index) {
    setState(() {
      db.toDoList.remove(index);
    });
    db.updateDataBase();
  }

  // TO CREATE A NEW TASK
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Center(child: Text("To Do")),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkedBoxChanged(value, index),
              deleteFunction: (context) => deleteTask,
            );
          }),
    );
  }
}
