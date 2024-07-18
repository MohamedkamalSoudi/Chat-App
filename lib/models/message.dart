import 'package:chat_app_1/constants.dart';

class Message {
  final String message;

  Message(this.message);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage]);
  }
}
