import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/company/blocs/CompanyProfileCubit/company_profile_cubit.dart';
import 'package:untitled10/SharedWidget/circle_avatar_image.dart';
import 'package:untitled10/src/app_root.dart';

class CompanyProfilebody extends StatelessWidget {
   CompanyProfilebody({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => CompanyProfileCubit()..getProfileData(),
      child: BlocConsumer<CompanyProfileCubit, CompanyProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubitUser = CompanyProfileCubit.get(context).user;
          if (cubitUser == null) {
            return Center(
              child: CircularProgressIndicator(
                color: greenColor,
              ),
            );
          }
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(children: [


                CircleAvatarImage(imageUrl: cubitUser.image!),
                SizedBox(
                  width: 17,
                ),
                Text(
                  "${cubitUser.name!}",
                  style:TextStyle(
                    color: greenColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: greenColor,
                        width: 2,
                      )),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height:
                            MediaQuery.of(context).size.height * 0.05,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: greenColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text('about',style: TextStyle(color: Colors.white),)),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.52,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: cubitUser
                              .toJson()
                              .keys
                              .where((key) =>
                          key != 'id' &&
                              key != 'image' &&
                              key != 'userType' &&
                              key != 'fcmToken' &&
                              key != 'name' &&

                              key != 'gender' &&
                              key != 'jobField')
                              .length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var keys = cubitUser
                                .toJson()
                                .keys
                                .where((key) =>
                            key != 'id' &&
                                key != 'image' &&
                                key != 'userType' &&
                                key != 'fcmToken' &&
                                key != 'name' &&

                                key != 'gender' &&
                                key != 'jobField')
                                .toList();
                            var values = cubitUser
                                .toJson()
                                .values
                                .where((value) =>
                            value != cubitUser.id &&
                                value != cubitUser.image &&
                                value != cubitUser.userType &&
                                value != cubitUser.fcmToken &&
                                value != cubitUser.name &&

                                value != cubitUser.gender &&
                                value != cubitUser.jobField)
                                .toList();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

                                children: [
                                  Text('${keys[index]}', style:Theme.of(context).textTheme.bodySmall,),
                                  Flexible(child: Text('${values[index]}',style: TextStyle(color: greenColor),)),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),



                // Container(
                //   width: MediaQuery.of(context).size.width * 0.9,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //      ),
                //   child: Column(
                //     children: [
                //       SizedBox(
                //         width: 10,
                //       ),
                //       CircleAvatarImage(imageUrl: cubitUser.image!),
                //       SizedBox(
                //         width: 17,
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Text(
                //             "${cubitUser.name!}",
                //             style:Theme.of(context).textTheme.bodyLarge,
                //           ),
                //
                //         ],
                //       ),
                //       Container(
                //         width: MediaQuery.of(context).size.width * 0.9,
                //         height: MediaQuery.of(context).size.height * 0.52,
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(10),
                //             border: Border.all(
                //               color: greenColor,
                //               width: 2,
                //             )),
                //         alignment: Alignment.center,
                //         child: Column(
                //           children: [
                //             Align(
                //               alignment: Alignment.topLeft,
                //               child: Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Container(
                //                     width: MediaQuery.of(context).size.width * 0.2,
                //                     height:
                //                     MediaQuery.of(context).size.height * 0.05,
                //                     alignment: Alignment.center,
                //                   decoration: BoxDecoration(
                //                       color: greenColor,
                //                       borderRadius: BorderRadius.circular(10)),
                //                     child: Text('about',style: TextStyle(color: Colors.white),)),
                //               ),
                //             ),
                //
                //             SizedBox(
                //               width: MediaQuery.of(context).size.width * 0.9,
                //               height: MediaQuery.of(context).size.height * 0.42,
                //               child: ListView.separated(
                //                 separatorBuilder: (context, index) => Divider(),
                //                 itemCount: cubitUser
                //                     .toJson()
                //                     .keys
                //                     .where((key) =>
                //                 key != 'id' &&
                //                     key != 'image' &&
                //                     key != 'userType' &&
                //                     key != 'fcmToken' &&
                //                     key != 'name' &&
                //
                //                     key != 'gender' &&
                //                     key != 'jobField')
                //                     .length,
                //                 shrinkWrap: true,
                //                 itemBuilder: (context, index) {
                //                   var keys = cubitUser
                //                       .toJson()
                //                       .keys
                //                       .where((key) =>
                //                   key != 'id' &&
                //                       key != 'image' &&
                //                       key != 'userType' &&
                //                       key != 'fcmToken' &&
                //                       key != 'name' &&
                //
                //                       key != 'gender' &&
                //                       key != 'jobField')
                //                       .toList();
                //                   var values = cubitUser
                //                       .toJson()
                //                       .values
                //                       .where((value) =>
                //                   value != cubitUser.id &&
                //                       value != cubitUser.image &&
                //                       value != cubitUser.userType &&
                //                       value != cubitUser.fcmToken &&
                //                       value != cubitUser.name &&
                //
                //                       value != cubitUser.gender &&
                //                       value != cubitUser.jobField)
                //                       .toList();
                //                   return Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Row(
                //                       mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //
                //                       children: [
                //                         Text('${keys[index]}', style:Theme.of(context).textTheme.bodySmall,),
                //                         Flexible(child: Text('${values[index]}',style: TextStyle(color: greenColor),)),
                //                       ],
                //                     ),
                //                   );
                //                 },
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),

              ]));
        },
      ),
    );
  }
}
