import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:untitled10/data/ChatModel.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:untitled10/utils/dio_helper.dart';

import '../../main.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  List<String> messages = [];
  var box = Hive.box(boxName);

  final storage = new FlutterSecureStorage();

  sendMessage({
    required String message,
    required String receiverId,
    required String receiverName,
    required String fcmTokenDevice,

     required String time,


})async {
    String? uid = await storage.read(key: 'uid');
    String ?name = await box.get('name').toString();
    ChatModel chatModel = ChatModel(
      message: message,
      receiverId: receiverId,
      receiverName: receiverName,
      senderId: uid!,
      senderName: name,
      time: time,
    );
    emit(SendMessageLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(receiverId)
        .set({
      'receiverId': receiverId,
      'receiverName': receiverName,
      'senderId': uid,
      'senderName': name,
    }).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(receiverId)
        .set({
      'receiverId': receiverId,
      'receiverName': receiverName,
      'senderId': uid,
      'senderName': name,
    }).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
// receiver
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uid)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      fcmToken(
        body: message,
        title: name,
        fcmTokenDevice:fcmTokenDevice,
        text: message,

      );
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uid)
        .set({
      'receiverId': uid,
      'receiverName': name,
      'senderId': receiverId,
      'senderName': receiverName,
    }).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

  }
  List<ChatModel>Masseges = [];

  getMessages({
    required String receiverId,
    })async {
    emit(GetMessagesLoadingState());
    String? uid = await storage.read(key: 'uid');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('time',descending: true)
        .snapshots()
        .listen((event) {
      Masseges = [];
      for (var element in event.docs) {
        Masseges.add(ChatModel.fromMap(element.data(),element.id));
      }
      emit(GetMessagesSuccessState());
    });
  }
  List<UserModel>? userModel;

  getChats()async{
    String? uid = await storage.read(key: 'uid');
    List <String>chatsUserId = [];
    userModel = [];
    emit(GetChatLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .get()
        .then((value) {
      print(value.docs.length);
      value.docs.forEach((element) {
        chatsUserId.add(element.id);
        print(element.id);
      });
      print(chatsUserId);
      emit(GetChatSuccessState());
    }).catchError((error) {
      print('Error retrieving documents: $error');
      emit(GetChatErrorState());
    });

    for (var element in chatsUserId) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(element)
      .get().then((value) {
        print (value.data());
        userModel!.add(UserModel.fromJson( value.data()!));


        emit(GetChatSuccessState());


      }).catchError((error) {
        emit(GetChatErrorState());
      });
    }


  }
  fcmToken({
    String ?fcmTokenDevice,
    String ?title,
    String ?body,
    String ?text,


})async{
    DioHelper.postData(
      url: 'fcm/send',
       data: {
         "to":"$fcmTokenDevice",

         "notification": {
           "title": title,
           "text": text,
           "body": body,
           "sound": "default",

           "color": "#990000"
         },
         "priority": "high",
         "data": {
           "click_action": "FLUTTER_NOTIFICATION_CLICK",
           "type": "COMMENT"
         }

       }
    ).then((value) => print(value.data)).catchError((error) {
      print(error.toString());
    });
  }

}
