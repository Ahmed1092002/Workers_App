import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/main.dart';


part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);


  var Token;

  String? profileImageLink = '';

  final storage = new FlutterSecureStorage();
  UserModel? user ;

  var imagePicker = ImagePicker();
  File? profileImage;
  var box= Hive.box(boxName );


  Future<void> pickProfileImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());

    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }


 Future  uploadProfileImage() async {
    if (profileImage != null) {
      emit(uploadProfileImageLoadingState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          profileImageLink = value;

          emit(uploadProfileImageSuccessState());
        });
      })
          .catchError((error) {
        print(error);
        emit(uploadProfileImageErrorState());
      });
      return profileImageLink;

    } else {
      print('No profile image selected.');
      emit(uploadProfileImageErrorState());
    }

  }

  Future  register({required String email,
    required String password,
    String ? userType,
    String? address,
    String? profileImageLink,
    String?info,
    String?jobField,
    String? country,
    String? phone,
    String? workingField,
    String? date,

    required String name}) async {



    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      emit(RegisterErrorState());
      return;
    }


    emit(RegisterLoadingState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async =>    {

    await  createNewUser(email: email,Info: info ,image: profileImageLink, name: name, uid: value.user!.uid, userType: userType, address: address,  country: country, phone: phone, workingField: workingField, date: date,jobField: jobField),
      await  storage.write(key: 'uid', value: value.user!.uid),
      await  box.put('userType', userType),
   await box.put('name', user!.name),
   await box.put('image', user!.image),
   await box.put('email', user!.email),
   await box.put('info', user!.info),
    await box.put('phone', user!.phone),
    await box.put('address', user!.address),
    await box.put('country', user!.country),
    await box.put('date', user!.date),
    await box.put('workingField', user!.workingField),
    await box.put('jobField', user!.jobField),




    }).catchError(

            (error) {
          print(error.toString());
          emit(RegisterErrorState());
        }
    );

  }
  String? gender;


  Future <UserCredential> signInWithGoogle({
     String? email,
     String? password,
    String ? userType,
    String? address,
    String? profileImageLink,
    String? Info,
    String? jobField,

    String? country,
    String? phone,
    String? workingField,
    String? date,

     String? name
}) async {
    emit(RegisterLoadingState());

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,

    );

    // Once signed in, return the UserCredential
     return await FirebaseAuth.instance.signInWithCredential(credential)
         .then((value) async {
       await  createNewUser(email: value.user!.email,
           image: value.user!.photoURL,
           name: value.user!.displayName,
           uid: value.user!.uid,
           userType: userType,
           address: address,
           country: country,
           jobField: jobField,
           Info: Info,
           phone: value.user!.phoneNumber,
           workingField: workingField, date: date);
       await  storage.write(key: 'uid', value: value.user!.uid);

       await box.put('name', value.user!.displayName);
       await box.put('image', value.user!.photoURL);
       await box.put('email', value.user!.email);
       return value;


     }).catchError((err) => {
     print(err.toString()),
         emit(RegisterErrorState()),
     });



  }

  changeGender({required String gender}) {
    print (gender.toString());
    this.gender = gender;
    print (this.gender.toString());

    emit(ChangeGenderState());



  }

  Future createNewUser(
      {String? email,
        String?jobField,


        String? name,
        String ? userType,
        String? address,
        String?Info,

        String? country,
        String? phone,
        String? workingField,
        String? date,
        String ? image,
        String? uid}

      ) async {
    var token = await FirebaseMessaging.instance.getToken();

    user = UserModel(
      email: email,
image: image,
      jobField: jobField,
      name: name,
      userType: userType,
      address: address,
      fcmToken: token,
      gender: gender,
      country: country,
      phone: phone,
      workingField: workingField,
      date: date,
      id: uid,
    );
    print (user!.toJson());
print (user!.toJson());
    emit(UserCreateLoadingState());
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set(user!.toJson());

      emit(UserCreateSuccessState());
    } catch (error) {
      emit(UserCreateErrorState());
    }
  }
  addSomeInfoSignInGoogle({
    String?phone,
    String?address,
    String?country,
    String?workingField,
    String?date,
    String?gender,
    String?jobField,
    String?info,
    String?image,
    String?uid,
    String?userType

  }) async{
    emit(UserCreateLoadingState());

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'phone':phone,
      'address':address,
      'country':country,
      'workingField':workingField,
      'date':date,
      'image':image,
      'gender':gender,
      'userType':userType,
      'jobField':jobField,
      'info':info,

    }).then((value) async {
      await  box.put('userType', userType);
      await box.put('image', image);
      await box.put('phone', phone);
      await box.put('address', address);
      await box.put('country', country);
      await box.put('workingField', workingField);
      await box.put('date', date);
      await box.put('gender', gender);
      await box.put('jobField', jobField);
      await  box.put('info', info);
      emit(UserCreateSuccessState());

    }).catchError((error) {

      emit(UserCreateErrorState());
    });



  }
}