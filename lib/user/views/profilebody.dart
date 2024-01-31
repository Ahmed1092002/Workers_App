import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:tab_container/tab_container.dart';
import 'package:untitled10/user/blocs/UserProfileCubit/user_profile_cubit.dart';
import 'package:untitled10/user/widget/about_container.dart';
import 'package:untitled10/user/widget/education_container.dart';
import 'package:untitled10/user/widget/projects_container.dart';
import 'package:untitled10/user/widget/work_experience_container.dart';

import '../widget/skills_container.dart';

class Profilebody extends StatefulWidget {
   Profilebody({Key? key}) : super(key: key);

  @override
  State<Profilebody> createState() => _ProfilebodyState();
}

class _ProfilebodyState extends State<Profilebody> {
  List<String> items = [
    'About',
    'Work Experience',
    'Skills',
    'Education',
    'Projects',

  ];

  /// List of body icon
  List widgets = [
AboutContainer(



),
    WorkExperienceContainer(

    ),
    SkillsContainer(

    ),
    EducationContainer(

    ),
    ProjectsContainer(

    ),

  ];
  sendDataIntoPage(int index) {

    return widgets.elementAt(index);
  }


  int current = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => UserProfileCubit()..getProfileData()..getEducation()..getWorkExperience()..getSkills()..getProjects(),
  child: Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height,
      child: BlocConsumer<UserProfileCubit, UserProfileState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = UserProfileCubit.get(context);
    if (cubit.userModel == null || cubit.skills.isEmpty || cubit.workExperience.isEmpty || cubit.projects.isEmpty || cubit.education.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height*0.17,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: greenColor,
                width: 2,
              )
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: greenColor,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(cubit.userModel!.image!),
                  ),
                ),
                SizedBox(
                  width: 17,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Name: ${cubit.userModel!.name!}",
                      style: TextStyle(color: grayColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "email: ${cubit.userModel!.email!}",
                      style: TextStyle(color: grayColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "phone: ${cubit.userModel!.phone!}",
                      style: TextStyle(color: grayColor, fontWeight: FontWeight.bold),
                    ),    Text(
                      "Birth Date: ${cubit.userModel!.date!}",
                      style: TextStyle(color: grayColor, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width/1.1,
            height: MediaQuery.of(context).size.height/1.8,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: greenColor,
                width: 2,
              )
            ),
            alignment: Alignment.center,
            child:Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  /// Tab Bar
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: items.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return Column(

                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    current = index;
                                  });
                                  pageController.animateToPage(
                                    current,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease,
                                  );


                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.all(5),
                                  width: 105,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: current == index
                                        ? greenColor
                                        : Colors.white54,
                                    borderRadius: current == index
                                        ? BorderRadius.circular(12)
                                        : BorderRadius.circular(7),
                                    border: current == index
                                        ? Border.all(
                                        color: greenColor,
                                        width: 2.5)
                                        : null,
                                  ),

                                  child: Center(
                                    child: Text(
                                      items[index],
                                      style: TextStyle(
                                        color: current == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: current == index,
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                     color:Color(0xFF4C846E) ,
                                      shape: BoxShape.circle),
                                ),
                              )
                            ],
                          );
                        }),
                  ),

                  /// MAIN BODY
                  Container(

                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.418,
                    child: PageView.builder(
                      itemCount: widgets.length,
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(


                          decoration: BoxDecoration(
                            color: current == index
                                ? greenColor

                                : Colors.white54,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: greenColor,
                              width: 2,
                            ),
                          ),
                          child: widgets[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
    ]
      );
  },
)


    ),
);
  }
}
