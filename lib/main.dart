import 'package:flutter/material.dart';
import 'package:todo_app/UI/screens/splash/splash_screen.dart';

import 'UI/screens/home/home_screen.dart';
import 'UI/utils/app_theme.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      routes: {
        SplashScreen.routeName :(_)=> SplashScreen(),
        HomeScreen.routeName :(_)=> HomeScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}

