import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:untitled10/SharedWidget/check_out_screan_text_form_field.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/company/blocs/JopCubit/jop_cubit.dart';
import 'package:untitled10/company/views/main_screan.dart';
import 'package:untitled10/data/company/jop_model.dart';
import 'package:untitled10/main.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/navigator.dart';

class AddNewJopContainer extends StatelessWidget {
  String title;
  JopsModel? jop;
   AddNewJopContainer({
    super.key,
    required this.title,
    this.jop,
  });
  TextEditingController? jopTitlecontroller = TextEditingController();
  TextEditingController? jopDescriptioncontroller = TextEditingController();
  TextEditingController? jopLocationcontroller = TextEditingController();
  TextEditingController? jopSalarycontroller = TextEditingController();
  TextEditingController? jopRequirementscontroller = TextEditingController();
  TextEditingController? jopSkillscontroller = TextEditingController();
  TextEditingController? jopExperiencecontroller = TextEditingController();
  TextEditingController? jopTypecontroller = TextEditingController();
  TextEditingController? jopFieldcontroller = TextEditingController();
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
    if (title == 'Edit Jop') {
      jopTitlecontroller!.text = jop!.title!;
      jopDescriptioncontroller!.text = jop!.description!;
      jopLocationcontroller!.text = jop!.location!;
      jopSalarycontroller!.text = jop!.Salary!.toString();
      jopRequirementscontroller!.text = jop!.Requirements!;
      jopSkillscontroller!.text = jop!.Skills!;
      jopExperiencecontroller!.text = jop!.Experience!;
      jopTypecontroller!.text = jop!.jopType!;
      jopFieldcontroller!.text = jop!.jopField!;
    }
    return Scaffold(
  appBar: AppBar(
          backgroundColor: greenColor,
          title: Text(title),
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




                CheckOutScreanTextFormField(
                  hint: 'Job Title',
                  icon: Icons.title,
                  controller: jopTitlecontroller,


                )
                ,

                CheckOutScreanTextFormField(
                  hint: 'Job Description',
                  icon: Icons.description,
                  controller: jopDescriptioncontroller,


                ),

                CheckOutScreanTextFormField(
                  hint: 'Job Location',
                  icon: Icons.location_on,
controller: jopLocationcontroller,

                ),

                CheckOutScreanTextFormField(
                  hint: 'Job Salary',
                  icon: Icons.attach_money,
controller: jopSalarycontroller,


                ),


                CheckOutScreanTextFormField(
                  hint: 'Job Requirements',
                  icon: Icons.list_alt,
controller: jopRequirementscontroller,

                ),

                CheckOutScreanTextFormField(
                  hint: 'Job Skills',
                  icon: Icons.list_alt,
controller: jopSkillscontroller,

                ),

                CheckOutScreanTextFormField(
                  hint: 'Jop Experience',
                  icon: Icons.list_alt,
controller: jopExperiencecontroller,


                ),
                CheckOutScreanTextFormField(
hint: 'Jop Type',
                  icon: Icons.list_alt,
controller: jopTypecontroller,

                ),
                CheckOutScreanTextFormField(
                  hint: 'Jop Field',
                  icon: Icons.list_alt,
controller: jopFieldcontroller,

                  ),
                if (state is AddJopLoadingState || state is AddjopJopToCompanyLoadingState)
                  Center(
                    child: CircularProgressIndicator(
                      color: greenColor,
                    ),
                  )
                else
                CustomButton(
                  buttonName: 'Add New Jop',
                  onPressed: () async {
        if (title == 'Add New Jop')
          {
            cubit.addJopToCompany(
              jopImage: box.get('image'),
              JopField: jopFieldcontroller!.text ,


              jopTitle: jopTitlecontroller!.text,
              jopDescription: jopDescriptioncontroller!.text,
              jopLocation: jopLocationcontroller!.text,
              jopSalary: int.parse(jopSalarycontroller!.text),
              jopRequirements: jopRequirementscontroller!.text,
              jopSkills: jopSkillscontroller!.text,
              jopExperience: jopExperiencecontroller!.text,
              jopType: jopTypecontroller!.text,
            );
            Future.delayed(Duration(seconds: 2)).whenComplete(() =>   navigateToScreenAndExit(context, CompanyMainScrean()));


          }else {

            cubit.editJop(

              jopTitle: jopTitlecontroller!.text,
              jopDescription: jopDescriptioncontroller!.text,
              jopLocation: jopLocationcontroller!.text,
              jopSalary: int.parse(jopSalarycontroller!.text),
              jopRequirements: jopRequirementscontroller!.text,
              jopSkills: jopSkillscontroller!.text,
              jopExperience: jopExperiencecontroller!.text,
              jopType: jopTypecontroller!.text,
              JopField: jopFieldcontroller!.text,
              jopid: jop!.jopid!,
              jopImage: box.get('image'),
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
