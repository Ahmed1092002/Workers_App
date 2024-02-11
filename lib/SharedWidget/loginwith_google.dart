import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../src/app_root.dart';

class LoginwithGoogle extends StatelessWidget {
  final String?buttonName;
    Function()? onPressed;
    LoginwithGoogle({
    super.key,
    this.buttonName,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        color: grayColor,
        height: 40,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Ionicons.logo_google, color: Colors.white,),
            SizedBox(width: 10,),
            Text(
              'Login with Google',
              style: TextStyle(fontSize: 14   , color: Colors.white),
            ),
          ],
        )
    );
  }
}