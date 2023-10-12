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
        hintText:hintText,
      ),
    );
  }
}
