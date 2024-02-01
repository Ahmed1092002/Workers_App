import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/company/blocs/JopCubit/jop_cubit.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/views/details_jop_and_applyed_screan.dart';
import 'package:untitled10/user/widget/CategotyContainer.dart';
import 'package:untitled10/SharedWidget/NewJopContainer.dart';
import 'package:untitled10/SharedWidget/title_of_componant_row.dart';

import '../../utils/navigator.dart';


class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => JopCubit()..GetAllJops(),
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
      child: Column(
        children: [
          TitleOfComponantRow(
            title: 'Catiogries',
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,

                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CategoriesContainer(
                      name: 'Best Seller',

                    ),
                  );
                },
                itemCount: 5),
          ),
          TitleOfComponantRow(
            title: 'New Jobs',
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.63,

            child: ListView.builder(
              shrinkWrap: true,

                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        navigateToScreen(context, DetailsJopAndApplyedScrean(
                          jops: cubit.jops[index],
                        ));
                      },
                      child: NewJopContainer(
                      jopField: cubit.jops[index].jopField,
                        jopType: cubit.jops[index].jopType,
                        companyName: cubit.jops[index].companyname,
                      location: cubit.jops[index].location,
                        salary: cubit.jops[index].Salary,
                        experience: cubit.jops[index].Experience,
                        name: cubit.jops[index].title,

                        //todo;fix this


                      ),
                    ),
                  );
                },
                itemCount: cubit.jops.length),
          ),


        ],
      ),


    );
  },
),
);
  }
}
