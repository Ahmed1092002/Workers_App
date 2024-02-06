import 'package:flutter/material.dart';
import 'package:untitled10/data/company/jop_model.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/widget/job_container.dart';

import '../../SharedWidget/NewJopContainer.dart';
import '../../company/views/jop_details_screan.dart';
import '../../utils/navigator.dart';
import 'details_jop_and_applyed_screan.dart';

class ResultSearchWidget extends StatefulWidget {
  List<JopsModel> jops;
  String? userType;
   ResultSearchWidget({Key? key, required this.jops, this.userType}) : super(key: key);

  @override
  State<ResultSearchWidget> createState() => _ResultSearchWidgetState();
}

class _ResultSearchWidgetState extends State<ResultSearchWidget> {
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
                child: widget.userType == 'users' ? GestureDetector(
                  onTap: (){
                    navigateToScreen(context, DetailsJopAndApplyedScrean(
                    jops: widget.jops[index],
                      isSaved: widget.jops[index].isSaved!,
                    ));
                  },
                  child: JobContainer(
                   screenName: 'Result Search',
                    salary: widget.jops[index].Salary!,
                    experience: widget.jops[index].Experience!,
                    level: widget.jops[index].jobLevel!,
                    jobShift: widget.jops[index].jobShift!,
                    Country: widget.jops[index].country!,
                    companyName: widget.jops[index].companyname!,
                    companyLogo: widget.jops[index].companyImageUrl!,
                    location: widget.jops[index].location!,
                    jobType: widget.jops[index].jopType!,
                    title: widget.jops[index].title!,
                    isSaved: widget.jops[index].isSaved!,

                    onSave: (bool ){},

                  ),
                ):GestureDetector(
                  onTap: (){
                    navigateToScreen(context, JopDetailsScrean(
                     jopModel: widget.jops[index],
                    ));
                  },
                  child: NewJopContainer(
                    location: widget.jops[index].location!,
                    companyName: widget.jops[index].companyname!,
                    companyLogo: widget.jops[index].companyImageUrl!,
                    name: widget.jops[index].title!,
                    experience: widget.jops[index].Experience!,
                    jopField: widget.jops[index].jopType!,
                    salary: widget.jops[index].Salary!,
                    jopType: widget.jops[index].jobShift!,

                  ),
                ),
              );
            },
            itemCount: widget.jops.length),
      ),

      appBar: AppBar(
        title: Text('Result Search'),
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
