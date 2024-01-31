import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/data/users/skills.dart';
import 'package:untitled10/user/blocs/UserProfileCubit/user_profile_cubit.dart';

class SkillsContainer extends StatelessWidget {

  SkillsContainer({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UserProfileCubit.get(context);
        return Container(
          width: MediaQuery
              .of(context)
              .size
              .width,

          decoration: BoxDecoration(
            
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.green,
                width: 2,
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: cubit.skills.isEmpty ? Text('No Skills') :  Wrap(
              spacing: 5,
              runSpacing: 5,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,

              children: cubit.skills.map((e) => Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      )),
                  alignment: Alignment.center,
                  child: Text(e.name!))).toList(),
            ),
          ),
        );
      },
    );
  }
}
