import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled10/company/blocs/JopCubit/jop_cubit.dart';
import 'package:untitled10/company/views/add_new_jop_container.dart';
import 'package:untitled10/company/views/job_details_body.dart';
import 'package:untitled10/data/company/jop_model.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../src/app_root.dart';
import 'applyed_user_profie_screan.dart';

class JopDetailsScrean extends StatefulWidget {
  JopsModel? jopModel;

  JopDetailsScrean({Key? key, this.jopModel}) : super(key: key);

  @override
  _JopDetailsScreanState createState() => _JopDetailsScreanState();
}

class _JopDetailsScreanState extends State<JopDetailsScrean>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isApplyed = false;
  int numOfApplyedUsers = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Jop Details '),
        actions: [
          IconButton(
            onPressed: () {
              navigateToScreen(
                  context,
                  AddNewJopContainer(
                    title: 'Edit Jop',
                    jop: widget.jopModel,
                  ));
              print(widget.jopModel!.jopField);
              print(widget.jopModel!.Salary);
            },
            icon: Icon(Ionicons.create_outline),
          ),
          BlocProvider(
            create: (context) => JopCubit(),
            child: BlocBuilder<JopCubit, JopState>(
              builder: (context, state) {
                var cubit = JopCubit.get(context);
                return IconButton(
                  onPressed: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        titleTextStyle: TextStyle(
                          color: greenColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        title: Text(
                          'Are you sure you want to delete this Jop ?',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                cubit.deleteJop(jopid: widget.jopModel!.jopid!);
                              },
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: grayColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: greenColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                    );
                  },
                  icon: Icon(Ionicons.trash_outline),
                );
              },
            ),
          ),
        ],
        centerTitle: true,
        iconTheme: IconThemeData(
          color: greenColor, //change your color here
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: grayColor,
          labelColor: greenColor,
          unselectedLabelColor: grayColor,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          onTap: (index) {
            _tabController.animateTo(index);
          },
          indicatorPadding: EdgeInsets.all(5),
          splashBorderRadius: BorderRadius.circular(10),
          tabs: [
            Tab(
              text: 'Details',
            ),
            Tab(
              text: 'Applyed User ',
            ),
          ],
        ),
        titleTextStyle: TextStyle(
          color: greenColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          JobDetailsBody(jopModel: widget.jopModel!),
          BlocProvider(
            create: (context) =>
                JopCubit()..getApplyedUsers(jopid: widget.jopModel!.jopid!,isApplyed: (bool){
                  isApplyed=bool;
                }),
            child: BlocConsumer<JopCubit, JopState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                var cubit = JopCubit.get(context);
                if (cubit.applyedUsers.isEmpty) {
                  return Center(
                      child: Text(
                    'No Applyed Users Yet',
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ));
                } else {
                  numOfApplyedUsers = cubit.applyedUsers.length;
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Text('Users Applyed : ${cubit.applyedUsers.length}'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width,
                        child: cubit.applyedUsers.isEmpty
                            ? Center(
                                child: Text('No Users Applyed yet'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: cubit.applyedUsers.length,
                                itemBuilder: (context, index) {
                                  print(cubit.applyedUsers[index].name);
                                  return state is GetApplyedUserdataLoadingState ? Center(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: LoadingAnimationWidget.twoRotatingArc(
                                      color: greenColor,
                                      size: 100,

                                    ),
                                  )):   InkWell(
                                    onTap: () async {
                                      cubit.workExperience.clear();
                                      cubit.education.clear();
                                      cubit.skills.clear();
                                      cubit.projects.clear();

                                      await JopCubit.get(context)
                                          .getApplyedUserdata(
                                              uid:
                                                  cubit.applyedUsers[index].id!)
                                          .whenComplete(() async {
                                        if (state
                                            is GetApplyedUserdataLoadingState) {
                                          Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          navigateToScreen(
                                              context,
                                              ApplyedUserProfieScrean(
                                                userModel:
                                                    cubit.applyedUsers[index],
                                                 jopModel: widget.jopModel!,
                                                workExperience:
                                                    cubit.workExperience,
                                                education: cubit.education,
                                                skills: cubit.skills,
                                                projects: cubit.projects,
                                              ));
                                        });
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: backgroundColor,
                                            border: Border.all(
                                              color: greenColor,
                                              width: 2,
                                            )),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: backgroundColor),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 70,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: greenColor),
                                                  borderRadius:
                                                      BorderRadius.circular(10),

                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: cubit
                                                      .applyedUsers[index].image!,
                                                  fit: BoxFit.fill,
                                                  imageBuilder: (context, imageProvider) =>
                                                      Container(
                                                    width: 70,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              LoadingAnimationWidget.twoRotatingArc(
                                                        color: greenColor,
                                                        size: 100,
                                                              )),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        cubit.applyedUsers[index]
                                                            .name!,
                                                        style: TextStyle(
                                                          color: greenColor,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      if (isApplyed)
                                                      Icon(
                                                        Ionicons.checkmark_done_circle,
                                                        color: greenColor,
                                                      ),
                                                      if (isApplyed)
                                                      Text(
                                                        'Applyed',
                                                      ),

                                                    ],
                                                  ),
                                                  Text(cubit.applyedUsers[index]
                                                      .email!),
                                                  Text(cubit.applyedUsers[index]
                                                      .jobField!),
                                                ],
                                              ),
                                              Spacer(),
                                              Icon(
                                                Ionicons.chevron_forward_circle,
                                                color: greenColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      )
                    ],
                  )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
