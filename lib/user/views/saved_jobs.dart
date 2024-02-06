import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../company/blocs/JopCubit/jop_cubit.dart';
import '../../src/app_root.dart';
import '../widget/job_container.dart';

class SavedJobs extends StatefulWidget {
  const SavedJobs({Key? key}) : super(key: key);

  @override
  _SavedJobsState createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      JopCubit()
        ..getSavedJops(
          (p0) => setState(() {
            isSaved = p0;
          }),
        ),
      child:  Scaffold(
        appBar: AppBar(
          title: Text('Saved Jobs'),
          centerTitle: true,
          backgroundColor: backgroundColor,
          titleTextStyle: TextStyle(
            color: greenColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: greenColor, //change your color here
          ),
        ),
        body: BlocConsumer<JopCubit, JopState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = JopCubit.get(context);

            if (cubit.jops.isEmpty) {
              return Center(
                child: Text(
                  'No Jops saved Yet',
                  style: TextStyle(
                    color: greenColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }


            return Column(
              children: [
                Text(
                  'Jobs Saved :${cubit.jops.length}',
                  style: TextStyle(
                    color: greenColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,

                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
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
                            isSaved: isSaved,
                            onSave: ( isSelected) {
                              setState(() {
                                isSaved = isSelected;
                              });
                              print (isSelected);
                              if(isSelected){
                                cubit.saveJop(jop: cubit.jops[index]);
                              }else{
                                cubit.unSaveJop(jopid: cubit.jops[index].jopid!);
                                setState(() {
                                  cubit.jops.removeAt(index);
                                });
                                cubit.getSavedJops((p0) => setState(() {
                                  isSaved = p0;
                                }));
                              }
                            },

                          ),
                        );
                      },
                      itemCount: cubit.jops.length),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
