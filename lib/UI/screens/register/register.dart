import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/UI/screens/home/home_screen.dart';
import 'package:todo_app/UI/utils/dialog_utils.dart';
import 'package:todo_app/models/app_user.dart';

class Register extends StatefulWidget {
  static String routeName = "Register";


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email ="";
  String password ="";
  String userName ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        title: Text("Register"),
        toolbarHeight: MediaQuery.of(context).size.height*0.1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                    label: Text("User name")
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                onChanged: (text){
                  email = text;
                },
                decoration: InputDecoration(
                    label: Text("Email")
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                onChanged: (text){
                  password = text;

                },
                decoration: InputDecoration(
                    label: Text("password")
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
                      Text("Create account",style: TextStyle(fontSize: 18),),
                      Spacer(),
                      Icon(Icons.arrow_forward),
                    ],
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reqisterUser() async{
    try{
      showLoading(context);
      UserCredential credential = await FirebaseAuth.instance.
      createUserWithEmailAndPassword
        (email: email, password: password);
      AppUser newUser = AppUser(id: credential.user!.uid, email: email, userName: userName);
      await registerUserInFirestore(newUser);
      AppUser.currenuser = newUser;

      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }on FirebaseAuthException catch(error){
      hideLoading(context);
    showErrorDialog(context, error.message ??
        "Something went Wrong. please try again later! "
    );
    }

  }

  Future registerUserInFirestore(AppUser user) async {
    CollectionReference<AppUser> userCollection  = AppUser.collection();
    await userCollection.doc(user.id).set(user);
    // userCollection.add(user);
  }

}
