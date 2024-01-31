import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/data/users/work_experience.dart';
import 'package:untitled10/user/blocs/UserProfileCubit/user_profile_cubit.dart';

class WorkExperienceContainer extends StatelessWidget {
   WorkExperienceContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<UserProfileCubit, UserProfileState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = UserProfileCubit.get(context);
    return Container(
        width: MediaQuery.of(context).size.width,
      
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.green,
              width: 2,
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:cubit.workExperience.isEmpty?Text('No Work Experience'): Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: cubit.workExperience.map((e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Company Name : ${e.company}'),
                Divider(),
                Text('Position : ${e.position}'),
                Divider(),
                Text('Start Date : ${e.startDate}'),
                Divider(),
                Text('End Date : ${e.endDate}'),
                Divider(),
                Text('Period : ${e.period}'),
                Divider(),
                Text('Description : ${e.description}'),
                
              ],
            )).toList(),
          ),
        ),
      );
  },
),
    );
  }
}
