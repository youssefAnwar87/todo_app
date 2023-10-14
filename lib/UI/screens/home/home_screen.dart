import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/bottomsheets/add_bottom_sheet.dart';
import 'package:todo_app/UI/listprovider/list_provider.dart';
import 'package:todo_app/UI/screens/home/settings/settings.dart';
import 'package:todo_app/UI/screens/home/tabs/tab_list.dart';
import 'package:todo_app/UI/screens/login/login.dart';
import 'package:todo_app/UI/settingsProvider/settings_provider.dart';
import 'package:todo_app/UI/utils/app_colors.dart';
import 'package:todo_app/UI/utils/app_theme.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
static  const String  routeName ="home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ListProvider provider;
  late SettingProvider sprovider;
  int currentSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {

        provider = Provider.of(context);
     sprovider = Provider.of(context);
    return Scaffold(
       // backgroundColor: sprovider.isDark() ?  AppColors.accentDark :AppColors.accent ,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todo_list),
        actions: [
          InkWell(
      onTap: (){
        AppUser.currenuser = null;
        provider.todos.clear();
        Navigator.pushReplacementNamed(context, Login.routeName);
    },
      child: Icon(Icons.logout)),
        ],
        toolbarHeight: MediaQuery.of(context).size.height*0.10,
      ),
      body: currentSelectedIndex == 0 ? ListTab() : SettingsTab(),
      bottomNavigationBar: buildBotoomNav(context),
      floatingActionButton:  buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

Widget  buildBotoomNav(BuildContext context) => BottomAppBar(
  shape: CircularNotchedRectangle(),
  clipBehavior: Clip.hardEdge,
  notchMargin: 8,
  child:   Theme(
    data: Theme.of(context).copyWith(canvasColor: sprovider.isDark() ?  Color(0xff141922) : AppColors.white  ),

    child: BottomNavigationBar(

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
  ),
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
