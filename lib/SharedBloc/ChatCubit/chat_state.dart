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
class ProfileImagePickedSuccessState extends ChatState {}
class ProfileImagePickedErrorState extends ChatState {}
class uploadProfileImageSuccessState extends ChatState {}
class uploadProfileImageErrorState extends ChatState {}
class uploadProfileImageLoadingState extends ChatState {}
class IsTypingSuccessState extends ChatState {}
class IsTypingErrorState extends ChatState {}
class IsWatchedSuccessState extends ChatState {}
class IsWatchedErrorState extends ChatState {}




