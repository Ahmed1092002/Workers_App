import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/SharedWidget/title_of_componant_row.dart';
import 'package:untitled10/company/blocs/JopCubit/jop_cubit.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/views/details_jop_and_applyed_screan.dart';
import 'package:untitled10/user/widget/job_container.dart';

import '../../utils/navigator.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool isSavedAllJobs = false;
  bool isSavedAllWorkingJobs = false;
  bool isSavedAllJobsField = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JopCubit()..GetAlNewlJops(
        isSaved: ( isSelected){
          setState(() {
            isSavedAllJobs = isSelected;
          });
        }
      )..getJobOfWorkingField(
        isSaved: ( isSelected){
          setState(() {
            isSavedAllWorkingJobs = isSelected;
          });
        }
      )..getJobOfMyJobField(
        isSaved: ( isSelected){
          setState(() {
            isSavedAllJobsField = isSelected;
          });
        }
      ),
      child: BlocConsumer<JopCubit, JopState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = JopCubit.get(context);


          return ListView(
            children: [
              TitleOfComponantRow(
                title: 'New Jobs',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
                width: MediaQuery.of(context).size.width,

                child:cubit.jops.isEmpty ? Center(
                    child: Text(
                      'No Jops Yet',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                    : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            navigateToScreen(
                                context,
                                DetailsJopAndApplyedScrean(
                                  jops: cubit.jops[index],
                                  isSaved: isSavedAllJobs,
                                ));
                          },
                          child: JobContainer(
                            companyLogo: cubit.jops[index].companyImageUrl,
                            title: cubit.jops[index].title,
                            companyName: cubit.jops[index].companyname,
                            salary: cubit.jops[index].Salary,
                            experience: cubit.jops[index].Experience,
                            jobType: cubit.jops[index].jopType,
                            level: cubit.jops[index].jobLevel,
                            location: cubit.jops[index].location,
                            jobShift: cubit.jops[index].jobShift,
                            Country: cubit.jops[index].country,
                            isSaved: isSavedAllJobs,
                            onSave: ( isSelected) {
                              setState(() {
                                isSavedAllJobs = isSelected;
                              });
                              print (isSelected);
                              if(isSelected){
                                cubit.saveJop(jop: cubit.jops[index]);
                              }else{
                                cubit.unSaveJop(jopid: cubit.jops[index].jopid!);
                              }
                            },

                          )

                      ),
                    );
                  },
                  itemCount: cubit.jops.length,
                ),
              ),
              TitleOfComponantRow(
                title: 'Jobs Of Your Working Field',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
                width: MediaQuery.of(context).size.width,

                child:cubit.workingFieldJobs.isEmpty ? Center(
                    child: Text(
                      'No Jops Yet',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                    : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            navigateToScreen(
                                context,
                                DetailsJopAndApplyedScrean(
                                  jops: cubit.workingFieldJobs[index],
                                  isSaved: isSavedAllJobs,
                                ));
                          },
                          child: JobContainer(
                            companyLogo: cubit.workingFieldJobs[index].companyImageUrl,
                            title: cubit.workingFieldJobs[index].title,
                            companyName: cubit.workingFieldJobs[index].companyname,
                            salary: cubit.workingFieldJobs[index].Salary,
                            experience: cubit.workingFieldJobs[index].Experience,
                            jobType: cubit.workingFieldJobs[index].jopType,
                            level: cubit.workingFieldJobs[index].jobLevel,
                            location: cubit.workingFieldJobs[index].location,
                            jobShift: cubit.workingFieldJobs[index].jobShift,
                            Country: cubit.workingFieldJobs[index].country,
                            isSaved: isSavedAllWorkingJobs,
                            onSave: ( isSelected) {
                              setState(() {
                                isSavedAllWorkingJobs = isSelected;
                              });
                              print (isSelected);
                              if(isSelected){
                                cubit.saveJop(jop: cubit.jops[index]);
                              }else{
                                cubit.unSaveJop(jopid: cubit.jops[index].jopid!);
                              }
                            },

                          )

                      ),
                    );
                  },
                  itemCount: cubit.workingFieldJobs.length,
                ),
              ),
              TitleOfComponantRow(
                title: 'Jobs Of Your Job Field',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
                width: MediaQuery.of(context).size.width,

                child:cubit.jobsFields.isEmpty ? Center(
                    child: Text(
                      'No Jops Yet',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                    : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            navigateToScreen(
                                context,
                                DetailsJopAndApplyedScrean(
                                  jops: cubit.jops[index],
                                  isSaved: isSavedAllJobs,
                                ));
                          },
                          child: JobContainer(
                            companyLogo: cubit.jobsFields[index].companyImageUrl,
                            title: cubit.jobsFields[index].title,
                            companyName: cubit.jobsFields[index].companyname,
                            salary: cubit.jobsFields[index].Salary,
                            experience: cubit.jobsFields[index].Experience,
                            jobType: cubit.jobsFields[index].jopType,
                            level: cubit.jobsFields[index].jobLevel,
                            location: cubit.jobsFields[index].location,
                            jobShift: cubit.jobsFields[index].jobShift,
                            Country: cubit.jobsFields[index].country,
                            isSaved: isSavedAllJobsField,
                            onSave: ( isSelected) {
                              setState(() {
                                isSavedAllJobsField = isSelected;
                              });
                              print (isSelected);
                              if(isSelected){
                                cubit.saveJop(jop: cubit.jops[index]);
                              }else{
                                cubit.unSaveJop(jopid: cubit.jops[index].jopid!);
                              }
                            },

                          )

                      ),
                    );
                  },
                  itemCount: cubit.jobsFields.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
