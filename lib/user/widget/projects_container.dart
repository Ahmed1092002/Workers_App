import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/data/users/projects.dart';

import '../blocs/UserProfileCubit/user_profile_cubit.dart';

class ProjectsContainer extends StatelessWidget {

   ProjectsContainer({Key? key,}) : super(key: key);

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
          child: cubit.projects.isEmpty?Text('No Projects'): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:cubit.projects.map((e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Project Name : ${e.name}'),
                Divider(),
                Text('Description : ${e.description}'),
                Divider(),
                Text('Url : ${e.url}'),
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
