import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/listprovider/list_provider.dart';
import 'package:todo_app/UI/screens/editScreen/edit_screen.dart';
import 'package:todo_app/UI/screens/login/login.dart';
import 'package:todo_app/UI/screens/splash/splash_screen.dart';
import 'package:todo_app/UI/settingsProvider/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'UI/screens/home/home_screen.dart';
import 'UI/screens/register/register.dart';
import 'UI/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instance.settings = Settings(cacheSizeBytes:  Settings.CACHE_SIZE_UNLIMITED);
    // await FirebaseFirestore.instance.disableNetwork();
  } catch (error) {
    print("Firebase initialization error: $error");
  }
  runApp
    (MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) =>   ListProvider()),
      ChangeNotifierProvider(create: (context) =>   SettingProvider()..loadSavedSettings()),
      ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SettingProvider provider = Provider.of<SettingProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(provider.currentLocale),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode:  provider.currentMode,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      routes: {
        SplashScreen.routeName :(_)=> SplashScreen(),
        HomeScreen.routeName :(_)=> HomeScreen(),
        Login.routeName :(_)=> Login(),
        Register.routeName :(_)=> Register(),
        EditScreen.routeName : (_)=> EditScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}

