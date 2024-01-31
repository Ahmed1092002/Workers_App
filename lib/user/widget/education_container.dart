import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/data/users/education.dart';
import 'package:untitled10/user/blocs/UserProfileCubit/user_profile_cubit.dart';

class EducationContainer extends StatelessWidget {

   EducationContainer({Key? key}) : super(key: key);

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
        child: cubit.education.isEmpty ? Text('No Education') : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cubit.education.map((e) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('School Name : ${e.name}'),
            Divider(),
                  Text('Degree : ${e.degree}'),
                  Divider(),
                  Text('Start Date : ${e.from}'),
                  Divider(),
                  Text('End Date : ${e.to}'),
                  Divider(),
                  Text('Period : ${e.field}'),
                  Divider(),
                  Text('Grade : ${e.grade}'),
                  Divider(),

                  Text('Description : ${e.description}'),

                ],
              ),
            ),
          )).toList(),
        ),
      );
  },
),
    );
  }
}
