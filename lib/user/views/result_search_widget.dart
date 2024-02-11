import 'package:flutter/material.dart';
import 'package:untitled10/data/company/jop_model.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/widget/job_container.dart';

import '../../SharedWidget/NewJopContainer.dart';
import '../../company/views/jop_details_screan.dart';
import '../../utils/navigator.dart';
import 'details_jop_and_applyed_screan.dart';

class ResultSearchWidget extends StatelessWidget {
  List<JopsModel> jops;
  String? userType;
  String? title = 'Result Search';
   ResultSearchWidget({Key? key, required this.jops, this.userType,  this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:     SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.64,

        child: ListView.builder(
            shrinkWrap: true,

            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: userType == 'users' ? GestureDetector(
                  onTap: (){
                    navigateToScreen(context, DetailsJopAndApplyedScrean(
                    jops: jops[index],
                      isSaved: jops[index].isSaved!,
                    ));
                  },
                  child: JobContainer(
                   screenName: 'Result Search',
                    salary: jops[index].Salary!,
                    experience: jops[index].Experience!,
                    level: jops[index].jobLevel!,
                    jobShift: jops[index].jobShift!,
                    Country: jops[index].country!,
                    companyName: jops[index].companyname!,
                    companyLogo: jops[index].companyImageUrl!,
                    location: jops[index].location!,
                    jobType: jops[index].jopType!,
                    title: jops[index].title!,
                    isSaved: jops[index].isSaved!,

                    onSave: (bool ){},

                  ),
                ):GestureDetector(
                  onTap: (){
                    navigateToScreen(context, JopDetailsScrean(
                     jopModel: jops[index],
                    ));
                  },
                  child: NewJopContainer(
                    location: jops[index].location!,
                    companyName: jops[index].companyname!,
                    companyLogo: jops[index].companyImageUrl!,
                    name: jops[index].title!,
                    experience: jops[index].Experience!,
                    jopField: jops[index].jopType!,
                    salary: jops[index].Salary!,
                    jopType: jops[index].jobShift!,

                  ),
                ),
              );
            },
            itemCount: jops.length),
      ),

      appBar: AppBar(
        title: Text(title!, style: TextStyle(
          color: greenColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: backgroundColor,
        titleTextStyle: TextStyle(
          color: greenColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: greenColor, //change your color here
        ),
        centerTitle: true,

      ),
    );
  }
}
