
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:to_do_app/widgets/task_list.dart';

import 'add_task.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int totalTask = 12;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTask(
                      context: context,
                    ),
                  )
                );
              },
            );
          },
        ),
        backgroundColor: Colors.lightBlue,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 60.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40.0,
                child: Icon(
                  Icons.list,
                  color: Colors.lightBlue,
                  size: 40.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'ToDo',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                '${totalTask.toString()} tasks remaining',
                style: const TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        topEnd: Radius.circular(20))),
                child: const TaskList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
