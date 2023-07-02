// ignore_for_file: non_constant_identifier_names, camel_case_types, must_be_immutable, prefer_const_constructors

import 'package:chatting_app/customs/chatt_message.dart';
import 'package:chatting_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chat extends StatelessWidget {
  chat({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("created At", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(
                snapshot.data!.docs[i].data() as Map<String, dynamic>?));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/chat.png",
                    height: 50,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "chatting......",
                    style: TextStyle(fontSize: 30, color: Colors.blue),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email? ChatBuble(
                          message: messagesList[index],
                        ) : ChatBubleForFriend(message: messagesList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        "message": data,
                        "created At": DateTime.now(),
                        "id": email
                      });
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                        hintText: "write message",
                        suffixIcon: Icon(
                          Icons.send_outlined,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                )
              ],
            ),
          );
        } else {
          return Text("");
        }
      },
    );
  }
}
