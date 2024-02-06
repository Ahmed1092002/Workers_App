import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/SharedWidget/custom_text_field.dart';
import 'package:untitled10/SharedWidget/working_feilds_dropdown_button_form_field.dart';
import 'package:untitled10/company/blocs/CompanyProfileCubit/company_profile_cubit.dart';
import 'package:untitled10/company/views/main_screan.dart';
import 'package:untitled10/user/views/main_screan.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../data/company/company_model.dart';
import '../../src/app_root.dart';
import '../../utils/consatants.dart';

class EditProfileCompany extends StatefulWidget {
  UserModel? user;
   EditProfileCompany({Key? key,this.user}) : super(key: key);

  @override
  State<EditProfileCompany> createState() => _EditProfileCompanyState();
}

class _EditProfileCompanyState extends State<EditProfileCompany> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

TextEditingController countryController = TextEditingController();

TextEditingController workingFieldController = TextEditingController();

TextEditingController infoController = TextEditingController();

String?jobField;



@override
  void initState() {
    super.initState();

    if (widget.user!=null) {
      print ('${widget.user!.info}');
      nameController.text = widget.user!.name!;
      infoController.text = widget.user!.info!;
      phoneController.text = widget.user!.phone!;
      addressController.text = widget.user!.address!;
      countryController.text = widget.user!.country!;
      workingFieldController.text = widget.user!.workingField!;
      jobField = widget.user!.jobField!;
    }
}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => CompanyProfileCubit()..getProfileData(

  ),
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
          child: LoadingAnimationWidget.twoRotatingArc(
            color: greenColor,
            size: 50,

          ),
        ),

      );
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
          child: CachedNetworkImage(
            imageUrl: cubit.user!.image!,
            placeholder: (context, url) => LoadingAnimationWidget.twoRotatingArc(
              color: greenColor,
              size: 100,

            ),
            imageBuilder: (context, imageProvider) => CircleAvatar(
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
            errorWidget: (context, url, error) => Icon(Icons.error),
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



  ],
),

              CustomTextField(
                controller: infoController,
                hint: 'Info',
                icon: Icons.info,

              ),




              getDropDownButtonFormField(
                hint:  countryController.text,
                icon: Ionicons.flag,
                context: context,
                job: country,
                Function: (value) {
                  countryController.text = value;
                },
              ),         getDropDownButtonFormField(
                hint:  workingFieldController.text,
                icon: Ionicons.bag,
                context: context,
                job:WorkingFeilds,
                Function: (value) {
                  workingFieldController.text = value;
                },
              ),
if (cubit.user!.userType=='users')
              getDropDownButtonFormField(
               hint:jobField,
                icon: Icons.work,
                context: context,
                job: Jobs,
                Function: (value) {
                  jobField = value;
                },
              ),



              if (state is uploadProfileImageLoadingState || state is UpdateProfileDataLoadingState)
                LinearProgressIndicator(
                  color: greenColor,
                  minHeight: 10,
                ),
              CustomButton(
                buttonName: 'Save',
                onPressed: () async {
                  print('${infoController.text}');
                  String info = infoController.text;
                  print ('${info}');
                  if (cubit.user!.userType=='company')
                    {
                      if (cubit.profileImage==null
                      ) {
                        await cubit.updateProfileData(
                          image: cubit.user!.image!,
                          info: infoController.text,
                          name: nameController.text,
                          phone: phoneController.text,
                          address: addressController.text,
                          country: countryController.text,
                          jobField: jobField!,
                          workingField: workingFieldController.text,
                        ).whenComplete(() => navigateToScreenAndExit(context, CompanyMainScrean()));
                      }
                      else {


                        await cubit.uploadProfileImage().whenComplete(() => Future.delayed(Duration(seconds: 6)).whenComplete(() async =>


                            cubit.updateProfileData(

                              image: cubit.profileImageLink!.isNotEmpty?cubit.profileImageLink:cubit.user!.image!,

                              name: nameController.text,
                              info: infoController.text,
                              jobField: jobField!,
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
                        info: info,
                        name: nameController.text,
                        phone: phoneController.text,
                        jobField: jobField!,
                        address: addressController.text,
                        country: countryController.text,
                        workingField: workingFieldController.text,
                      ).whenComplete(() => navigateToScreenAndExit(context, MainScrean()));
                    }
                    else {


                      await cubit.uploadProfileImage().whenComplete(() => Future.delayed(Duration(seconds: 6)).whenComplete(() async =>


                          cubit.updateProfileData(

                            image: cubit.profileImageLink!.isNotEmpty?cubit.profileImageLink:cubit.user!.image!,
                            jobField: jobField!,
                            name: info,
                            info: infoController.text,

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
