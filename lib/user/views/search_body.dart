import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/views/result_search_widget.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../SharedWidget/working_feilds_dropdown_button_form_field.dart';
import '../../company/blocs/JopCubit/jop_cubit.dart';
import '../../main.dart';
import '../../utils/consatants.dart';

class SearchBody extends StatelessWidget {
   SearchBody({Key? key}) : super(key: key);
  TextEditingController jopTitleController = TextEditingController();
  TextEditingController jopLocationController = TextEditingController();
  TextEditingController jopTypeController = TextEditingController();
  TextEditingController jopSalaryController = TextEditingController();
  TextEditingController jopFieldController = TextEditingController();
TextEditingController jopExperienceController = TextEditingController();
var box = Hive.box(boxName);



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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: jopTitleController,
                  decoration: InputDecoration(
                    labelText: 'Jop Title',
                    labelStyle: TextStyle(color: greenColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: greenColor),
                    ),
                  ),
                ),
                TextFormField(
                  controller: jopLocationController,

                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: greenColor),

                    labelText: 'Jop Location',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: greenColor),

                    ),
                  ),
                ),


          getDropDownButtonFormField(
            hint: 'Jop Type',
            icon: Icons.work,
            job: jobType,
            Function: (  value){
              jopTypeController.text = value;
            },
          ),
                getDropDownButtonFormField(
            hint: 'Jop Field',
            icon: Icons.work,
            job:Jobs,
            Function: (  value){
              jopFieldController.text = value;
            },
          ),
                getDropDownButtonFormField(
                  hint: 'Jop Salary',
                  icon: Icons.work,
                  job: jobSalary,
                  Function: (  value){
                    jopSalaryController.text = value;
                  },
                ),
                getDropDownButtonFormField(
                  hint: 'Jop Experience',
                  icon: Icons.work,
                  job: jobExperience,
                  Function: (  value){
                    jopExperienceController.text = value;
                  },
                ),




                CustomButton(
                  buttonName: 'Search',
                  onPressed: () async {
                    String salaryText = jopSalaryController.text;
                    int? jopSalary;

                    if (salaryText.isNotEmpty && int.tryParse(salaryText) != null) {
                      jopSalary = int.parse(salaryText);
                    }
                    var userType = await box.get('userType');
                    if (userType == 'company') {
                     JopCubit.get(context).searchMyJopsFilter(
                        jopTitle: jopTitleController.text,
                        jopLocation: jopLocationController.text,
                        jopType: jopTypeController.text,
                        jopSalary: jopSalary,
                        jopExperience: jopExperienceController.text,
                        jopField: jopFieldController.text,
                      ).whenComplete(() {
                        navigateToScreen(context, ResultSearchWidget(
                          jops: JopCubit.get(context).jops,
                        ));
                      });
                    }else{

                      JopCubit.get(context).searchJopFilter(
                        jopTitle: jopTitleController.text,
                        jopLocation: jopLocationController.text,
                        jopType: jopTypeController.text,
                        jopSalary: jopSalary,
                        jopExperience: jopExperienceController.text,
                        jopField: jopFieldController.text,


                      ).whenComplete(() {
                        navigateToScreen(context, ResultSearchWidget(
                          jops: JopCubit.get(context).jops,
                        ));
                      });
                    }

                  },
                )
        
        
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
