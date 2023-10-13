import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/UI/screens/home/tabs/todo_widget.dart';
import 'package:todo_app/UI/utils/app_colors.dart';
import 'package:todo_app/UI/utils/app_theme.dart';
import 'package:todo_app/UI/utils/dialog_utils.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:todo_app/models/todo_dm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditScreen extends StatefulWidget {
  static  const String  routeName ="Edit";


  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  DateTime selectedDate = DateTime.now();
  String title ="";
  String details ="";

  @override
  Widget build(BuildContext context) {
    TodoDm todo = ModalRoute.of(context)!.settings.arguments as TodoDm;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todo_edit),

      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
      Column(
      children: [
      Expanded(flex : 1,child: Container(color: AppColors.primary,)),
      Expanded(flex : 9 ,child:Container(color: AppColors.accent,) )


      ],
      ),
          Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height*0.7,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.edit_task,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        onChanged: (text){
                          title = text;
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black), // Change the color to the desired color
                          ),
                          hintText:AppLocalizations.of(context)!.this_is_title,

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        onChanged: (text){
                          details = text;
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black), // Change the color to the desired color
                          ),

                          hintText: AppLocalizations.of(context)!.task_details,

                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                    AppLocalizations.of(context)!.select_time,

                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        showMyDatePicker();
                      },
                      child: Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                        textAlign: TextAlign.center,
                        style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                    Spacer(flex: 2,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 60.0)), // Adjust the height as needed
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5D9CEC)),
                        ),
                        child: InkWell (
                          onTap: () async{
                            todo.title = title;
                            todo.description = details;
                            todo.date = selectedDate;

                            // Get a reference to the Firestore document and update it
                            CollectionReference todosCollection =
                             AppUser.collection().doc(AppUser.currenuser!.id).collection(TodoDm.collecctionName);
                            try {
                              showLoading(context);
                              await todosCollection.doc(todo.id).set(todo.toJson());
                              hideLoading(context);
                              Navigator.pop(context);
                            } catch (e) {
                              print("Firestore update error: $e");
                              // Handle the error as needed
                            }

                            // await todosCollection.doc(todo.id).set(todo.toJson());
                            //
                            // // Navigate back to the previous screen
                            // Navigator.pop(context);
                          },
                            child: Text(AppLocalizations.of(context)!.save_changes,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18) ,)),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )

          ),
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
}
