import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/user/views/main_screan.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../company/blocs/JopCubit/jop_cubit.dart';
import '../../data/company/jop_model.dart';
import '../../src/app_root.dart';

class DetailsJopAndApplyedScrean extends StatelessWidget {
  JopsModel? jops;

  DetailsJopAndApplyedScrean({Key? key, this.jops}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Jop'),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => JopCubit(),
          child: BlocConsumer<JopCubit, JopState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: greenColor,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: greenColor,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(jops!.imageUrl!),
                            ),
                          ),

                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (jops!.companyname != null &&
                                  jops!.companyname != 'null')
                                Text("Company name :\n${jops!.companyname!}"),
                              Text('Company email :\n${jops!.userEmail!}'),


                            ],
                          ),

                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Company Infomation'),
                          Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                )
                            ),
                            child: Text('${jops!.companyInfo}'),

                          ),
                          Text('Jop Name'),
                          Container(
                            width: double.infinity,

                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(10),
                             border: Border.all(
                               color: greenColor,
                               width: 2,
                             )
                           ),
                            child: Text('${jops!.title}'),

                          ),
                          Text('Jop Type '),
                          Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                )
                            ),
                            child: Text('${jops!.jopType}'),

                          ),
                          Text('Jop Field '),
                          Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                )
                            ),
                            child: Text('${jops!.jopField}'),

                          ),
                          Text('Experience '),
                          Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                )
                            ),
                            child: Text('${jops!.Experience}'),

                          ),
                          Text('Salary '),
                          Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                )
                            ),
                            child: Text('${jops!.Salary}'),

                          ),
                          Text('Location '),
                          Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                )
                            ),
                            child: Text('${jops!.location}'),

                          ),
                          Text('Description '),
                          Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                )
                            ),
                            child: Text('${jops!.description}'),

                          ),
                        ],
                      ),
                    ),
                    Divider(),


                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        buttonName: 'Applyed',
                        onPressed: () {
                                        JopCubit.get(context).applyingjop(jopid: jops!.jopid!,
                        companyUid: jops!.companyUid!,).whenComplete(() {
                          if (JopCubit.get(context).applyingjop == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Applyed'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            navigateToScreen(context, MainScrean());


                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('This Jop is Applyed'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }


                                        });
                        },
                      ),
                    )


                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
