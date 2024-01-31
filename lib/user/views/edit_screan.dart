import 'package:flutter/material.dart';
import 'package:untitled10/company/views/edit_profile_company.dart';
import 'package:untitled10/user/views/edit_skills.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../src/app_root.dart';
import 'edit_education_screan.dart';
import 'edit_experince_screan.dart';
import 'edit_projects.dart';

class EditScrean extends StatelessWidget {
  const EditScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Edit Profile'),
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

                navigateToScreen(context, EditProfileCompany());
              },
              title: Text('Edit information'),
              leading: Icon(
                Icons.person,
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
                navigateToScreen(context, EditEducationScrean());
              },
              title: Text('Edit education'),
              leading: Icon(
                Icons.school,
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
                navigateToScreen(context, EditExperinceScrean());
              },
              title: Text('Edit experience'),
              leading: Icon(
                Icons.work,
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
                navigateToScreen(context, EditSkills());
              },
              title: Text('Edit skills'),
              leading: Icon(
                Icons.star,
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
                navigateToScreen(context, EditProjects());
              },
              title: Text('Edit projects'),
              leading: Icon(
                Icons.workspaces_filled,
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


      ]
      )
      )
    );
  }
}
