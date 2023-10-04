import 'package:flutter/material.dart';
import 'package:todo_app/UI/screens/splash/splash_screen.dart';

import 'UI/screens/home/home_screen.dart';
import 'UI/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: HomeScreen.routeName,
    );
  }
}

