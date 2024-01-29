import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/screens/home/home_screen.dart';
import 'package:todo_app/UI/screens/login/login.dart';
import 'package:todo_app/UI/screens/register/register.dart';
import 'package:todo_app/UI/settingsProvider/settings_provider.dart';
import 'package:todo_app/UI/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  static  const String routeName ="splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, Login.routeName);

    });
  }
  @override
  Widget build(BuildContext context) {
    SettingProvider sprovider = Provider.of(context);

    return Scaffold(
      body: sprovider.isDark() ? Image.asset(AppAssets.Darksplash) : Image.asset(AppAssets.splash),
    );
  }
}
