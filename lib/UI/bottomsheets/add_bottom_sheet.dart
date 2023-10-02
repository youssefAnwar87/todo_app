import 'package:flutter/material.dart';
import 'package:todo_app/UI/utils/app_colors.dart';
import 'package:todo_app/UI/utils/app_theme.dart';
import 'package:todo_app/UI/widgets/my_text_field.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height* .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Text("Add your task",textAlign: TextAlign.center,style: AppTheme.bottomSheetTitleTextStyle,),
          SizedBox(height: 16,),
          MyTextField(hintText: "Enter your task"),
          SizedBox(height: 8,),
          MyTextField(hintText: "Enter task description"),
          SizedBox(height: 16,),
          Text("Select Date",textAlign: TextAlign.start,style:AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.w600) ,),
           Text("27/9/2023",textAlign: TextAlign.center,style:AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.w600,color: AppColors.grey)),
          Spacer(),
          ElevatedButton(onPressed: (){}, child: Text("Add")
          )
        ],
      ),
    );
  }
}
