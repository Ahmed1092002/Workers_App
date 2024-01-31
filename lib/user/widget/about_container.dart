import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/user/blocs/UserProfileCubit/user_profile_cubit.dart';

class AboutContainer extends StatelessWidget {

   AboutContainer({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = UserProfileCubit.get(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.green,
            width: 2,
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(' Your Informaion : \t ${cubit.userModel!.info}'),
            Divider(),
            Text(' address : \t ${cubit.userModel!.address}'),
            Divider(),
            Text(' country : \t ${cubit.userModel!.country}'),
            Divider(),
            Text(' workingField : \t ${cubit.userModel!.workingField}'),

          ],
        ),
      ),

    );
  },
);
  }
}
