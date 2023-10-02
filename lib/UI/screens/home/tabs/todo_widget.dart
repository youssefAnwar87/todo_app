import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/UI/utils/app_colors.dart';
import 'package:todo_app/UI/utils/app_theme.dart';

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      margin: EdgeInsets.symmetric(horizontal:22 ,vertical: 30),

      child: Slidable(
        startActionPane:ActionPane(
          extentRatio: 0.3,
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_){},
              backgroundColor: Colors.red,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: 'delete',
            ),
          ],
        ) ,
        child: Container(
          padding:EdgeInsets.symmetric(horizontal:24 ,vertical: 16),
          height: MediaQuery.of(context).size.height*0.13,

          child: Row(
            children: [
              VerticalDivider(),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Play Basket ball",style: AppTheme.taskTitleTextStyle,),
                    Text("Description",style: AppTheme.taskDiscriptionTextStyle,),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10)
                ),
                  padding: EdgeInsets.symmetric(vertical: 6,horizontal: 20),
                  child: Icon(Icons.check,color: AppColors.white,)),
            ],
          ),
        ),
      ),
    );
  }
}
