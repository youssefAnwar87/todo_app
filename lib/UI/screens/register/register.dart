import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/UI/screens/home/home_screen.dart';
import 'package:todo_app/UI/screens/login/login.dart';
import 'package:todo_app/UI/utils/app_assets.dart';
import 'package:todo_app/UI/utils/dialog_utils.dart';
import 'package:todo_app/UI/widgets/Custom_Text_Form_Field.dart';
import 'package:todo_app/UI/widgets/my_text_field.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Register extends StatefulWidget {
  static String routeName = "Register";


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email ="";
  String password ="";
  String userName ="";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmatioPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:  AppBar(
      //   elevation: 0,
      //   title: Text("Register"),
      //   toolbarHeight: MediaQuery.of(context).size.height*0.1,
      //   centerTitle: true,
      // ),
        body: Stack(
          children: [
            Image.asset(AppAssets.login,
                width: double.infinity,
                fit: BoxFit.fill
            ),
            Form(
              key:  formKey,
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.31,),
                  CustomTextFormField(
                      label: "User name", controller: nameController,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return "Please enter userName";
                        } else {
                          return null;
                        }
                      }),
                  CustomTextFormField(label: "Email",
                      keyboradType: TextInputType.emailAddress,
                      controller: emailController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return "Please enter email address";
                    }
                    bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if(!emailValid){
                      return "Please enter valid email";
                    }

                    return null;

                  },),
                  CustomTextFormField(label: "Password",
                      keyboradType: TextInputType.number,
                      controller: passwordController,
                      isPassword: true,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return "Please enter password";
                        }
                        if (text.length < 6) {
                          return "Password should be at least 6 chars";
                        }
                        return null;

                      }


                  ),
                  CustomTextFormField(label: "Confirmation Password",
                    keyboradType: TextInputType.number,
                    controller: confirmatioPasswordController,
                    isPassword: true,
                    validator:(text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return "Please enter confirmation password";
                      }
                      if (text != passwordController.text) {
                        return "Password does not match.";
                      }
                      return null;

                    } ,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      reqisterUser();
                    },
                        child: Text("Register",
                      style: Theme.of(context).textTheme.titleLarge,),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
                        ),
                      ),
                    ),
                  ),
                  TextButton(onPressed: (){
                    Navigator.of(context).pushNamed(Login.routeName);
                  },
                      child: Text("already have an account"))
                ],
              ),
            ))
          ],
        ),
      /* SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.15,),
              TextFormField(
                onChanged: (text){
                  userName = text;
                },
                decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.user_name)
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                onChanged: (text){
                  email = text;
                },
                decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.email)
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                onChanged: (text){
                  password = text;

                },
                decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.password)
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.16,),

              ElevatedButton(
                style: ButtonStyle(

                ),
                onPressed: (){
                  reqisterUser();
                },
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),

                child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.create_account,style: TextStyle(fontSize: 18),),
                      Spacer(),
                      Icon(Icons.arrow_forward),
                    ],
                  ),

                ),
              ),
            ],
          ),
        ),
      ), */
    );
  }

  void reqisterUser() async {
    if(formKey.currentState?.validate() == true){

      try {
      showLoading(context);
      UserCredential credential = await FirebaseAuth.instance.
      createUserWithEmailAndPassword
        (email: emailController.text, password: passwordController.text);
      AppUser newUser = AppUser(
          id: credential.user!.uid, email: emailController.text, userName: nameController.text);
      await registerUserInFirestore(newUser);
      AppUser.currenuser = newUser;

      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (error) {
      hideLoading(context);
      showErrorDialog(context, error.message ??
          "Something went Wrong. please try again later! "
      );
    }
  }
  }

  Future registerUserInFirestore(AppUser user) async {
    CollectionReference<AppUser> userCollection = AppUser.collection();
    await userCollection.doc(user.id).set(user);
    // userCollection.add(user);
  }

  void register() {
    if(formKey.currentState?.validate() == true){

    }
  }

}
