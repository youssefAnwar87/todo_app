import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String? hintText;
   MyTextField({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText:hintText,
      ),
    );
  }
}
