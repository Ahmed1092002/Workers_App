import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled10/SharedViews/ChatScreen.dart';
import 'package:untitled10/company/views/about_and_skills_body.dart';
import 'package:untitled10/company/views/eduction_body.dart';
import 'package:untitled10/company/views/experienc_body.dart';
import 'package:untitled10/company/views/project_body.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../SharedWidget/custoButton.dart';
import '../../data/company/company_model.dart';
import '../../data/company/jop_model.dart';
import '../../data/users/education.dart';
import '../../data/users/projects.dart';
import '../../data/users/skills.dart';
import '../../data/users/work_experience.dart';
import '../blocs/JopCubit/jop_cubit.dart';

class ApplyedUserProfieScrean extends StatefulWidget {
  List<WorkExperience>? workExperience;
  List<Education>? education;
  List<SKills>? skills;
  List<Projects>? projects;
  UserModel? userModel;
  JopsModel? jopModel;

  ApplyedUserProfieScrean({Key? key,
    this.workExperience,
    this.education,
    this.skills,
    this.projects,
    this.jopModel,
    this.userModel})
      : super(key: key);

  @override
  State<ApplyedUserProfieScrean> createState() =>
      _ApplyedUserProfieScreanState();
}

class _ApplyedUserProfieScreanState extends State<ApplyedUserProfieScrean>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('User Profile'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: greenColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('${widget.userModel!.id}');
              print('${widget.userModel!.name}');
              navigateToScreen(
                  context,
                  ChatScreen(
                    userModel: widget.userModel,
                  ));
            },
            icon: Icon(Ionicons.chatbubble_ellipses),
          ),
        ],
        iconTheme: IconThemeData(
          color: greenColor, //
          // change your color here
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: grayColor,
          labelColor: greenColor,
          unselectedLabelColor: grayColor,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          onTap: (index) {
            _tabController.animateTo(index);
          },
          isScrollable: true,

          indicatorPadding: EdgeInsets.all(5),
          splashBorderRadius: BorderRadius.circular(10),
          tabs: [

            Tab(
              child: Row(
                children: [
                  Icon(
                    Ionicons.person,
                    color: greenColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'About',
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  Icon(
                    Ionicons.business,
                    color: greenColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Work Experience',
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Tab(

              child: Row(

                children: [
                  Icon(
                    Ionicons.school,
                    color: greenColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Education',
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  Icon(
                    Ionicons.cube,
                    color: greenColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Projects',
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AboutAndSkillsBody(
                  userModel: widget.userModel!,
                  skills: widget.skills,
                ),
                ExperiencBody(workExperience: widget.workExperience),
                EductionBody(
                  education: widget.education,
                ),
                ProjectBody(
                  projects: widget.projects,
                ),
              ],
            ),
          ),
          BlocProvider(
            create: (context) => JopCubit(),
            child: BlocConsumer<JopCubit, JopState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // CustomButton(
                      //   buttonName: 'Accept',
                      //
                      //   onPressed: () {
                      //     JopCubit.get(context).acceptUser(
                      //       jopid: widget.jopModel!.jopid!,
                      //       userUid: widget.userModel!,
                      //     );
                      //     if (state is AcceptUserSuccessState) {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           backgroundColor: Colors.green,
                      //           content: Text('User Accepted'),
                      //         ),
                      //       );
                      //     }
                      //   },
                      // ),
                  MaterialButton(
                        onPressed: () {
                          JopCubit.get(context).acceptUser(
                            jopid: widget.jopModel!.jopid!,
                            userUid: widget.userModel!,
                          );
                          if (state is AcceptUserSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('User Accepted'),
                              ),
                            );
                          }
                        },
                        color: greenColor,
                        height: 40,
                    minWidth: MediaQuery.of(context).size.width/3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Accept',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          JopCubit.get(context).rejectUser(
                            jopid: widget.jopModel!.jopid!,
                            userUid: widget.userModel!,
                          );
                          if (state is RejectUserSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('User Rejected'),
                              ),
                            );
                          }
                        },
                        color: Colors.red,
                        height: 40,
                        minWidth: MediaQuery.of(context).size.width/3,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Reject',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
