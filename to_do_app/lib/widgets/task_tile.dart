import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  bool?   isChecked;
  String taskTitle;
  ValueChanged<bool?> checkboxCallback;
  Function longPressCallback;

  TaskTile(
      { required this.isChecked,
        required this.taskTitle,
        required this.checkboxCallback,
        required this.longPressCallback});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool? checked=false;

  void isChecked(bool? v){
    setState((){
      checked = v;
      widget.isChecked = v;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.taskTitle,style: TextStyle(decoration: widget.isChecked! ? TextDecoration.lineThrough : null ),),
      trailing: CheckBoxx(isChecked:  checked, changeState: isChecked,),

    );
  }
}




class CheckBoxx extends StatelessWidget {


  CheckBoxx({required this.isChecked, required this.changeState});
  bool? isChecked = false;
  ValueChanged<bool?> changeState;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      activeColor: Colors.lightBlue,
      onChanged: changeState,
    );
  }
}
