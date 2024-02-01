import 'package:flutter/material.dart';
import 'package:untitled10/data/company/jop_model.dart';
import 'package:untitled10/src/app_root.dart';

import '../../SharedWidget/NewJopContainer.dart';
import '../../utils/navigator.dart';
import 'details_jop_and_applyed_screan.dart';

class ResultSearchWidget extends StatelessWidget {
  List<JopsModel> jops;
   ResultSearchWidget({Key? key, required this.jops}) : super(key: key);

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
                child: GestureDetector(
                  onTap: (){
                    navigateToScreen(context, DetailsJopAndApplyedScrean(
                      jops: jops[index],
                    ));
                  },
                  child: NewJopContainer(
                    jopField: jops[index].jopField,
                    jopType: jops[index].jopType,
                    companyName: jops[index].companyname,
                    location: jops[index].location,
                    experience: jops[index].Experience,
                    name: jops[index].title,
                    //todo;fix this


                  ),
                ),
              );
            },
            itemCount: jops.length),
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
