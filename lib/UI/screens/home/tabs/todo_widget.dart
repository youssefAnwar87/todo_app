import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/listprovider/list_provider.dart';
import 'package:todo_app/UI/screens/editScreen/edit_screen.dart';
import 'package:todo_app/UI/settingsProvider/settings_provider.dart';
import 'package:todo_app/UI/utils/app_colors.dart';
import 'package:todo_app/UI/utils/app_theme.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:todo_app/models/todo_dm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ToDoWidget extends StatefulWidget {
  TodoDm model;
  final int index; // Add an index parameter

  ToDoWidget({required this.model, required this.index});

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
@override

  @override
  Widget build(BuildContext context) {

    ListProvider provider = Provider.of(context);
    SettingProvider sprovider = Provider.of(context);
    provider.refreshTodoList();
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context,EditScreen.routeName,    arguments: widget.model, // Pass the TodoDm object to EditScreen
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: sprovider.isDark()  ? Color(0xff141922)  : AppColors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        margin: EdgeInsets.symmetric(horizontal:22 ,vertical: 30),

        child: Slidable(
          startActionPane:ActionPane(
            extentRatio: 0.3,
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: ( _){
                  provider.removeTodo(widget.index);
                },
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
                VerticalDivider(
                    color: !widget.model.isDone ? Theme.of(context).primaryColor : Color(0xff61e657)                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.model.title,style: AppTheme.taskTitleTextStyle
                          .copyWith(color: !widget.model.isDone  ? Theme.of(context).primaryColor : Color(0xff61e657) ),),
                      Text(widget.model.description,style: AppTheme.taskDiscriptionTextStyle.copyWith(color: sprovider.isDark() ? Colors.white : Colors.black),),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.model.isDone  = !widget.model.isDone ;

                    CollectionReference todosCollection =
                    AppUser.collection().doc(AppUser.currenuser!.id).collection(TodoDm.collecctionName);
                    todosCollection.doc(widget.model.id).set(widget.model.toJson());

                    provider.refreshTodoList();
                     },
                  child: !widget.model.isDone
                      ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    child: Icon(Icons.check, color: AppColors.white),
                  )
                      : Text(
                   AppLocalizations.of(context)!.done ,
                    style: TextStyle(
                      color: Color(0xff61e657),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
