import 'package:flutter/material.dart';

import '../../src/app_root.dart';
import 'edit_screan.dart';

class SettingsScrean extends StatelessWidget {
  const SettingsScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Settings'),
        titleTextStyle: TextStyle(
          color: greenColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: backgroundColor,
         iconTheme: IconThemeData(
          color: greenColor, //change your color here
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: backgroundColor,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditScrean()));
              },
 title: Text('Edit Profile'),
              leading: Icon(
                Icons.edit,
                color: greenColor,
              ),
            ),


            Divider(
              color: greenColor,
              thickness: 2,
              height: 2,
              endIndent: 20,
              indent: 20,
            ),
            ListTile(
              onTap: () {},
              title: Text('Change Password'),
              leading: Icon(
                Icons.lock,
                color: greenColor,
              ),
            ),
            Divider(
              color: greenColor,
              thickness: 2,
              height: 2,
              endIndent: 20,
              indent: 20,
            ),
            ListTile(
              onTap: () {

              },
              title: Text('Change Language'),
              leading: Icon(
                Icons.language,
                color: greenColor,
              ),
            ),

          ],
        ),
      ),

    );
  }
}
