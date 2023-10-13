import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';


class SettingProvider extends ChangeNotifier{
  String currentLocale ="en";
  ThemeMode currentMode = ThemeMode.light;


  Future<void> saveDarkMode(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', isDarkMode);
  }

  Future<void> saveLanguage(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
  }
  Future<void> loadSavedSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool('darkMode');
    String? locale = prefs.getString('locale');

    if (isDarkMode != null) {
      currentMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    }

    if (locale != null) {
      currentLocale = locale;
    }

    notifyListeners();
  }
  changeCurrentLocale(String newLocale){
    currentLocale = newLocale;
    notifyListeners();
    saveLanguage(currentLocale);// Save language setting
  }
  changeCurrentMode(ThemeMode newMode){
    currentMode = newMode;
    notifyListeners();
    saveDarkMode(currentMode == ThemeMode.dark); // Save dark mode setting

  }
  bool isDark()=> currentMode == ThemeMode.dark;

}