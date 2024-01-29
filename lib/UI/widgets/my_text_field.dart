import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String? hintText;
  TextEditingController controller;
   MyTextField({required this.hintText,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 3,
                color: Theme.of(context).primaryColor
            )
        ),

        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 3,
                color: Theme.of(context).primaryColor
            )
        ),

        hintText:hintText,
      ),
    );
  }
}
