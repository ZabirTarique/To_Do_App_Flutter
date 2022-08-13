import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTask extends StatelessWidget {

  // const AddTask({required this.context});

  final BuildContext context;

  const AddTask({Key? key, required this.context}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController? textEditingController;
    String task;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold,fontSize: 30.0),),
            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              controller: textEditingController,
              onChanged: (value){
                if (kDebugMode) {
                  print(value);
                }
                task = value;
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Task',
              ),
            ),

            MaterialButton(
              color: Colors.lightBlueAccent,
              onPressed: () {

                // Provider.of<TaskData>(context).addTask(newTaskTitle);
                // Navigator.pop(context);
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
