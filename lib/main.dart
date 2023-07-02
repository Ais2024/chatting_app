// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:chatting_app/firebase_options.dart';
import 'package:chatting_app/pages/Login.dart';
import 'package:chatting_app/pages/chat.dart';
import 'package:chatting_app/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const chattingApp());
}

class chattingApp extends StatelessWidget {
  const chattingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {

        "chat" : (context) => chat(),
        "REgister": (context)=>REgister(),
      },
      home: Login(),
    );

  }
}