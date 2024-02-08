import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/data/users/education.dart';
import 'package:untitled10/data/users/skills.dart';
import 'package:untitled10/data/users/work_experience.dart';
import 'package:untitled10/user/blocs/CreateProfileUserCubit/create_profile_user_cubit.dart';
import 'package:untitled10/user/widget/add_education_container.dart';
import 'package:untitled10/user/widget/add_skills_container.dart';
import 'package:untitled10/user/widget/add_work_experience_container.dart';
import 'package:untitled10/user/views/main_screan.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../data/users/projects.dart';
import '../../src/app_root.dart';
import '../widget/add_projects_container.dart';

class CompleteProfileUser extends StatefulWidget {
  const CompleteProfileUser({Key? key}) : super(key: key);

  @override
  _CompleteProfileUserState createState() => _CompleteProfileUserState();
}

class _CompleteProfileUserState extends State<CompleteProfileUser> {
  List <WorkExperience> workExperience = [];
  List <Education>education=[] ;
  List<SKills> skills =[] ;
  List<Projects> projects=[]  ;
  List Data=[]  ;

  List widgetList=[] ;

  int current = 0;
  @override
  void initState() {
    super.initState();
    widgetList = [
      AddWorkExperienceContainer(
        onAdd: (value) {
          setState(() {
            workExperience = List<WorkExperience>.from(value);
          });
        },

      ),
      AddEducationContainer(
        onAdd: (value) {
          setState(() {
            education = List<Education>.from(value);
          });
        },
      ),
      AddSkillsContainer(
        onAdd:(value) {
          setState(() {
            skills = List<SKills>.from(value);
          });
        },
      ),
      AddProjectsContainer(
        onAdd: (value) {
          setState(() {
            projects = List<Projects>.from(value);
          });
        },
      ),
    ];
    Data = [workExperience, education, skills, projects];
    pageController.addListener(() {
      setState(() {
        current = pageController.page!.toInt();
      });
    });
  }
  PageController pageController = PageController( initialPage: 0);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    pageController.addListener(() {
      setState(() {
        current = pageController.page!.toInt();
      });
    });
  }


  void nextPage() {
    pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => CreateProfileUserCubit(),
  child: Scaffold(
        appBar: AppBar(
          title: Text('Complete Profile'),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: greenColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: greenColor, //change your color here
          ),
        ),

        body: BlocConsumer<CreateProfileUserCubit, CreateProfileUserState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    var cubit = CreateProfileUserCubit.get(context);
    return Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.87,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:  greenColor,

                          width: 2,
                        )),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // AnimatedContainer(
                        //   duration: Duration(milliseconds: 500),
                        //   curve: Curves.easeIn,
                        //
                        //
                        //
                        //   width: MediaQuery.of(context).size.width,
                        //   height: MediaQuery.of(context).size.height * 0.8,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: widgetList[current],
                        // ),
                        Expanded(
                            child: PageView.builder(

                              scrollBehavior: ScrollBehavior(),
                              physics: NeverScrollableScrollPhysics(),
                              onPageChanged: (current1){
                                setState(() {
                                  current = current1;
                                });


                              },itemBuilder: (context, index) {
                          return widgetList[index];
                        }, itemCount: widgetList.length, controller: pageController,)),
                        if(state is AddProjectsLoadingState)
    LoadingAnimationWidget.staggeredDotsWave(
        color: greenColor,
        size: 20)
                        else
                        CustomButton(
                          buttonName: 'Continue',
                          onPressed: () {
                            setState(() {
                              current++;
                              pageController.nextPage(duration:   Duration(milliseconds: 500), curve: Curves.easeIn);

                              print(current);
                              if (current == 1) {
                                cubit.addExperience(workExperience );
                              } else if (current == 2) {
                                cubit.addEducation( education);
                              } else if (current == 3) {
                                cubit.addSkills( skills);
                              } else   if (current > 3) {
                                cubit.addProjects(projects).whenComplete(() {
                                  navigateToScreenAndExit(
                                      context, MainScrean());
                                });
                                // navigateToScreenAndExit(
                                //     context, MainScrean());
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  },
)),
);
  }
}
