import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:untitled10/data/ChatModel.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:untitled10/utils/dio_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:geolocator/geolocator.dart';
import '../../main.dart';
import 'package:url_launcher/url_launcher.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  List<String> messages = [];
  var box = Hive.box(boxName);

  final storage = new FlutterSecureStorage();
  UserModel? user;
  String? profileImageLink = '';
  var imagePicker = ImagePicker();
  File? profileImage;
  List<File> images = [];
  List<String> imagesLink = [];

  Future<void> pickMultipleMediaImage() async {
    final List<XFile> medias = await imagePicker.pickMultipleMedia();
    if (medias.isNotEmpty) {
      for (var element in medias) {
        images.add(File(element.path));

      }
      // profileImage = File(pickedFile.path);

      emit(ProfileImagePickedSuccessState());

    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  Future<void> pickCameraImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));


      emit(ProfileImagePickedSuccessState());

    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  Future<void> pickFilePdf() async {
// Picking a PDF file
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      File file = File(result.files.single.path!);
      images.add(file);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }

  }


  Future<List<String>>  uploadProfileImage() async {

    if (images.isNotEmpty) {
      emit(uploadProfileImageLoadingState());
      for (var element in images) {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child('users/${Uri.file(element.path).pathSegments.last}')
            .putFile(element)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            imagesLink.add(value);
            print(value);
          });
        })
            .catchError((error) {
          print(error);
        });
      }

      emit(uploadProfileImageSuccessState());
      return imagesLink;
    } else {
      print('No profile image selected.');
      emit(uploadProfileImageErrorState());
      return imagesLink;
    }




  }

  sendMessage({
    required String message,
    required String receiverId,
    required String receiverName,
    required String fcmTokenDevice,
    required List<String> imagesLink,


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
      images: imagesLink,
      time: time,
    );

    emit(SendMessageLoadingState());
    bool hasVideos = images.any((file) => file.path.endsWith('.mp4'));

    if (hasVideos) {
      for (var element in images) {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child('users/${Uri.file(element.path).pathSegments.last}')
            .putFile(element)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            imagesLink.add(value);
            print(value);
          });
        })
            .catchError((error) {
          print(error);
        });
      }

    }
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
    images = [];



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





  Future<Position> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Show a dialog or a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Show a dialog or a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.'),
        ),
      );
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }



String? location;
  // void launchMapsUrl(double lat, double lon) async {
  //   final location = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
  //   // Uri _url = Uri.parse(url);
  //   // if (!await launchUrl(_url)) {
  //   //   location = '$_url';
  //   //   print ('$_url');
  //   //   throw Exception('Could not launch $_url');
  //   //
  //   // }
  // }
  Future<String>  shareLocation( BuildContext context) async {
    try {
      Position position = await getCurrentLocation(context);
       location = 'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
      // launchMapsUrl(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    }
    return location!;
  }



}
// Google Store Mountain View
// 2000 N Shoreline Blvd, Mountain View, CA 94043, United States
// +1 650-253-0000
// https://maps.app.goo.gl/iVEVh34Yjt99Ltjj8