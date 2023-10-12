import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/utils/app_colors.dart';
import 'package:todo_app/UI/utils/app_theme.dart';
import 'package:todo_app/UI/widgets/my_text_field.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:todo_app/models/todo_dm.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/listprovider/list_provider.dart';


class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      padding: EdgeInsets.all(8),
      height: MediaQuery
          .of(context)
          .size
          .height * .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Add your task", textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,),
          SizedBox(height: 16,),
          MyTextField(hintText: "Enter your task", controller: titleController),
          SizedBox(height: 8,),
          MyTextField(hintText: "Enter task description",
              controller: descriptionController),
          SizedBox(height: 16,),
          Text("Select Date", textAlign: TextAlign.start,
            style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                fontWeight: FontWeight.w600),),
          InkWell(onTap: () {
            showMyDatePicker();
          },
              child: Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate
                      .year}", textAlign: TextAlign.center,
                  style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.grey))),
          Spacer(),
          ElevatedButton(onPressed: () {
            addToFireStore();
          }, child: Text("Add")
          )
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))) ?? selectedDate;
    setState(() {});
  }

  void addToFireStore() async {
    CollectionReference todosCollectionRef =
    AppUser.collection().doc(AppUser.currenuser!.id).collection(TodoDm.collecctionName);
    // FirebaseFirestore.instance.collection(TodoDm.collecctionName);

    DocumentReference newEmptyDoc = todosCollectionRef.doc();
    await newEmptyDoc.set({

      "id": newEmptyDoc.id,
      "title": titleController.text,
      "description": descriptionController.text,
      "date": selectedDate,
      "isDone": false,

    });
        // .timeout(Duration(milliseconds: 300), onTimeout: () {
      provider.refreshTodoList();
      Navigator.pop(context);
    // });
  }

}