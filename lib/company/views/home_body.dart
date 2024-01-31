import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/SharedWidget/NewJopContainer.dart';
import 'package:untitled10/SharedWidget/title_of_componant_row.dart';
import 'package:untitled10/company/blocs/JopCubit/jop_cubit.dart';
import 'package:untitled10/company/views/jop_details_screan.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/widget/CategotyContainer.dart';
import 'package:untitled10/utils/navigator.dart';




class CompanyHomeBody extends StatefulWidget {
  const CompanyHomeBody({Key? key}) : super(key: key);

  @override
  _CompanyHomeBodyState createState() => _CompanyHomeBodyState();
}

class _CompanyHomeBodyState extends State<CompanyHomeBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => JopCubit()..getAllJopsOfComapny(),
  child: BlocConsumer<JopCubit, JopState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    var cubit = JopCubit.get(context);
    if (cubit.jops.isEmpty) {
      return Center(child: Text('No Jops Yet',style: TextStyle(
        color: greenColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),));
    }


    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(

          children: [

            TitleOfComponantRow(
              title: 'Your Jops',
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.79,

              child: ConditionalBuilder(condition: cubit.jops.isNotEmpty,
                  builder: (_){

                return  ListView.builder(


                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await cubit.getAllJopsOfComapny();
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(

                          onTap: () {

                          navigateToScreen(context, JopDetailsScrean(
                            jopModel: cubit.jops[index],

                          ));
                          },
                          child: NewJopContainer(
                            name: cubit.jops[index].title,
                            jopType: cubit.jops[index].jopType!.trim(),
                            companyLogo: cubit.jops[index].imageUrl,
                            experience: cubit.jops[index].Experience,
                            location: cubit.jops[index].location,
                            salary: cubit.jops[index].Salary,
                          jopField: cubit.jops[index].jopField,

                            imageUrl: cubit.jops[index].imageUrl,







                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: cubit.jops.length,
                );
                  },
                  fallback: (context) => Center(child: CircularProgressIndicator(
                    color: greenColor,

                  )),



            ),
            ),
          ],
        ),
      ),


    );
  },
),
);
  }
}
