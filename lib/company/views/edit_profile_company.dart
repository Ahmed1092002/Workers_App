import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/SharedWidget/custom_text_field.dart';
import 'package:untitled10/company/blocs/CompanyProfileCubit/company_profile_cubit.dart';
import 'package:untitled10/company/views/main_screan.dart';
import 'package:untitled10/user/views/main_screan.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../src/app_root.dart';

class EditProfileCompany extends StatelessWidget {
   EditProfileCompany({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController workingFieldController = TextEditingController();
TextEditingController infoController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => CompanyProfileCubit()..getProfileData(),
  child: BlocConsumer<CompanyProfileCubit, CompanyProfileState>(
  listener: (context, state) {
if (state is UpdateProfileDataSuccessState) {
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
content: Text('Profile Updated Successfully'),
backgroundColor: greenColor,
));
if (state is UpdateProfileDataErrorState) {
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
content: Text('Error Updating Profile'),
backgroundColor: Colors.red,
));

}

}
  },
  builder: (context, state) {
    var cubit = CompanyProfileCubit.get(context);
    if (cubit.user==null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),

      );
    }
    if (cubit.user!=null) {
      nameController.text = cubit.user!.name!;
      infoController.text = cubit.user!.info!;
      phoneController.text = cubit.user!.phone!;
      addressController.text = cubit.user!.address!;
      countryController.text = cubit.user!.country!;

      workingFieldController.text = cubit.user!.workingField!;
    }
    return Scaffold(
      appBar: AppBar(

        backgroundColor: backgroundColor,
        title: Text('Edit Profile'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: greenColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

        iconTheme: IconThemeData(
          color: greenColor, //
          // change your color here
        ),
      ),
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
          Container(
          decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: greenColor,
            width: 2,
          )
          ),
          child: CircleAvatar(
            radius: 50,

            backgroundImage: cubit.profileImage==null?CachedNetworkImageProvider(cubit.user!.image!):FileImage(cubit.profileImage!) as ImageProvider,
            child: Stack(

              children: [
                Positioned(
                  top: 80,
                  left: MediaQuery.of(context).size.width/10,
                  child: ElevatedButton(onPressed: (){
                    cubit.pickProfileImage();
                  }, child: Icon(Icons.edit,color: backgroundColor,),

                      style: ElevatedButton.styleFrom(

                        backgroundColor: greenColor,
                        shape:  CircleBorder(),
                      )),),


              ],

            ),


          ),
          width: 130,
          height: 130,
        ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: nameController,
                      hint: 'Name',
                      icon: Icons.person,
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: phoneController,
                      hint: 'Phone',
                      icon: Icons.phone,
                    ),
                  ),
                ],
              ),


Row(
  children: [
    Expanded(
      child: CustomTextField(
        controller: addressController,
        hint: 'Address',
        icon: Icons.location_on,
      ),
    ),
    Expanded(
      child: CustomTextField(
        controller: countryController,
        hint: 'Country',
        icon: Icons.flag,
      ),
    ),
  ],
),
              CustomTextField(
                controller: infoController,
                hint: 'Info',
                icon: Icons.info,
              ),

              // CustomTextField(
              //   controller: addressController,
              //   hint: 'Address',
              //   icon: Icons.location_on,
              // ),
              // CustomTextField(
              //   controller: countryController,
              //   hint: 'Country',
              //   icon: Icons.flag,
              // ),
              CustomTextField(
                controller: workingFieldController,
                hint: 'Working Field',
                icon: Icons.work,
              ),


              if (state is uploadProfileImageLoadingState || state is UpdateProfileDataLoadingState)
                LinearProgressIndicator(
                  color: greenColor,
                  minHeight: 10,
                ),
              CustomButton(
                buttonName: 'Save',
                onPressed: () async {
                  if (cubit.user!.userType=='company')
                    {
                      if (cubit.profileImage==null
                      ) {
                        await cubit.updateProfileData(
                          image: cubit.user!.image!,
                          info: cubit.user!.info!,
                          name: nameController.text,
                          phone: phoneController.text,
                          address: addressController.text,
                          country: countryController.text,
                          workingField: workingFieldController.text,
                        ).whenComplete(() => navigateToScreenAndExit(context, CompanyMainScrean()));
                      }
                      else {


                        await cubit.uploadProfileImage().whenComplete(() => Future.delayed(Duration(seconds: 6)).whenComplete(() async =>


                            cubit.updateProfileData(

                              image: cubit.profileImageLink!.isNotEmpty?cubit.profileImageLink:cubit.user!.image!,

                              name: nameController.text,
                              info: cubit.user!.info!,

                              phone: phoneController.text,
                              address: addressController.text,
                              country: countryController.text,
                              workingField: workingFieldController.text,
                            ).whenComplete(() => navigateToScreenAndExit(context, CompanyMainScrean())),
                        ));


                      }
                    }
                  if (cubit.user!.userType=='users'){
                    if (cubit.profileImage==null
                    ) {
                      await cubit.updateProfileData(
                        image: cubit.user!.image!,
                        info: cubit.user!.info!,
                        name: nameController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                        country: countryController.text,
                        workingField: workingFieldController.text,
                      ).whenComplete(() => navigateToScreenAndExit(context, MainScrean()));
                    }
                    else {


                      await cubit.uploadProfileImage().whenComplete(() => Future.delayed(Duration(seconds: 6)).whenComplete(() async =>


                          cubit.updateProfileData(

                            image: cubit.profileImageLink!.isNotEmpty?cubit.profileImageLink:cubit.user!.image!,

                            name: nameController.text,
                            info: cubit.user!.info!,

                            phone: phoneController.text,
                            address: addressController.text,
                            country: countryController.text,
                            workingField: workingFieldController.text,
                          ).whenComplete(() => navigateToScreenAndExit(context, MainScrean())),
                      ));


                    }
                  }




                },
              )



            ],


          ) ,
        ),
      ),


    );
  },
),
);
  }
}
