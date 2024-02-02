import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:untitled10/SharedWidget/check_out_screan_text_form_field.dart';
import 'package:untitled10/SharedWidget/circle_avatar_image.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/SharedWidget/working_feilds_dropdown_button_form_field.dart';
import 'package:untitled10/company/blocs/JopCubit/jop_cubit.dart';
import 'package:untitled10/company/views/main_screan.dart';
import 'package:untitled10/data/company/jop_model.dart';
import 'package:untitled10/main.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/consatants.dart';
import 'package:untitled10/utils/navigator.dart';

class AddNewJopContainer extends StatefulWidget {
  String title;
  JopsModel? jop;
   AddNewJopContainer({
    super.key,
    required this.title,
    this.jop,
  });

  @override
  State<AddNewJopContainer> createState() => _AddNewJopContainerState();
}

class _AddNewJopContainerState extends State<AddNewJopContainer> {
  TextEditingController? jopTitlecontroller = TextEditingController();

  TextEditingController? jopDescriptioncontroller =TextEditingController();

  TextEditingController? jopLocationcontroller = TextEditingController();

  String? jopSalarycontroller = '';

  String? jopExperiencecontroller = '';

  List<String>? jopSkills = [];

  String? jopTypecontroller = '';

  String? jopFieldcontroller = '';

  String? jobShiftS = '';

  String?jobLevelS = '';

  Widget skillsWidget(List<String> skill) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        children: [
          ...skill.map((e) => Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(color: greenColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(e),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                   setState(() {
                     skill.remove(e);
                   });
                  },
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  var box = Hive.box(boxName);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => JopCubit(),
  child: BlocConsumer<JopCubit, JopState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    var cubit = JopCubit.get(context);
    if (widget.title == 'Edit Jop') {
      jopTitlecontroller!.text= widget.jop!.title!;
      jopDescriptioncontroller!.text= widget.jop!.description!;
      jopLocationcontroller!.text= widget.jop!.location!;
      jopSalarycontroller= widget.jop!.Salary!;
      jopExperiencecontroller = widget.jop!.Experience!;
      jopTypecontroller = widget.jop!.jopType!;
      jopFieldcontroller= widget.jop!.jopField!;
      jopSkills = widget.jop!.Skills;
      jobShiftS = widget.jop!.jobShift!;
      jobLevelS = widget.jop!.jobLevel!;




    }
    return Scaffold(
  appBar: AppBar(
          backgroundColor: greenColor,
          title: Text(widget.title),
          centerTitle: true,
    iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
    titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),



        ),

      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),

                CheckOutScreanTextFormField(
                  hint: 'Job Title',
                  icon: Icons.title,
                  controller: jopTitlecontroller,


                ),

                  Row(
                    children: [
                      Expanded(child: getDropDownButtonFormField(
                        job:jobType ,
icon: Icons.work,
                        context: context,
                        hint: jopTypecontroller == null || jopTypecontroller == '' ? 'Job Type' : jopTypecontroller,
                        jobString: jopTypecontroller,

                        Function: (  value){
                          jopTypecontroller = value;
                        },
                      ),),
                      Expanded(child:     getDropDownButtonFormField(
                        job: Jobs,
                        hint: jopFieldcontroller == null || jopFieldcontroller == '' ? 'Job Field' : jopFieldcontroller
                        ,context: context,
                        jobString: jopFieldcontroller,
                        icon: Icons.work,
                        Function: (  value){
                          jopFieldcontroller = value;
                        },

                      ),),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: getDropDownButtonFormField(
                        job: jobLevel,
                        hint:jobLevelS == null || jobLevelS == '' ? 'Job Level' : jobLevelS,
                          context: context,
                        icon: Icons.work,
                        jobString: jobLevelS,
                        Function: (  value){
                          jobLevelS = value;
                        }
                      ),),
                      Expanded(child:     getDropDownButtonFormField(
                        job: jobShift,
                        hint: jobShiftS == null || jobShiftS == '' ? 'Job Shift' : jobShiftS,
                        icon: Icons.work,
                        context: context,
                        jobString: jobShiftS,
                        Function: (  value){
                          jobShiftS = value;},
                      ),),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: getDropDownButtonFormField(
                        job: jobExperience,
                        hint: jopExperiencecontroller == null || jopExperiencecontroller == '' ? 'Job Experience' : jopExperiencecontroller,
                        icon: Icons.work,
                        context: context,
                        jobString: jopExperiencecontroller,
                        Function: (  value){
                          jopExperiencecontroller = value;},
                      ),),
                      Expanded(child:     getDropDownButtonFormField(
                        job: jobSalary,
                        hint: jopSalarycontroller == null || jopSalarycontroller == '' ? 'Job Salary' : jopSalarycontroller,
                        context: context,
                        icon: Icons.money,
                        jobString: jopSalarycontroller,
                        Function: (  value){
                          jopSalarycontroller = value;},
                      ),),

                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: getDropDownButtonFormField(
                          job: jobSkills,
                          jobString: ' job skills',
                          context: context,
                          icon: Icons.work,

                          hint: 'Job Skills',
                          Function: (  value){
setState(() {
  jopSkills!.add(value);});
                          },
                        ) ,
                      ),
                      Expanded(
                      child:  CheckOutScreanTextFormField(
                          hint: 'Job Location',
                          icon: Icons.location_on,

                          controller: jopLocationcontroller,

                        ),
                      )
                    ],
                  ),
                skillsWidget(jopSkills!),




                CheckOutScreanTextFormField(
                  hint: 'Job Description',
                  icon: Icons.description,
                  controller: jopDescriptioncontroller,

                ),


                if (state is AddJopLoadingState || state is AddjopJopToCompanyLoadingState)
                  Center(
                    child: CircularProgressIndicator(
                      color: greenColor,
                    ),
                  )
                else
                CustomButton(
                  buttonName: widget.title == 'Add New Jop' ? 'Add Jop' : 'Edit Jop',
                  onPressed: () async {
        if (widget.title == 'Add New Jop')
          {
            cubit.addJopToCompany(
              JopField: jopFieldcontroller! ,
              jobShift: jobShiftS!,
        jobLevel: jobLevelS!,



              jopTitle: jopTitlecontroller!.text,
              jopDescription: jopDescriptioncontroller!.text,
              jopLocation: jopLocationcontroller!.text,
              jopSalary: jopSalarycontroller!,
              jopSkills: jopSkills!,
              jopExperience: jopExperiencecontroller!,
              jopType: jopTypecontroller!,
            );
            Future.delayed(Duration(seconds: 2)).whenComplete(() =>   navigateToScreenAndExit(context, CompanyMainScrean()));


          }
        else {

            cubit.editJop(

              jopTitle: jopTitlecontroller!.text,
              jopDescription: jopDescriptioncontroller!.text,
              jopLocation: jopLocationcontroller!.text,
              jopSalary: jopSalarycontroller!,
              jopSkills: jopSkills!,
              jobLevel: jobLevelS!,


              jopShift: widget.jop!.jobShift!,
              jopExperience: jopExperiencecontroller!,
              jopType: jopTypecontroller!,
              JopField: jopFieldcontroller!,
              jopid: widget.jop!.jopid!,
            );
            Future.delayed(Duration(seconds: 2)).whenComplete(() =>   navigateToScreenAndExit(context, CompanyMainScrean()));
        }



                  },
                )


              ],
            ),
          ),
        ),
    );
  },
),
);
  }
}
