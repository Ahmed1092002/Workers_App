import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:untitled10/company/views/main_screan.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/main.dart';
import 'package:untitled10/user/views/main_screan.dart';
import 'package:untitled10/utils/navigator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserModel? user ;
  String userTypeVar = '';

  var Token;
  var box = Hive.box(boxName);

  final storage = new FlutterSecureStorage();

  static LoginCubit get(context) => BlocProvider.of(context);

  Future login({required String email, required String password,BuildContext? context}) async {

    emit(LoginLoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      await getUserData(Token: userCredential.user!.uid,context: context);
      await storage.write(key: 'uid', value: userCredential.user!.uid);
      Token = await storage.read(key: 'uid');
      emit(LoginSuccessState());
    } catch (error) {
      emit(LoginErrorState());
    }
  }
  getUserData({required String Token,BuildContext? context} ) async {

    await FirebaseFirestore.instance.collection('users').doc(Token).get().then((value) {
      user = UserModel.fromJson(value.data()!);
      print (user!.fcmToken);
      box.put('name', user!.name);
      box.put('image', user!.image);
      box.put('email', user!.email);
      box.put('phone', user!.phone);
      box.put('address', user!.address);
      box.put('uid', user!.id);
      box.put('country', user!.country);
      box.put('date', user!.date);
       box.put( 'userType', user!.userType);
      if (user!.userType == 'users') {
        navigateToScreenAndExit(context!, MainScrean());
      } else if (user!.userType == 'company') {
        navigateToScreenAndExit(context!, CompanyMainScrean());
      }

      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  Future signInWithGoogle({BuildContext? context}) async {
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
     await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
       await getUserData(Token: value.user!.uid,context: context);
       await storage.write(key: 'uid', value: value.user!.uid);
       Token = await storage.read(key: 'uid');
     });
  }


    }

