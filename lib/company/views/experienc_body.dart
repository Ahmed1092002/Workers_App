import 'package:flutter/material.dart';
import 'package:untitled10/SharedViews/ChatScreen.dart';
import 'package:untitled10/company/views/about_and_skills_body.dart';
import 'package:untitled10/company/views/eduction_body.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/navigator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/company/company_model.dart';
import '../../data/users/education.dart';
import '../../data/users/projects.dart';
import '../../data/users/skills.dart';
import '../../data/users/work_experience.dart';

class ExperiencBody extends StatefulWidget {
  List<WorkExperience>? workExperience;
   ExperiencBody({
    super.key,
    this.workExperience,
  });

  @override
  State<ExperiencBody> createState() => _ExperiencBodyState();
}

class _ExperiencBodyState extends State<ExperiencBody> {
  @override
  Widget build(BuildContext context) {
    return widget.workExperience!.isNotEmpty ? ListView.builder(
      itemCount: widget.workExperience!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: greenColor,
                  width: 2,
                )),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("company:",style: TextStyle(
                  fontSize: 20,
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                ),),
                Text("company: ${widget.workExperience![index].company!}"),
                Divider(
                  endIndent: 10,
                  indent: 10,
                ),

                Text("position:",style: TextStyle(
                  fontSize: 20,
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                ),),
                Text("position: ${widget.workExperience![index].position!}"),
                Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                Text(" start date:",style: TextStyle(
                  fontSize: 20,
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                ),),
                Text("${widget.workExperience![index].startDate!}"),
                Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                Text(" end date:",style: TextStyle(
                  fontSize: 20,
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                ),),
                Text("${widget.workExperience![index].endDate!}"),
                Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                Text(" period:",style: TextStyle(
                  fontSize: 20,
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                ),),
                Text("${widget.workExperience![index].period!}"),
                Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                Text(" description:",style: TextStyle(
                  fontSize: 20,
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                ),),
                Text("${widget.workExperience![index].description!}"),
              ],
            ),
          ),
        );
      },
    ): Center(
      child: Text('No Work Experience'),
    );
  }
}
