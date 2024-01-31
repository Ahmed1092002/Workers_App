import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/src/app_root.dart';

import '../../data/users/education.dart';
import '../blocs/UserProfileCubit/user_profile_cubit.dart';
import '../widget/add_education_container.dart';
import '../widget/add_or_edit_education_model_bottom_sheet.dart';

class EditEducationScrean extends StatelessWidget {
  const EditEducationScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit()..getEducation(),
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          var cubit = UserProfileCubit.get(context);
          if (state is GetEducationLoadingState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
              appBar: AppBar(

                title: Text('Edit Education'),
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
                      showModalBottomSheet(context: context,
                          barrierColor: Colors.black.withOpacity(0.5),
                          isScrollControlled: true,
                          showDragHandle: true,
                          useSafeArea: true,
                          barrierLabel: 'add',builder: (context) {
                        return AddOrEditEducationModelBottomSheet(
                          onAddItem: ( education) {
                            cubit.addEducation(education: education);
                            cubit.education.clear();
                            cubit.getEducation();
                            Navigator.pop(context);
                          },
                        );
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: greenColor,
                    ),
                  )
                ],
              ),
              body: ListView.builder(
                itemCount: cubit.education.length,
                itemBuilder: (context, index) {
                  print (cubit.education[index].id);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                       padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.green,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(context: context,
                                      barrierColor: Colors.black.withOpacity(0.5),
                                      isScrollControlled: true,
                                      showDragHandle: true,
                                      useSafeArea: true,
                                      barrierLabel: 'edit',
                                      builder: (context) {
                                    return AddOrEditEducationModelBottomSheet(
                                      onEdit: ( education) {
                                        cubit.editEducation(education: education, id: cubit.education[index].id.toString());
                                        cubit.education.clear();
                                        cubit.getEducation();
                                        Navigator.pop(context);
                                      },
                                      educationModel: Education(
                                        id: cubit.education[index].id,
                                        name: cubit.education[index].name,
                                        degree: cubit.education[index].degree,
                                        from: cubit.education[index].from,
                                        to: cubit.education[index].to,
                                        field: cubit.education[index].field,
                                        grade: cubit.education[index].grade,
                                        description: cubit.education[index].description,
                                      ),
                                    );
                                  });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: greenColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {

                                  cubit.deleteEducation(
                                     id: cubit.education[index].id.toString());
                                  cubit.education.clear();
                                  cubit.getEducation();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Text('School Name : ${cubit.education[index].name} '),
                          Divider(),
                          Text('Degree : ${cubit.education[index].degree}'),
                          Divider(),
                          Text('Start Date : ${cubit.education[index].from}'),
                          Divider(),
                          Text('End Date : ${cubit.education[index].to}'),
                          Divider(),
                          Text('Period : ${cubit.education[index].field}'),
                          Divider(),
                          Text('Grade : ${cubit.education[index].grade}'),
                          Divider(),
                          Text('Description : ${cubit.education[index].description}'),
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
