import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/settingsProvider/settings_provider.dart';
import 'package:todo_app/UI/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    SettingProvider provider = Provider.of<SettingProvider>(context);

    String selectedLanguage = provider.currentLocale;; // Initialize with the default language
    String selectedMode = provider.currentMode == ThemeMode.light ? "light" : "dark";

    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.language, style: TextStyle(
            color: provider.isDark() ?   AppColors.white : AppColors.black,
              fontSize: 18, fontWeight: FontWeight.bold
          )),
          SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(
              color: provider.isDark() ?  Color(0xff141922) :Colors.white,

              border: Border.all(
                  width: 2,
                  color: provider.isDark() ? Color(0xff5b98e6) :Color(0xff5d9beb)
              ),
            ),

            child: DropdownButton<String>(
              padding: EdgeInsets.all(5),
              isExpanded: true,
              value: selectedLanguage,
              items: [
                DropdownMenuItem<String>(
                  value: "en",
                  child: Text("English",
                    style: TextStyle(
                        color: provider.isDark() ? Color(0xff5b98e6) : Color(0xff5d9beb)
                    ),),
                ),
                DropdownMenuItem<String>(
                  value: "ar",
                  child: Text("العربيه",
                      style: TextStyle(
                          color: provider.isDark() ? Color(0xff5b98e6) : Color(0xff5d9beb)
                      )
                  ),
                ),
              ],
              onChanged: (selectedValue) {
                setState(() {
                  selectedLanguage = selectedValue!;
                  provider.changeCurrentLocale(selectedLanguage);
                  print(provider.currentLocale);


                });
              },
            ),
          ),
          SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.mode, style: TextStyle(
              color: provider.isDark() ?   AppColors.white : AppColors.black,

              fontSize: 18, fontWeight: FontWeight.bold
          )),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: provider.isDark() ?  Color(0xff141922) :Colors.white,

              border: Border.all(
                  width: 2,
                  color: provider.isDark() ? Color(0xff5b98e6) :Color(0xff5d9beb)
              ),
            ),

            child: DropdownButton<String>(
              padding: EdgeInsets.all(5),
              isExpanded: true,
              value: selectedMode,
              items: [
                DropdownMenuItem<String>(
                  value: "dark",
                  child: Text(AppLocalizations.of(context)!.dark,
                    style: TextStyle(
                        color: provider.isDark() ? Color(0xff5b98e6) :Color(0xff5d9beb)
                  ),),
                ),
                DropdownMenuItem<String>(
                  value: "light",
                  child: Text(AppLocalizations.of(context)!.light,
                      style: TextStyle(
                          color: provider.isDark() ? Color(0xff5b98e6) :Color(0xff5d9beb)
                      )
                  ),
                ),
              ],
              onChanged: (selectedValue) {
                setState(() {
                  selectedMode = selectedValue!;
                  ThemeMode mode = (selectedMode == "dark") ?  ThemeMode.dark: ThemeMode.light;
                  provider.changeCurrentMode(mode);
                  print(selectedMode);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
