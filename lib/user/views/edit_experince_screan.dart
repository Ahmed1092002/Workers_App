import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/data/users/work_experience.dart';
import 'package:untitled10/user/widget/add_or_edit_experience_model_bottom_sheet.dart';

import '../../src/app_root.dart';
import '../blocs/UserProfileCubit/user_profile_cubit.dart';
import '../widget/add_or_edit_education_model_bottom_sheet.dart';

class EditExperinceScrean extends StatelessWidget {
  const EditExperinceScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => UserProfileCubit()..getWorkExperience(),
  child: BlocBuilder<UserProfileCubit, UserProfileState>(
  builder: (context, state) {
    var cubit = UserProfileCubit.get(context);
    if (state is GetWorkExperienceLoadingState) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(

        title: Text('Edit Experince'),
        titleTextStyle: TextStyle(
          color: greenColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: backgroundColor,
         iconTheme: IconThemeData(
          color: greenColor, //change your color here
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(context: context,
                  barrierColor: Colors.black.withOpacity(0.5),
                  isScrollControlled: true,
                  showDragHandle: true,
                  useSafeArea: true,

                  barrierLabel: 'add',builder: (context) {
                return AddOrEditExperienceModelBottomSheet(
                  onAdd: (workExperience) {
                    cubit.addWorkExperience(workExperience: workExperience);
                    cubit.workExperience.clear();
                    cubit.getWorkExperience();
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
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cubit.workExperience.length,
        itemBuilder: (context, index) {
          print (cubit.workExperience[index].id);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Container(
                  width: MediaQuery.of(context).size.width*0.822 ,

                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color:greenColor,
                        width: 2,
                      ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('Company Name :',style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text('${cubit.workExperience[index].company}',),
                      Divider(),
                      Text('Position : ',style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text('${cubit.workExperience[index].position}'),
                      Divider(),

                      Text('Start Date :',style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text(' ${cubit.workExperience[index].startDate}'),
                      Divider(),

                      Text('End Date :',style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text('${cubit.workExperience[index].endDate}'),
                      Divider(),

                      Text('Period :',style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text('${cubit.workExperience[index].period}'),
                      Divider(),

                      Text('Description : ',style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text('${cubit.workExperience[index].description}'),

                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )

                  ),
                  child: Column(
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
                                return AddOrEditExperienceModelBottomSheet(
                                  onEdit: ( workExperience) {
                                    cubit.editWorkExperience(workExperience:workExperience , id: cubit.workExperience[index].id.toString());
                                    cubit.workExperience.clear();
                                    cubit.getWorkExperience();
                                    Navigator.pop(context);
                                  },
                                  workExperienceModel: WorkExperience(
                                    id: cubit.workExperience[index].id,
                                    description: cubit.workExperience[index].description,
                                    company: cubit.workExperience[index].company,
                                    position: cubit.workExperience[index].position,
                                    startDate: cubit.workExperience[index].startDate,
                                    endDate: cubit.workExperience[index].endDate,
                                    period: cubit.workExperience[index].period,

                                  ),

                                );
                              });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {

                          cubit.deleteWorkExperience(
                              id: cubit.workExperience[index].id.toString());
                          cubit.workExperience.clear();
                          cubit.getWorkExperience();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
