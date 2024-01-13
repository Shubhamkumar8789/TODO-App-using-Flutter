

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/util/Database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();


  }
  class _HomePageState extends State<HomePage>{
  // referenc the hive box
    final _myBox=  Hive.box('myBox');

    ToDoDataBase db=ToDoDataBase();
    @override
    void initState(){
      // if this is the first time ever opening the app then create default data
     if(_myBox.get("TODOLIST")==null){
       db.createInitialData();
     } else{
       // there a already exists data
       db.loadData();
     }

      super.initState();
    }

  // text controller
    final _controller=TextEditingController();


  // list of todo tasks

    // checkbox tapped method creted
    void checkBoxChanged(bool? value , int index){
setState(() {
  db.toDoList[index][1]= !db.toDoList[index][1];

  });
db.updateDataBase();
}
// save a new task
    void saveNewTask(){
      setState(() {
        db.toDoList.add([_controller.text,false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
      db.updateDataBase();
    }

// create A NEW TASK
void createNewTask() {
  showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: ()=>Navigator.of(context).pop(),
        );
      }
  );
}
// delete task
    void deleteTask(int index){
      setState(() {
        db.toDoList.removeAt(index);
      });
      db.updateDataBase();
    }
    @override
    Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text('TO DO '),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
            child: Icon(Icons.add),
        ),
        body: ListView.builder(
itemCount: db.toDoList.length,
          itemBuilder:(context ,index){
  return ToDoTile(taskName: db.toDoList[index][0],
      taskCompleted: db.toDoList[index][1],
      onChanged: (value)=> checkBoxChanged( value ,  index),
     deleteFunction:(context)=>deleteTask(index),
  );
          },
        ),
      );
  }
}

