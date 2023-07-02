
// ignore_for_file: must_be_immutable, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  customButton({required this.onTap,required this.title});

  VoidCallback? onTap;

  String title ;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.blue,
            borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        height: 60,
        child: Center(child: Text(title)),

      ),
    );
  }
}

