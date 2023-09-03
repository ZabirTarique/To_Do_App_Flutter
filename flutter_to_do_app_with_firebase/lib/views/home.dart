import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../widgets/add_task_dialog.dart';
import 'tasks.dart';
import 'categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;
  DateTime? selectedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        backButton: false,
        onDateChanged: (value) {},
        firstDate: DateTime.now().subtract(const Duration(days: 140)),
        lastDate: DateTime.now(),
        accent: Colors.green,
      ),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text("To-Do List"),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(CupertinoIcons.calendar),
      //     ),
      //     // Expanded(
      //     //   // flex: 3,
      //     //   child: DateTimeFormField(
      //     //     initialDate: DateTime.now(),
      //     //     initialValue: DateTime.now(),
      //     //     mode: DateTimeFieldPickerMode.date,
      //     //     decoration: const InputDecoration(
      //     //       isDense: true,
      //     //       contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //     //       hintStyle: TextStyle(color: Colors.black45),
      //     //       errorStyle: TextStyle(color: Colors.redAccent),
      //     //       border: OutlineInputBorder(),
      //     //       suffixIcon: Icon(Icons.event_note),
      //     //     ),
      //     //     onDateSelected: (DateTime value) {
      //     //       selectedDate = value;
      //     //     },
      //     //   ),
      //     // ),
      //   ],
      // ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskAlertDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.brown,
            unselectedItemColor: Colors.black,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                pageController.jumpToPage(index);
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_list),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.tag),
                label: '',
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: const <Widget>[
          Center(
            child: Tasks(),
          ),
          Categories(),
        ],
      ),
    );
  }
}
