// ignore_for_file: must_be_immutable, camel_case_types, use_key_in_widget_constructors, prefer_const_constructors, body_might_complete_normally_nullable, file_names

import 'package:flutter/material.dart';

class custemTextFormfield extends StatelessWidget {
  custemTextFormfield({this.hintText, this.onChanged});

  String? hintText;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return "this field is  required";
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          border:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
    );
  }
}
