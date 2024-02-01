import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled10/SharedBloc/RegisterCubit/register_cubit.dart';
import 'package:untitled10/SharedWidget/select_date_item.dart';
import 'package:untitled10/company/views/main_screan.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/SharedWidget/custom_text_field.dart';
import 'package:untitled10/user/views/complete_profile_user.dart';
import 'package:untitled10/utils/navigator.dart';

import '../SharedWidget/working_feilds_dropdown_button_form_field.dart';

class CreateProfieScrean extends StatefulWidget {
  String? nameController ;
  String? emailController;
  TextEditingController? passwordController = TextEditingController();
  String ? userType;
  String?phoneNumber;
  String?image;
  String?id;
  CreateProfieScrean({Key? key,this.nameController,this.emailController,this.passwordController,this.userType,this.phoneNumber,this.image,this.id}) : super(key: key);


  @override
  State<CreateProfieScrean> createState() => _CreateProfieScreanState();
}

class _CreateProfieScreanState extends State<CreateProfieScrean> {
  final GlobalKey<FormState> formKey = GlobalKey();


  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  DateTime? _selectedDate;
  TextEditingController? phoneController= TextEditingController();
  TextEditingController? countryController= TextEditingController();
  TextEditingController? workingFieldController= TextEditingController();
  TextEditingController? addressController= TextEditingController();
  TextEditingController? infoController= TextEditingController();
  String?jobField;

  String? date;
  void _presentDatePicker() async {
    final now = DateTime.now();

    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final packeddate = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.white,
                onPrimary:greenColor,
                surface: greenColor,

                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = packeddate;
      date='${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}';

    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => RegisterCubit(),
  child: BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if (state is RegisterErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('register error'),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (state is UserCreateErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User Create Error'),
          backgroundColor: Colors.green,
        ),
      );
    }
    if (state is UserCreateSuccessState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User Create Success'),
          backgroundColor: Colors.green,
        ),
      );
    }
    if (state is RegisterSuccessState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('register success'),
          backgroundColor: Colors.green,
        ),
      );
    }


  },
  builder: (context, state) {
    RegisterCubit cubit = RegisterCubit.get(context);
    return Scaffold(
      appBar: AppBar(

        elevation: 0,
        leading: Icon(
          Ionicons.person_circle,
          color: greenColor,
        ),
        title: Text(
          'Create Profile',
          style: TextStyle(color: greenColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFF8F8F8),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
              
                children: [
              
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 6.5,
                    decoration: BoxDecoration(
                   color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],),
                    child:  Row(

                       children: [
                         // Icon(Icons.upload,color: greenColor,size: 50,),
                         //  Text('Upload Photo Profle',style: Theme.of(context).textTheme.bodyMedium,),
                         SizedBox(width: 10,),
                         InkWell(
                           onTap: (){
                             cubit.pickProfileImage();
                           },
                           child: Container(
                             decoration: BoxDecoration(
                               color: Colors.white,
                               border: Border.all(
                                 color: greenColor,
                                 width: 2,
                               ),
                               shape: BoxShape.circle,
                             ),
                             child: CircleAvatar(
                               radius: 42,
                               backgroundColor: greenColor,
                                 backgroundImage: widget.image != null
                                     ? NetworkImage(widget.image!)
                                     : cubit.profileImage == null
                                     ? null
                                     : Image.file(cubit.profileImage!).image,
                               child: widget.image != null
                                   ? CircleAvatar(
                                 radius: 42,
                                 backgroundColor: greenColor,
                                 backgroundImage: NetworkImage(widget.image!),
                               )
                                   : cubit.profileImage == null
                                   ? CircleAvatar(
                                 radius: 42,
                                 backgroundColor: greenColor,
                                 child: Icon(Icons.add, color: Colors.white, size: 50),
                               )
                                   : CircleAvatar(
                                 radius: 42,
                                 backgroundColor: greenColor,
                                 backgroundImage: Image.file(cubit.profileImage!).image,
                               ),
                             ),
                           ),
                         ),
                         SizedBox(width: 10,),
                         Expanded(
                           child: Column(
                             crossAxisAlignment:CrossAxisAlignment.start ,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text("Name : ${widget.nameController!}",style: Theme.of(context).textTheme.bodyMedium,),
                               Text("email : ${widget.emailController!}",style: Theme.of(context).textTheme.bodyMedium,),
                               if (widget.phoneNumber!=null)
                               Text("phone : ${widget.phoneNumber}",style: Theme.of(context).textTheme.bodyMedium,),

                             ],
                           ),
                         ),


                       ],
                    ),

                    ),
                  // CustomTextField(
                  //   hint: 'name',
                  //   icon: Icons.person,
                  //   controller:widget.nameController,
                  // ),
                  //
                  // CustomTextField(
                  //   hint: 'email',
                  //   icon: Icons.email,
                  //   controller: widget.emailController,
                  // ),
                  if (widget.phoneNumber==null||widget.phoneNumber!.isEmpty)
                  CustomTextField(
                    hint: 'phone',
                    icon: Icons.phone,
                    controller: phoneController,
                  ),
                  CustomTextField(
                    hint: 'address',
                    icon: Icons.location_on,
                    controller: addressController,
                  ),
                  // CustomTextField(
                  //   hint: 'country',
                  //   icon: Icons.location_city,
                  //   controller: countryController,
                  // ),
                  SelectDateItem(
                    date: _selectedDate == null
                        ? 'Select Date'
                        : date,
                    onTap: _presentDatePicker,
                    icon: Icons.date_range,
              
                  ),
                  WorkingFeildsDropdownButtonFormField(
                    userType: widget.userType,

                    onCountry: (value){
                      countryController!.text=value;
                    },
                    screanName: 'Create Profile',
                    onWorkFeilds: (value){
                      workingFieldController!.text=value;
                    },
                    onJob: (value){
                     jobField=value;
                    },

                  ),
                  if (widget.userType=='users')
                  Row(
                    children: [
                      Text('Gender',style: Theme.of(context).textTheme.bodyMedium,),
                      SizedBox(width: 10,),
                      Radio(value: 'male',
                        activeColor: greenColor,

                          groupValue: cubit.gender, onChanged: (value){
                        cubit.changeGender(gender: value!);
                      }),
                      Text('male',style: Theme.of(context).textTheme.bodyMedium,),
                      SizedBox(width: 10,),
                      Radio(value: 'female', groupValue: cubit.gender,
                          activeColor: greenColor,

                          onChanged: (value){
                        cubit.changeGender(gender: value!);
                      }),
                      Text('female',style: Theme.of(context).textTheme.bodyMedium,),
                    ],
                  ),
                  // CustomTextField(
                  //  hint :'Working Field',
                  //   icon: Icons.work,
                  //   controller: workingFieldController,
                  // ),
                  if(widget.userType=='company')
                    CustomTextField(
                      hint: 'Company Information',
                      icon: Icons.info,
                      controller: infoController,
                    ),
                  if(widget.userType=='users')
                    CustomTextField(
                      hint: 'Your Information',
                      icon: Icons.info,
                      controller: infoController,
                    ),


                  if (state is uploadProfileImageLoadingState || state is RegisterLoadingState||state is UserCreateLoadingState)
                    LinearProgressIndicator(
                      color: greenColor,
                      minHeight: 10,
              
              
              
                    )
                  else
                    CustomButton(
                    buttonName: 'Confirm',
                    onPressed: () async {
                      if (widget.id !=null){
                        if (formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          await cubit.uploadProfileImage().whenComplete(() async =>

                          Future.delayed(Duration(seconds: 6)).whenComplete(() async => await cubit
                                  .addSomeInfoSignInGoogle(
                                      date: date,
                                      phone: phoneController!.text,
                                      address: addressController!.text,
                                      country: countryController!.text,
                                      workingField: workingFieldController!.text,
                                      gender: cubit.gender,
                                      uid: widget.id,
                                      info:infoController!.text,
                                      userType: widget.userType,
                                      image: cubit.profileImageLink,



                          ).whenComplete(() async {
                            if (widget.userType ==
                                'users') {
                              navigateToScreenAndExit(
                                  context,
                                  CompleteProfileUser());
                            } else if (widget.userType ==
                                'company') {
                              navigateToScreenAndExit(
                                  context,
                                  CompanyMainScrean());
                            }
                          })
                          ));


                        }else {
                          setState(() {
                            autovalidateMode =
                                AutovalidateMode.always;
                          });
                        }

                      }
                      else {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      await cubit.uploadProfileImage().whenComplete(() async => Future
                                              .delayed(Duration(seconds: 6))
                                          .whenComplete(() async => await cubit
                                                  .register(
                                                      profileImageLink: cubit
                                                          .profileImageLink,
                                          info: infoController!
                                                          .text,
                                                      email: widget
                                                          .emailController!,
                                                      password: widget
                                                          .passwordController!
                                                          .text,
                                                      userType: widget.userType,
                                                      address: addressController!
                                                          .text,
                                                      country: countryController!
                                                          .text,
                                                      phone:
                                                          phoneController!.text,
                                                      workingField:
                                                          workingFieldController!
                                                              .text,
                                                      date: date,
                                                      name: widget
                                                          .nameController!)
                                                  .whenComplete(
                                                () {
                                                  if (widget.userType ==
                                                      'users') {
                                                    navigateToScreenAndExit(
                                                        context,
                                                        CompleteProfileUser());
                                                  } else if (widget.userType ==
                                                      'company') {
                                                    navigateToScreenAndExit(
                                                        context,
                                                        CompanyMainScrean());
                                                  }
                                                },
                                              )));
                                    } else {
                                      setState(() {
                                        autovalidateMode =
                                            AutovalidateMode.always;
                                      });
                                    }
                                  }
                                },
                  )
              
              
              
              
                ]),
            ),
          ),
        )
      ),

    );
  },
),
);
  }
}
