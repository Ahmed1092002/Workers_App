import 'package:flutter/material.dart';
import 'package:untitled10/SharedViews/create_profie_screan.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/SharedWidget/logo_image.dart';
import 'package:untitled10/utils/navigator.dart';

class SelectTypeScrean extends StatelessWidget {
  String? nameController;
  String? emailController ;
  TextEditingController? passwordController = TextEditingController();
  String?phoneNumber;
  String?image;
  String?id;
   SelectTypeScrean({Key? key,this.nameController,this.emailController,this.passwordController,this.phoneNumber,this.image,this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFF8F8F8),
        child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LogoImage(),
            Text('What are you looking for?',style: Theme.of(context).textTheme.bodyMedium,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                InkWell(
                  onTap: (){
                    navigateToScreenAndExit(context, CreateProfieScrean(
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,

                      id:id,

                      userType: 'users',
                    ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    height: MediaQuery.of(context).size.height/8,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Icon(Icons.work,color: greenColor),
                        Text('I want a job',style: Theme.of(context).textTheme.bodyMedium,),
                      ],
                    ),
                  ),
                ),


                InkWell(
                  onTap: (){
                    navigateToScreenAndExit(context, CreateProfieScrean(
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      id:id,
                      userType: 'company',
                    ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    height: MediaQuery.of(context).size.height/8,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Icon(Icons.person,color: greenColor),
                        Text('I want an employee',style: Theme.of(context).textTheme.bodyMedium,),
                      ],
                    ),
                  ),
                ),
              ],
            ),


          ],

        ),


      ),
    );
  }
}
