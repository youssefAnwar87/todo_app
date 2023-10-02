import 'package:flutter/material.dart';
import 'package:todo_app/UI/bottomsheets/add_bottom_sheet.dart';
import 'package:todo_app/UI/screens/home/settings/settings.dart';
import 'package:todo_app/UI/screens/home/tabs/tab_list.dart';

class HomeScreen extends StatefulWidget {
static  const String  routeName ="home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
        toolbarHeight: MediaQuery.of(context).size.height*0.10,
      ),
      body: currentSelectedIndex == 0 ? ListTab() : SettingsTab(),
      bottomNavigationBar: buildBotoomNav(),
      floatingActionButton:  buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

Widget  buildBotoomNav() => BottomAppBar(
  shape: CircularNotchedRectangle(),
  clipBehavior: Clip.hardEdge,
  notchMargin: 8,
  child:   BottomNavigationBar(
    onTap: (index){
      currentSelectedIndex = index;
      setState(() {

      });
    },
      currentIndex: currentSelectedIndex,
      items : [
    BottomNavigationBarItem(icon: Icon(Icons.menu),label:"" ),

    BottomNavigationBarItem(icon: Icon(Icons.settings),label:"" ),

  ]),
);

  Widget buildFab() => FloatingActionButton(onPressed: (){
    showModalBottomSheet(context: context,
        isScrollControlled: true ,
        builder: (_)=>Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddBottomSheet(),
        ));
  },
  child: Icon(Icons.add),
  );
}
