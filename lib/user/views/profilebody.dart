import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:untitled10/SharedWidget/circle_avatar_image.dart';
import 'package:untitled10/company/views/edit_profile_company.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/blocs/UserProfileCubit/user_profile_cubit.dart';
import 'package:untitled10/user/views/applyed_jops.dart';
import 'package:untitled10/user/views/edit_education_screan.dart';
import 'package:untitled10/user/views/edit_experince_screan.dart';
import 'package:untitled10/user/views/edit_projects.dart';
import 'package:untitled10/user/views/edit_skills.dart';
import 'package:untitled10/user/views/saved_jobs.dart';
import 'package:untitled10/user/widget/profile_list_tile.dart';
import 'package:untitled10/user/widget/about_container.dart';
import 'package:untitled10/user/widget/education_container.dart';
import 'package:untitled10/user/widget/projects_container.dart';
import 'package:untitled10/user/widget/work_experience_container.dart';

import '../../utils/navigator.dart';
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
    AboutContainer(),
    WorkExperienceContainer(),
    SkillsContainer(),
    EducationContainer(),
    ProjectsContainer(),
  ];
  sendDataIntoPage(int index) {
    return widgets.elementAt(index);
  }

  int current = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit()
        ..getProfileData()
      ..completeProfile()
      ..getWorkExperience()
      ..getEducation()
      ..getSkills()
      ..getProjects()
       ,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BlocConsumer<UserProfileCubit, UserProfileState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = UserProfileCubit.get(context);
              if (cubit.userModel == null ) {
                return Center(
                  child:LoadingAnimationWidget.twoRotatingArc(
                    color: greenColor,
                    size: 100,

                  ),
                );
              }

              return Column(

                  children: [
                SizedBox(
                  height: 5,
                ),
                Row(
mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                   CircleAvatarImage(imageUrl: cubit.userModel!.image!,),
                    SizedBox(
                      width: 17,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${cubit.userModel!.name!}",
                          style: TextStyle(
                              color: greenColor, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${cubit.userModel!.email!}",
                          style: TextStyle(
                              color: grayColor, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${cubit.userModel!.jobField!}",
                          style: TextStyle(
                              color: grayColor, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        if (cubit.percent!< 1.0)
                         Container(
                            width: MediaQuery.of(context).size.width - 150,

                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(10),
                             border: Border.all(
                               color: greenColor,
                               width: 2,
                             ),
                           ),
                           child: Column(
                             children: [
                               Text('Complete Profile : ',style: TextStyle(
                                 color: greenColor,
                                 fontWeight: FontWeight.bold,
                               ),),
                               LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width - 160,
                                animation: true,
                                lineHeight: 20.0,
                                barRadius: Radius.circular(10),

                                animationDuration: 2500,
                                percent: cubit.percent!,
                                center: Text("${cubit.percent! * 100} %",style: TextStyle(
                                  color: backgroundColor,
                                  fontWeight: FontWeight.bold,
                                ),),
                                progressColor: greenColor,
                                                       ),
                               ...cubit.percent! < 1.0 ? [
                                 Text('Please Complete Your Profile',style: TextStyle(
                                   color: greenColor,
                                   fontWeight: FontWeight.bold,
                                 ),),
                               ] : [
                                 Text('Your Profile is Completed',style: TextStyle(
                                   color: greenColor,

                                 ),),

                               ]
                             ],
                           ),
                         ),
                        if (cubit.percent==1.0)...
              [          SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Your Profile is Completed",
                          style: TextStyle(
                              color: grayColor, fontWeight: FontWeight.bold),
                        ),]


                      ],
                    ),
                  ],
                ),

                Expanded(
                  child: ListView(
                    children: [

                      ProfileListTile(
                        title: 'About Me',
                        iconData: Ionicons.person_outline,
                        onTap: (){
                          navigateToScreen(context, EditProfileCompany(
                            user: cubit.userModel!,
                          ));
                        },

                      ),
                      ProfileListTile(
                        title: 'Work Experience',
                        iconData: Ionicons.business_outline,
                        onTap: (){
                          navigateToScreen(context, EditExperinceScrean());
                        },

                      ),
                      ProfileListTile(
                        title: 'Education',
                        iconData: Ionicons.school_outline,
                        onTap: (){
                          navigateToScreen(context, EditEducationScrean());
                        },

                      ),
                      ProfileListTile(
                        title: 'Projects',
                        iconData: Ionicons.business_outline,
                        onTap: (){
                          navigateToScreen(context, EditProjects());
                        },

                      ),
                      ProfileListTile(
                        title: 'Skills',
                        iconData: Ionicons.pie_chart_outline,
                        onTap: (){
                          navigateToScreen(context, EditSkills());
                        },

                      ),
                      ProfileListTile(
                        title: 'Saved Jops',
                        iconData: Ionicons.bookmarks_outline,
                        onTap: (){
                          navigateToScreen(context, SavedJobs());
                        },

                      ),
                      ProfileListTile(
                        title: 'Applied Jops',
                        iconData: Ionicons.checkmark_done_outline,
                        onTap: (){
                          navigateToScreen(context, ApplyedJops());
                        },

                      ),


                      // /// Tab Bar
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 80,
                      //   child: ListView.builder(
                      //       physics: const BouncingScrollPhysics(),
                      //       itemCount: items.length,
                      //       scrollDirection: Axis.horizontal,
                      //       itemBuilder: (ctx, index) {
                      //         return Column(
                      //
                      //           children: [
                      //             GestureDetector(
                      //               onTap: () {
                      //                 setState(() {
                      //                   current = index;
                      //                 });
                      //                 pageController.animateToPage(
                      //                   current,
                      //                   duration: const Duration(milliseconds: 200),
                      //                   curve: Curves.ease,
                      //                 );
                      //
                      //
                      //               },
                      //               child: AnimatedContainer(
                      //                 duration: const Duration(milliseconds: 300),
                      //                 margin: const EdgeInsets.all(5),
                      //                 width: 105,
                      //                 height: 50,
                      //                 decoration: BoxDecoration(
                      //                   color: current == index
                      //                       ? greenColor
                      //                       : Colors.white54,
                      //                   borderRadius: current == index
                      //                       ? BorderRadius.circular(12)
                      //                       : BorderRadius.circular(7),
                      //                   border: current == index
                      //                       ? Border.all(
                      //                       color: greenColor,
                      //                       width: 2.5)
                      //                       : null,
                      //                 ),
                      //
                      //                 child: Center(
                      //                   child: Text(
                      //                     items[index],
                      //                     style: TextStyle(
                      //                       color: current == index
                      //                           ? Colors.white
                      //                           : Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Visibility(
                      //               visible: current == index,
                      //               child: Container(
                      //                 width: 5,
                      //                 height: 5,
                      //                 decoration: const BoxDecoration(
                      //                    color:Color(0xFF4C846E) ,
                      //                     shape: BoxShape.circle),
                      //               ),
                      //             )
                      //           ],
                      //         );
                      //       }),
                      // ),
                      //
                      // /// MAIN BODY
                      // Container(
                      //
                      //   width: double.infinity,
                      //   height: MediaQuery.of(context).size.height / 2.418,
                      //   child: PageView.builder(
                      //     itemCount: widgets.length,
                      //     controller: pageController,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemBuilder: (context, index) {
                      //       return Container(
                      //
                      //
                      //         decoration: BoxDecoration(
                      //           color: current == index
                      //               ? greenColor
                      //
                      //               : Colors.white54,
                      //           borderRadius: BorderRadius.circular(10),
                      //           border: Border.all(
                      //             color: greenColor,
                      //             width: 2,
                      //           ),
                      //         ),
                      //         child: widgets[index],
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ]);
            },
          )),
    );
  }
}
