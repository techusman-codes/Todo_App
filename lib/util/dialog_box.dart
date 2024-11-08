import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 150,
        child: Column(
          children: [
            // Get User Input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a New Task',
              ),
            ),

            // we are going to have two buttons a save button and a cancle button

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(
                  text: 'save',
                  onPressed: onSave,
                ),
                const SizedBox(
                  width: 8,
                ),
                // cancel button
                MyButton(
                  text: 'Cancel',
                  onPressed: onCancel,
                ),
              ],
            )
          ],

          // Save Button
        ),
      ),
    );
  }
}
