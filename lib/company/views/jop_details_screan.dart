import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/company/blocs/JopCubit/jop_cubit.dart';
import 'package:untitled10/company/views/add_new_jop_container.dart';
import 'package:untitled10/company/widget/__jop_details_screan_state_column.dart';
import 'package:untitled10/company/widget/applyed_user_container.dart';
import 'package:untitled10/data/company/jop_model.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../data/company/company_model.dart';
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
int numOfApplyedUsers = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var keys = widget.jopModel!.toJson().keys.where((element) => element!='jopid'&&element!='imageUrl'&&element!='companyname'&& element!='companyUid'&& element!='userEmail'&& element!='companyInfo').toList();
    var values = widget.jopModel!.toJson().values.where((value) => value != widget.jopModel!.jopid&& value != widget.jopModel!.imageUrl&& value!=widget.jopModel!.companyname&& value!=widget.jopModel!.companyUid&& value!=widget.jopModel!.userEmail&& value!=widget.jopModel!.companyInfo).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Jop Details '),

        actions: [
          IconButton(
            onPressed: () {
              navigateToScreen(context, AddNewJopContainer(
                title: 'Edit Jop',
                jop: widget.jopModel,
              ));
            },
            icon: Icon(Icons.edit),
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
            icon: Icon(Icons.delete),
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),

                itemCount: keys.length,                itemBuilder: (context, index) {
                  return JopDetailsScreanStateColumn(
                    Title:'${keys[index]}',
                Description: '${values[index]}',
                  );
                },
              )
            ),
          ),
       BlocProvider(
  create: (context) => JopCubit()..getApplyedUsers(jopid: widget.jopModel!.jopid!),
  child: BlocConsumer<JopCubit, JopState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = JopCubit.get(context);
    if (cubit.applyedUsers!.isEmpty) {
      return Center(child: Text('No Applyed Users Yet',style: TextStyle(
        color: greenColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),));
    }else {
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
                    height: MediaQuery.of(context).size.height*0.8,
                    width: MediaQuery.of(context).size.width,

                    child:cubit.applyedUsers.isEmpty
                  ? Center(
                  child: Text('No Users Applyed yet'),
            ): ListView.builder(
                      shrinkWrap: true,

                      itemCount: cubit.applyedUsers.length ,
                      itemBuilder: (context, index) {
                        print(cubit.applyedUsers[index].name);
                        return InkWell(
                          onTap: ()async{
                            cubit.workExperience.clear();
                            cubit.education.clear();
                            cubit.skills.clear();
                            cubit.projects.clear();

                            await      JopCubit.get(context).getApplyedUserdata(uid: cubit.applyedUsers[index].id!).whenComplete(() async{
                              if (state is GetApplyedUserdataLoadingState) {
                                Center(child: CircularProgressIndicator());
                              }
                              Future.delayed(Duration(seconds: 2),() {
                                navigateToScreen(context, ApplyedUserProfieScrean(
                                  userModel: cubit.applyedUsers[index],
                                  workExperience: cubit.workExperience,
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
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.13,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: backgroundColor,
                                  border: Border.all(
                                    color: greenColor,
                                    width: 2,
                                  )
                              ),
                              child: ListTile(

                                leading:CircleAvatar(
                                  radius: 30,

                                  backgroundImage: NetworkImage(cubit.applyedUsers[index].image!),
                                ),
                                titleAlignment: ListTileTitleAlignment.titleHeight,

                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cubit.applyedUsers[index].email!),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(cubit.applyedUsers[index].address!),
                                        Text(cubit.applyedUsers[index].phone!),
                                      ],
                                    ),

                                  ],
                                ),
                                title: Text(cubit.applyedUsers[index].name!),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )

            ),
          );
  },
),
),
        ],
      ),
    );
  }
}
