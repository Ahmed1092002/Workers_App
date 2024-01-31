import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:untitled10/SharedBloc/LoginCubit/login_cubit.dart';
import 'package:untitled10/SharedViews/register_screan.dart';
import 'package:untitled10/SharedWidget/check_box.dart';
import 'package:untitled10/SharedWidget/loginwith_google.dart';
import 'package:untitled10/company/views/main_screan.dart';
import 'package:untitled10/main.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/SharedWidget/custom_text_field.dart';
import 'package:untitled10/SharedWidget/logo_image.dart';
import 'package:untitled10/user/views/main_screan.dart';
import 'package:untitled10/utils/navigator.dart';


class LoginScrean extends StatelessWidget {
   LoginScrean({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  var box = Hive.box(boxName);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
     if (state is LoginSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Successfully'),
          backgroundColor: greenColor,
        ));
      }
      if (state is LoginErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error Login'),
          backgroundColor: Colors.red,
        ));
      }

  },
  builder: (context, state) {
    var cubit = LoginCubit.get(context);
    return Scaffold(

     body:   Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.height * 0.8,
            color: Color(0xFFF8F8F8),
            child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height/10,
                        ),
                        LogoImage(),

                        Text(
                          'Sign in to your account',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/50,
                        ),
                        Row(

                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/15,
                            ),

                            Text(
                              'Don`t have an Account ?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(

                              onPressed: () {
                                navigateToScreen(context, RegisterScrean());
                              },
                              child: Text(
                                'Register Now !',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 5,

                          margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: greenColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextField(
                                hint: 'email',
                                icon: Icons.email,
                                controller: cubit.emailController,
                              ),
                              CustomTextField(
                                hint: 'password',
                                icon: Icons.lock,
                                controller: cubit.passwordController,
                              ),
                              if (state is LoginLoadingState || state is GetUserDataSuccessState)
                                CircularProgressIndicator(
                                  color: greenColor,
                                )
                              else
                                CustomButton(
                                buttonName: 'Login',
                                onPressed: () async {

                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                  await  cubit.login(
                                        email: cubit.emailController.text,
                                        password: cubit.passwordController.text,
                                    context: context

                                       );





                                  } else {
                                    autovalidateMode =
                                        AutovalidateMode.always;
                                  }


                                },
                              ),
SizedBox(
  height: 15,
),
Padding(
  padding: const EdgeInsets.all(20.0),
  child: LoginwithGoogle(
    buttonName: 'Login With Google',
    onPressed: () async{
      await  cubit.signInWithGoogle(
          context: context

      );



    },

  ),
)

                            ],

                          ),


                        ),


                      ]),
                )))
    );
  },
),
);
  }
}
