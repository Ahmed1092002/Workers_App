import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            minimumSize: Size(350, 50),
            elevation: 5,
            backgroundColor: Color(0xFF333333),

            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Ionicons.logo_google, color: Colors.white,),
            SizedBox(width: 10,),
            Text(
              'Login with Google',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        )
    );
  }
}