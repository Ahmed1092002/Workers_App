import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/bloc_opserver.dart';
import 'package:untitled10/utils/dio_helper.dart';
import 'firebase_options.dart';
String boxName = 'user';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
var token = await FirebaseMessaging.instance.getToken();


  print(token);

  await Hive.initFlutter();
  await Hive.openBox(boxName);
  var box = Hive.box(boxName);
  DioHelper.init();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,

  );
  var initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

if (box.get('uid')!=null) {
  FirebaseFirestore.instance.collection('users').doc(box.get('uid')).update(
      {'fcmToken': token});
}
  FirebaseMessaging.instance.onTokenRefresh
      .listen((fcmToken) {
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  })
      .onError((err) {
    // Error getting token.
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;


    if (message.notification != null && android != null) {
      print('Message also contained a notification: ${message.notification}');

    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (message.notification != null && android != null) {
      print('Message also contained a notification: ${message.notification}');
      showNotification(notification!.title, notification.body);

    }
  });


  runApp(  MyApp());
}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  print("Handling a background message: ${message.messageId}");
  if (message.notification != null && android != null) {
    print('Message also contained a notification: ${message.notification}');
    showNotification(notification!.title, notification.body);

  }
}
void showNotification(String? title, String? body) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID', 'channel_name', channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,

      playSound: true,
      visibility: NotificationVisibility.public,

      showWhen: true,);
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,  );
  await flutterLocalNotificationsPlugin.show(
      0, title, body, platformChannelSpecifics,
      payload: 'Default_Sound');
}