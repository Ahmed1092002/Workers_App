import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../src/app_root.dart';
import '../blocs/UserProfileCubit/user_profile_cubit.dart';
import '../widget/add_or_edit_skills_bottom_m_odel_sheet.dart';

class EditSkills extends StatelessWidget {
  const EditSkills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit()..getSkills(),
      child: BlocBuilder<UserProfileCubit, UserProfileState>(

        builder: (context, state) {
          var cubit = UserProfileCubit.get(context);
          if (state is GetSkillsLoadingState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(

              title: Text('Edit Skills'),
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: greenColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: backgroundColor,

              iconTheme: IconThemeData(
                color: greenColor, //
                // change your color here
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) {
                      return AddOrEditSkillsBottomModelSheet(
                        onAdd: (skills) {
                          cubit.addSkills(skills: skills);
                          cubit.skills.clear;
                          cubit.getSkills();
                          Navigator.pop(context);
                        },
                      );
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: greenColor,
                  ),
                ),
              ],

            ),
            body:Wrap(
              children: cubit.skills.map((skill) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: greenColor,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),

                            color: greenColor,
                          ),
                          child: IconButton(onPressed: (){
                            cubit.deleteSkills(id: skill.id!);
                            cubit.skills.clear();
                            cubit.getSkills();
                          }, icon: Icon(Ionicons.close,color: Colors.red,)),
                        ),
                        SizedBox(width: 10,),
                        Flexible(child: Text('Skill  : ${skill.name}')),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

          );
        },
      ),
    );
  }
}
