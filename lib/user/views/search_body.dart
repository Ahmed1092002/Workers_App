import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/views/result_search_widget.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../SharedWidget/working_feilds_dropdown_button_form_field.dart';
import '../../company/blocs/JopCubit/jop_cubit.dart';
import '../../main.dart';
import '../../utils/consatants.dart';

class SearchBody extends StatefulWidget {
   SearchBody({Key? key}) : super(key: key);

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  TextEditingController jopTitleController = TextEditingController();

  TextEditingController jopLocationController = TextEditingController();

  TextEditingController jopTypeController = TextEditingController();

  TextEditingController jopSalaryController = TextEditingController();

  TextEditingController jopFieldController = TextEditingController();

TextEditingController jopExperienceController = TextEditingController();

var box = Hive.box(boxName);
  var userType ;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     userType =  box.get('userType');

}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: BlocProvider(
  create: (context) => JopCubit(),
  child: BlocConsumer<JopCubit, JopState>(
  listener: (context, state) {

    // TODO: implement listener
    if (state is SearchJopFilterSuccessState) {
      navigateToScreen(context, ResultSearchWidget(
        jops: JopCubit.get(context).jops,
        title: 'Result Search',
        userType: userType,
      ));

    }
  },
  builder: (context, state) {

    return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).viewInsets.bottom == 0
              ? MediaQuery.of(context).size.height / 1.35
              : MediaQuery.of(context).size.height / 0.8,

          decoration: BoxDecoration(
           border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: jopTitleController,
                    cursorColor: greenColor,
                    style: TextStyle(color: greenColor),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: greenColor),
                      ),
                      labelText: 'Jop Title',
                      hintText: 'Jop Title',
                      labelStyle: TextStyle(color: greenColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: greenColor),
                      ),
                      border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: greenColor),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: jopLocationController,
                    cursorColor: greenColor,
                    style: TextStyle(color: greenColor),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: greenColor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: greenColor),
                      ),
                      labelText: 'Jop Location',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: greenColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),

                        borderSide: BorderSide(color: greenColor),

                      ),
                    ),
                  ),
                ),
                Expanded(child:    getDropDownButtonFormField(
                  hint: 'Jop Type',
                  icon: Ionicons.briefcase_outline,
                  context: context,
                  job: jobType,
                  Function: (  value){
                    jopTypeController.text = value;
                  },
                ),),
                Expanded(child:    getDropDownButtonFormField(
                  hint: 'Jop Field',
                  context: context,
                  icon: Ionicons.briefcase_outline,
                  job:Jobs,
                  Function: (  value){
                    jopFieldController.text = value;
                  },
                ),),

                Expanded(child:    getDropDownButtonFormField(
                  hint: 'Jop Salary',
                  icon: Ionicons.briefcase_outline,                      job: jobSalary,
                  context: context,
                  Function: (  value){
                    jopSalaryController.text = value;
                  },
                ),),
                Expanded(child:    getDropDownButtonFormField(
                  hint: 'Jop Experience',
                  icon: Ionicons.briefcase_outline,                      job: jobExperience,
                  context: context,
                  Function: (  value){
                    jopExperienceController.text = value;
                  },
                ),),




                getDropDownButtonFormField(
                  hint: 'Jop Shift',
                  icon: Ionicons.briefcase_outline,                  job: jobExperience,
                  context: context,
                  Function: (  value){
                    jopExperienceController.text = value;
                  },
                ),



//                 CustomButton(
//                   buttonName: 'Search',
//
//                   onPressed: () async {
//                     String salaryText = jopSalaryController.text;
//
// print (salaryText);
// print (jopSalaryController.text);
//
//                     print (userType);
//                     JopCubit.get(context).searchJopFilter(
//                       jopTitle: jopTitleController.text,
//                       jopLocation: jopLocationController.text,
//                       jopType: jopTypeController.text,
//                       jopSalary: jopSalaryController.text,
//                       userType: userType,
//
//                       jopExperience: jopExperienceController.text,
//
//                       jopField: jopFieldController.text,
//                     );
//
//                   },
//                 ),
                MaterialButton(
                  onPressed: () async {
                    String salaryText = jopSalaryController.text;

                    print (salaryText);
                    print (jopSalaryController.text);

                    print (userType);
                    JopCubit.get(context).searchJopFilter(
                      jopTitle: jopTitleController.text,
                      jopLocation: jopLocationController.text,
                      jopType: jopTypeController.text,
                      jopSalary: jopSalaryController.text,
                      userType: userType,

                      jopExperience: jopExperienceController.text,

                      jopField: jopFieldController.text,
                    );

                  },
                  color: greenColor,
                  shape: StadiumBorder(),

                  height: 50,
                  minWidth:100,
                  child: Text('Search',style: TextStyle(color: Colors.white,fontSize: 20),),
                ),


              ],
            ),
          ),
        );
  },
),
),
      ),
    );
  }
}
