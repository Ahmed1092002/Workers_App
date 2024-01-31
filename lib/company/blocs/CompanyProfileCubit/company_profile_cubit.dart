import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'company_profile_state.dart';

class CompanyProfileCubit extends Cubit<CompanyProfileState> {
  CompanyProfileCubit() : super(CompanyProfileInitial());
  static CompanyProfileCubit get(context) => BlocProvider.of(context);
  var box = Hive.box(boxName);
  var storage =FlutterSecureStorage();
  UserModel? user;
  String? profileImageLink = '';
  var imagePicker = ImagePicker();
  File? profileImage;

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


  getProfileData()async{
    String? uid = await storage.read(key: 'uid');
    String userType = await box.get('userType').toString();
    emit(GetProfileDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {

      user = UserModel.fromJson(value.data()!);
//       box.put('name', user!.name);
//       box.put('image', user!.image);
//       box.put('email', user!.email);
//       box.put('phone', user!.phone);
// box.put('address', user!.address);
//       box.put('uid', user!.uid);
//       box.put('country', user!.country);

//       box.put('date', user!.date);





      emit(GetProfileDataSuccessState());
      emit(CompanyProfileInitial());
    }).catchError((error) {
      emit(GetProfileDataErrorState());
    });
    }
  Future updateProfileData({
    required String name,
    required String info,
    required String phone,
    required String address,
    required String country,
    required String workingField,

     String? image,
  }
      )async{
    String? uid = await storage.read(key: 'uid');
    String userType = await box.get('userType').toString();
    emit(UpdateProfileDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
      'name': name,
      'info': info,
      'phone': phone,
      'address': address,
      'country': country,
      'workingField': workingField,
      'image': image,
    }).then((value)  async {
      await box.put( 'name', name);
      await box.put( 'image', image);
      emit(UpdateProfileDataSuccessState());
    }).catchError((error) {
      emit(UpdateProfileDataErrorState());
    });
  }


}
