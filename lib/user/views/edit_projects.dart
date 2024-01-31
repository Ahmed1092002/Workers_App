import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/user/widget/add_or_edit_projects.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../src/app_root.dart';
import '../blocs/UserProfileCubit/user_profile_cubit.dart';

class EditProjects extends StatelessWidget {
  const EditProjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit()..getProjects(),
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          var cubit = UserProfileCubit.get(context);
          if (state is UserProfileInitial) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
              appBar: AppBar(

                title: Text('Edit Projects'),
                titleTextStyle: TextStyle(
                  color: greenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: backgroundColor,
                iconTheme: IconThemeData(
                  color: greenColor, //change your color here
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        showDialog(context: context, builder: (_){
                          return AddOrEditProjects(
                            onAdd: (projectsModel) {
                              cubit.addProjects(projects: projectsModel);
                              cubit.projects.clear();
                              cubit.getProjects();
                              Navigator.pop(context);
                            },
                          );
                        });

                      },
                      icon: Icon(Icons.add, color: greenColor,))
                ],

              ),
              body: ListView.builder(
                itemCount: cubit.projects.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: greenColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Project Name : ${cubit.projects[index].name}'),
                                Text('Project Description : ${cubit.projects[index].description}'),
                                TextButton(onPressed: () async{
                                  final Uri _url = Uri.parse('https://flutter.dev');
                                  if (!await launchUrl(_url)) {
                                    throw Exception('Could not launch $_url');
                                  }


                                }
                                    ,style: TextButton.styleFrom(
                                  primary: greenColor,

                                  textStyle: TextStyle(
                                    color: greenColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                    child: Text('Project Link: https://github.com/')),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  cubit.deleteProjects(id: cubit.projects[index].id!);
                                  cubit.projects.clear();
                                  cubit.getProjects();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),

                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (_){
                                    return AddOrEditProjects(
                                      projectsModel: cubit.projects[index],
                                      onEdit: (projectsModel) {
                                        cubit.editProjects(projects: projectsModel,id: cubit.projects[index].id!);
                                        cubit.projects.clear();
                                        cubit.getProjects();
                                        Navigator.pop(context);
                                      },
                                    );
                                  });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: greenColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
          );
        },
      ),
    );
  }
}
