import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';
class DialogBox extends StatelessWidget{
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;



  DialogBox({super.key ,
    required this.controller,
  required this.onSave,
  required this.onCancel,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input 4
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new Task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save Button
                MyButton(text: "Save", onPressed: onSave),


                SizedBox(width: 10,),
                //cancel button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );

  }
}
