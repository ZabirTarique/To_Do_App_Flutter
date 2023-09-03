import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/task_tag_model.dart';
import '../utils/colors.dart';
import '../widgets/delete_task_dialog.dart';
import '../widgets/update_task_dialog.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  final List<String> taskTags = ['Work', 'School', 'Other'];
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        //itemCount: monthModel.length,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return _buildPlayerModelList(taskTags[index]);
        },
      ),
    );
  }

  Widget _buildPlayerModelList(String? items) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('tasks').where('taskTag', isEqualTo: items,).get().asStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('');
          } else {
            return Card(
              child: ExpansionTile(
                title: Text(
                  items!,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[ ListView(
                  // itemCount: pmList!.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    Color taskColor = AppColors.blueShadeColor;
                    var taskTag = data['taskTag'];
                    if (taskTag == 'Work') {
                      taskColor = AppColors.salmonColor;
                    } else if (taskTag == 'School') {
                      taskColor = AppColors.greenShadeColor;
                    }
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadowColor,
                            blurRadius: 5.0,
                            offset: Offset(0, 5), // shadow direction: bottom right
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 20,
                          height: 20,
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundColor: taskColor,
                          ),
                        ),
                        title: Text(data['taskName']),
                        subtitle: Text(data['taskDesc']),
                        isThreeLine: true,
                        trailing: PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 'edit',
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(fontSize: 13.0),
                                ),
                                onTap: () {
                                  String taskId = (data['id']);
                                  String taskName = (data['taskName']);
                                  String taskDesc = (data['taskDesc']);
                                  String taskTag = (data['taskTag']);
                                  Future.delayed(
                                    const Duration(seconds: 0),
                                        () => showDialog(
                                      context: context,
                                      builder: (context) => UpdateTaskAlertDialog(taskId: taskId, taskName: taskName, taskDesc: taskDesc, taskTag: taskTag,),
                                    ),
                                  );
                                },
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(fontSize: 13.0),
                                ),
                                onTap: (){
                                  String taskId = (data['id']);
                                  String taskName = (data['taskName']);
                                  Future.delayed(
                                    const Duration(seconds: 0),
                                        () => showDialog(
                                      context: context,
                                      builder: (context) => DeleteTaskDialog(taskId: taskId, taskName:taskName),
                                    ),
                                  );
                                },
                              ),
                            ];
                          },
                        ),
                        dense: true,
                      ),
                    );
                  }).toList(),
                )],
              ),
            );
          }
        },
      ),
    );
  }
}
