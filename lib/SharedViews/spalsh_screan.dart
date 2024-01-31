import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:untitled10/SharedViews/login_screan.dart';
import 'package:untitled10/company/views/main_screan.dart';
import 'package:untitled10/main.dart';
import 'package:untitled10/user/views/main_screan.dart';


class SpalshScrean extends StatefulWidget {
  const SpalshScrean({Key? key}) : super(key: key);

  @override
  _SpalshScreanState createState() => _SpalshScreanState();
}

class _SpalshScreanState extends State<SpalshScrean>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool _showContainer = false;
  final storage = new FlutterSecureStorage();

  var Token;
  var userTypes;

  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: const Duration(seconds: 2),

    );
    _controller!.forward().whenComplete(() async {
      setState(() {
        _showContainer = true;
      });
      Token = await storage.read(key: 'uid');
      userTypes = await Hive.box(boxName).get('userType');
      print ("user type $userTypes");
      print (Token);


      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),

          pageBuilder: (_, __, ___)  {


            if (Token != null  ) {
              if (userTypes == 'users') {
                return MainScrean();
              } else if (userTypes == 'company') {
                return CompanyMainScrean();
              } else if (userTypes == null) {
                return LoginScrean();
              }

            }
            return LoginScrean();

          },
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:AnimatedContainer(

curve: Curves.easeIn,

        duration: const Duration(milliseconds: 1000),

        width:  MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height ,
        decoration: const BoxDecoration(
          color: Color(0xFFF8F8F8),
          image: DecorationImage(
            image: AssetImage('assets/image/fec619ee9ff24fd5bc54331f798c95ea(1).png'),
            fit: BoxFit.fill,
          ),
        ),

      ),
    );
  }
}
