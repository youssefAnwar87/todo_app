import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/UI/screens/home/tabs/todo_widget.dart';
import 'package:todo_app/UI/utils/app_colors.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.12,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(flex : 3,child: Container(color: AppColors.primary,)),
                  Expanded(flex : 7 ,child:Container(color: AppColors.accent,) )
                ],
              ),
              CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateSelected: (date) => print(date),
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
             itemCount: 10,
              itemBuilder: (context,index) =>ToDoWidget()
          ),
        ),
      ],
    );
  }
}
