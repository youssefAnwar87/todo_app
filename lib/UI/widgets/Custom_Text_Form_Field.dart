import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/settingsProvider/settings_provider.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType keyboradType;
  String? Function(String?) validator;
  bool isPassword;
  bool isDark;
  CustomTextFormField({
    required this.label,this.keyboradType = TextInputType.text,
    required this.controller,required this.validator,
    this.isPassword = false,
    required this.isDark
  });

  @override
  Widget build(BuildContext context) {
     SettingProvider provider = Provider.of(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        // controller: controller,
        decoration: InputDecoration(
            label:Text(label,style: TextStyle(color:  provider.isDark() ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColor)),
            errorStyle: TextStyle(fontSize: 18),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    width: 3,
                    color: Theme.of(context).primaryColor
                )
            ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  width: 3,
                  color: Colors.red
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  width: 3,
                  color: Colors.red
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  width: 3,
                  color: Theme.of(context).primaryColor
              )
          ),
        ),
        keyboardType: keyboradType ,
        controller: controller,
        validator: validator,
        obscureText : isPassword,
      ),
    );
  }
}
