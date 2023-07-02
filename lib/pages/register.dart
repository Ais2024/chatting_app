// ignore_for_file: unused_local_variable, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables, file_names, use_build_context_synchronously


import 'package:chatting_app/customs/cusstom_button.dart';
import 'package:chatting_app/customs/cusstom_text.dart';
import 'package:chatting_app/pages/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class REgister extends StatefulWidget {
  REgister({Key? key}) : super(key: key);

  @override
  State<REgister> createState() => _REgisterState();
}

class _REgisterState extends State<REgister> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

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
                            "SIGN UP",
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
                          title: 'Sign Up',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: email!,
                                  password: password!,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "the account created succesfully 💌 ")));
                                Navigator.pushNamed(context, "chat");
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                          Text("the password is weak")));
                                } else if (e.code == 'email-already-in-use') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "this email is already used")));
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "you must put the email && the password ")));
                              }
                              isLoading = false;
                              setState(() {});
                            } else {}
                          }),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "if you have an account ",
                            style: TextStyle(fontSize: 20),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return Login();
                                    }));
                              },
                              child: Text(
                                "{Sign In}",
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
