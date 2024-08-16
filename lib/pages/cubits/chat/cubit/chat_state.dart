part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

class ChatInitial extends ChatState {}

class ChatsSuccess extends ChatState {
  List<Message> messages;
  ChatsSuccess({required this.messages});
}
