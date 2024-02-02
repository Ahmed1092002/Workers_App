import 'package:flutter/material.dart';
import 'package:untitled10/SharedViews/spalsh_screan.dart';
import 'package:untitled10/SharedViews/splash.dart';
import 'package:untitled10/user/views/complete_profile_user.dart';
import 'package:untitled10/user/views/main_screan.dart';

import '../utils/themes.dart';
Color backgroundColor =  Color(0xFFF8F8F8);
Color greenColor =  Color(0xFF4C846E);
Color grayColor =  Color(0xFF3A3A3A);


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: SecondClass(),
    );
  }
}
