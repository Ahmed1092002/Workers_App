import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/SharedViews/SelectTypeScrean.dart';
import 'package:untitled10/SharedWidget/loginwith_google.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/SharedViews/login_screan.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/SharedWidget/custom_text_field.dart';
import 'package:untitled10/SharedWidget/logo_image.dart';
import 'package:untitled10/utils/navigator.dart';

import '../SharedBloc/RegisterCubit/register_cubit.dart';



class RegisterScrean extends StatelessWidget {
   RegisterScrean({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context)
            .size
            .width, // to make the container take the whole width of the screen
        height: MediaQuery.of(context).viewInsets.bottom == 0
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.height * 0.8,
        color: Color(0xFFF8F8F8),
        child: BlocProvider(
  create: (context) => RegisterCubit(),
  child: SingleChildScrollView(

          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                LogoImage(),

                Text(
                  'Create new account',
                ),

                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'already have an account?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(

                      onPressed: () {
                        navigateToScreen(context, LoginScrean());
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 5,

                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greenColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        hint: 'name',
                        icon: Icons.person,
                        controller: nameController,
                      ),
                      CustomTextField(
                        hint: 'email',
                        icon: Icons.email,
                        controller: emailController,
                      ),
                      CustomTextField(
                        hint: 'password',
                        icon: Icons.lock,
                        controller: passwordController,

                      ),
                      CustomTextField(
                        hint: 'confirm password',
                        icon: Icons.lock,
                        controller: confirmPasswordController,
                      ),


                        BlocBuilder<RegisterCubit, RegisterState>(
  builder: (context, state) {
    return CustomButton(
                          buttonName: 'Continue',
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                var selectTypeScrean = SelectTypeScrean(
                                  nameController: nameController.text,
                                  emailController: emailController.text,
                                  passwordController: passwordController,
                                );
                                navigateToScreenAndExit(context, selectTypeScrean);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('passwords not match'),
                                  ),
                                );
                              }


                            } else {
                              autovalidateMode =
                                  AutovalidateMode.always;
                            }

                          },
                        );
  },
)
                    ],
                  ),
                ),
                Text('or continue with'),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BlocBuilder<RegisterCubit, RegisterState>(
  builder: (context, state) {
    return LoginwithGoogle(
                    buttonName: 'Login with Google',
                    onPressed: () async  {
                      await RegisterCubit.get(context)
                          .signInWithGoogle( ).then((value) {

                        navigateToScreenAndExit(context,  SelectTypeScrean(
                          nameController: value.user!.displayName,
                          emailController: value.user!.email,
id: value.user!.uid,
                          passwordController: passwordController,
                          image: value.user!.photoURL,
                          phoneNumber: value.user!.phoneNumber,
                        ));

                      });


                    },

                  );
  },
),
                )
              ],
            ),
          ),
        ),
),
      ),
    );
  }
}
