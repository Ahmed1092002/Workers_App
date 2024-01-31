part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class SendMessageSuccessState extends ChatState {}

class SendMessageErrorState extends ChatState {}

class SendMessageLoadingState extends ChatState {}
class GetMessagesSuccessState extends ChatState {}
class GetMessagesErrorState extends ChatState {}
class GetMessagesLoadingState extends ChatState {}
class GetChatSuccessState extends ChatState {}
class GetChatErrorState extends ChatState {}
class GetChatLoadingState extends ChatState {}
