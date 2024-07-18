import 'package:chat_app_1/constants.dart';
import 'package:chat_app_1/models/message.dart';
import 'package:chat_app_1/pages/login_page.dart';
import 'package:chat_app_1/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: primaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 50,
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return ChatBuble(message: messagesList[index],);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add(
                        {
                          'message': data,
                        },
                      );
                      controller.clear();
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: Icon(
                        Icons.send,
                        color: primaryColor,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}
