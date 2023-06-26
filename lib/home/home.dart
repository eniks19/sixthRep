import 'package:doto/util/dialogue_box.dart';
import 'package:doto/util/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _controller = TextEditingController();
  List toDOList = [
    ['Make Tutorial', false],
    ['Do Exercise', false],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDOList[index][1] = !toDOList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      toDOList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDOList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text(
            'TO DO',
          ),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: toDOList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: toDOList[index][0],
                taskCompleted: toDOList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask,
              );
            }));
  }
}
