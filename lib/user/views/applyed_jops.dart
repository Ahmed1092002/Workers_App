import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../SharedWidget/NewJopContainer.dart';
import '../../company/blocs/JopCubit/jop_cubit.dart';
import '../../src/app_root.dart';

class ApplyedJops extends StatefulWidget {
  const ApplyedJops({Key? key}) : super(key: key);

  @override
  State<ApplyedJops> createState() => _ApplyedJopsState();
}

class _ApplyedJopsState extends State<ApplyedJops> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      JopCubit()
        ..getAllApplyedJops(),
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
                              child: NewJopContainer(
                                jopField: cubit.jops[index].jopField,
                                salary: cubit.jops[index].Salary,
                                jopType: cubit.jops[index].jopType,
                                imageUrl: cubit.jops[index].imageUrl,
                                companyName: cubit.jops[index].companyname,
                                location: cubit.jops[index].location,
                                experience: cubit.jops[index].Experience,
                                companyLogo: cubit.jops[index].imageUrl,
                                name: cubit.jops[index].title,


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

