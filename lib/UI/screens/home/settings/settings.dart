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

    String selectedLanguage = "en"; // Initialize with the default language
    String selectedMode = "dark"; // Initialize with the default mode

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
            color: Colors.white,
            child: DropdownButton<String>(
              padding: EdgeInsets.all(5),
              isExpanded: true,
              value: selectedLanguage,
              items: [
                DropdownMenuItem<String>(
                  value: "en",
                  child: Text("English"),
                ),
                DropdownMenuItem<String>(
                  value: "ar",
                  child: Text("Arabic"),
                ),
              ],
              onChanged: (selectedValue) {
                setState(() {
                  selectedLanguage = selectedValue!;
                  provider.changeCurrentLocale(selectedLanguage);
                  print(selectedLanguage);
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
            color:  AppColors.white,
            child: DropdownButton<String>(
              padding: EdgeInsets.all(5),
              isExpanded: true,
              value: selectedMode,
              items: [
                DropdownMenuItem<String>(
                  value: "dark",
                  child: Text("Dark"),
                ),
                DropdownMenuItem<String>(
                  value: "light",
                  child: Text("Light"),
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
