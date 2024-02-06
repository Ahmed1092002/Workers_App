import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/user/views/details_jop_and_applyed_screan.dart';
import 'package:untitled10/user/widget/job_container.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../SharedWidget/NewJopContainer.dart';
import '../../company/blocs/JopCubit/jop_cubit.dart';
import '../../src/app_root.dart';

class ApplyedJops extends StatefulWidget {
  const ApplyedJops({Key? key}) : super(key: key);

  @override
  State<ApplyedJops> createState() => _ApplyedJopsState();
}

class _ApplyedJopsState extends State<ApplyedJops> {
  bool isApplied = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      JopCubit()
        ..getAllApplyedJops(
          isApplyed: (bool){
            setState(() {
              isApplied = bool;
              print('isApplied $isApplied');
              print('bool $bool');
            });
          },

        ),
      child:  Scaffold(
            appBar: AppBar(
              title: Text('Applyed Jops'),
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
                      'No Jops Yet',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                if (state is GetAllApplyedJopsLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: greenColor,
                    ),
                  );
                }


                return Column(
                  children: [
                    Text(
                      'Jops Applied :${cubit.jops.length}',
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
                                title: cubit.jops[index].title,
                                companyLogo: cubit.jops[index].companyImageUrl,
                                companyName: cubit.jops[index].companyname,
                                Country: cubit.jops[index].country,
                                jobShift: cubit.jops[index].jobShift,
                                location: cubit.jops[index].location,
                                level: cubit.jops[index].jobLevel,
                                jobType: cubit.jops[index].jopType,
                                experience:   cubit.jops[index].Experience,
                                salary: cubit.jops[index].Salary,
                                isSaved: cubit.jops[index].isSaved,

                                isApplied: cubit.jops[index].isApplied,

                                screenName: 'Applyed Jops',




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

