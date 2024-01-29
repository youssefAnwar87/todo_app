import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/listprovider/list_provider.dart';
import 'package:todo_app/UI/screens/home/tabs/todo_widget.dart';
import 'package:todo_app/UI/settingsProvider/settings_provider.dart';
import 'package:todo_app/UI/utils/app_colors.dart';
import 'package:todo_app/models/todo_dm.dart';


class ListTab extends StatefulWidget{
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
late ListProvider provider;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.refreshTodoList();
    });
  }
  @override

  Widget build(BuildContext context) {
    provider = Provider.of(context);
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);

    // if (provider.todos.isEmpty){
    // }
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.17,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(flex : 3,child: Container(color: settingProvider.isDark() ? AppColors.primaryDark : AppColors.primary,)),
                  Expanded(flex : 7 ,child:Container(color: settingProvider.isDark() ? AppColors.accentDark : AppColors.accent,) )
                ],
              ),
              CalendarTimeline(
                monthHieght: MediaQuery.of(context).size.height*0.04,
                dayHieght: MediaQuery.of(context).size.height*0.13,
                locale: settingProvider.currentLocale,
                initialDate: provider.selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateSelected: (date) {
                  provider.selectedDate = date;
                  provider.refreshTodoList();
                },
                leftMargin: 20,
                monthColor: AppColors.white,
                dayColor: AppColors.primary,
                activeDayColor: AppColors.primary,
                activeBackgroundDayColor: AppColors.white,
                dotsColor: AppColors.transparent,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
             itemCount: provider.todos.length,
              itemBuilder: (context,index) =>
                 ToDoWidget(model: provider.todos[index],index: index,),
          ),
        ),
      ],
    );
  }


}
