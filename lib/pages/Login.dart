// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously, prefer_const_literals_to_create_immutables, file_names



import 'package:chatting_app/customs/cusstom_button.dart';
import 'package:chatting_app/customs/cusstom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset("assets/img/chat.png"),
                      Text(
                        "chat with others",
                        style: TextStyle(
                            fontSize: 35,
                            fontStyle: FontStyle.italic,
                            color: Colors.cyan),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "SIGN IN",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      custemTextFormfield(
                          onChanged: (data) {
                            email = data;
                          },
                          hintText: "Email"),
                      SizedBox(
                        height: 25,
                      ),
                      custemTextFormfield(
                          onChanged: (data) {
                            password = data;
                          },
                          hintText: "password"),
                      SizedBox(
                        height: 25,
                      ),
                      customButton(
                        title: 'Log In',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: email!, password: password!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("welcome 😍 ")));
                              Navigator.pushNamed(context, "chat" ,arguments: email );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                        Text("the email is not found")));
                              } else if (e.code == 'wrong-password') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                        Text("the password is wrong")));
                              }
                            }
                            isLoading = false;
                            setState(() {});
                          } else {}
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "dont have an account?",
                            style: TextStyle(fontSize: 20),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "REgister");
                              },
                              child: Text(
                                "{Sign Up}",
                                style: TextStyle(fontSize: 20),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
