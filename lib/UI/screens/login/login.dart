import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/UI/screens/home/home_screen.dart';
import 'package:todo_app/UI/screens/register/register.dart';
import 'package:todo_app/UI/utils/app_colors.dart';
import 'package:todo_app/UI/utils/dialog_utils.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Login extends StatefulWidget {
  static String routeName = "login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email ="";
  String password ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:  AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.login),
        toolbarHeight: MediaQuery.of(context).size.height*0.1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              Padding(
                child: Text(AppLocalizations.of(context)!.welcome,style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),textAlign: TextAlign.start,) ,
                  padding: EdgeInsets.all(8)),
              TextFormField(
                onChanged: (text){
                  email = text;
                  },
                decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.email)
                ),
              ),
              SizedBox(height: 4,),
              TextFormField(
                onChanged: (text){
                  password = text;
                  },
                decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.password)
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(onPressed: (){
                  login();
                },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                    child: Text(AppLocalizations.of(context)!.login),
                  ),
                style: ButtonStyle(

                ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Register.routeName);
                },
                child: Text(
                  AppLocalizations.of(context)!.create_account,
                  style: TextStyle(fontSize: 18,color: Colors.black45),
                  textAlign: TextAlign.center,
                ),
                
              )
            ],
          ),
        ),
      ),
    );
  }
  void login() async{
    try{
      showLoading(context);
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword
        (email: email, password: password);
      AppUser currentUser = await getUserFromFireStore(credential.user! .uid);
      AppUser.currenuser = currentUser;
      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }on FirebaseAuthException catch(error){
      hideLoading(context);
      showErrorDialog(context, error.message ??
          "Something went Wrong. please try again later! "
      );
    }

  }


  Future<AppUser> getUserFromFireStore(String id) async {
    CollectionReference<AppUser> userCollextion = AppUser.collection();
    DocumentSnapshot<AppUser> docSnap =await userCollextion.doc(id).get();
    return docSnap.data()!;
  }
}
