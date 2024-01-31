import 'package:flutter/material.dart';
import 'package:untitled10/data/users/work_experience.dart';
import 'package:untitled10/src/app_root.dart';

import '../../SharedWidget/select_date_item.dart';

class AddWorkExperienceContainer extends StatefulWidget {
  Function(List)? onAdd;

   AddWorkExperienceContainer({
     this.onAdd,
    super.key,
  });

  @override
  State<AddWorkExperienceContainer> createState() => _AddWorkExperienceContainerState();
}

class _AddWorkExperienceContainerState extends State<AddWorkExperienceContainer> {

  WorkExperience? workExperienceModel = WorkExperience() ;
List workExperience = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height  ,

        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Add work Experience'),
          for(var i = 0; i < workExperience.length; i++)
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    )),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
      
                    Text('Company Name : ${workExperience[i].company}'),
                    Text('Position : ${workExperience[i].position}'),
                    Text('Start Date : ${workExperience[i].startDate}'),
                    Text('End Date : ${workExperience[i].endDate}'),
                    Text('Period : ${workExperience[i].period}'),
                    Text('Description : ${workExperience[i].description}'),
      
      
                  ],
                ),
              ),
           ),
      
      
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green,
      
      
            child: IconButton(onPressed: (){
              setState(() {
                showModalBottomSheet(context: context,
                    backgroundColor: backgroundColor,
                    isScrollControlled: true,
                    builder: (context){
                      return Container(
                      height: MediaQuery.of(context).viewInsets.bottom==0?MediaQuery.of(context).size.height :MediaQuery.of(context).size.height * 1.5,
                        padding: EdgeInsets.all(20),
      
                        child: Column(
                          children: [


                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Company Name',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (workExperienceModel == null) {
                                    workExperienceModel = WorkExperience();
                                  }
                                  workExperienceModel!.company = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Position',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  if (workExperienceModel == null) {
                                    workExperienceModel = WorkExperience();
                                  }
                                  workExperienceModel!.position = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Period',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  if (workExperienceModel == null) {
                                    workExperienceModel = WorkExperience();
                                  }
                                  workExperienceModel!.period = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Start Date',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  if (workExperienceModel == null) {
                                    workExperienceModel = WorkExperience();
                                  }
                                  workExperienceModel!.startDate = value;
                                },
                              ),
                            ),
                            // SelectDateItem(
                            //   icon: Icons.date_range,
                            //   date: 'Start Date',
                            //
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'End Date',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  if (workExperienceModel == null) {
                                    workExperienceModel = WorkExperience();
                                  }
                                  workExperienceModel!.endDate = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  if (workExperienceModel == null) {
                                    workExperienceModel = WorkExperience();
                                  }
                                  workExperienceModel!.description = value;
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                              children: [
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                    workExperience.add(workExperienceModel);
                                    widget.onAdd!(workExperience);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Added'),
                                    ));
                                    Navigator.pop(context);
                                  });
                                }, child: Text('Add',style: TextStyle(color: Colors.white),)),
                                ElevatedButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('Cancel',style: TextStyle(color: Colors.white),)),
                              ],
                            )


                          ],
                        ),
                      );
                    });
              });
      
      
            },
            color: Colors.white,
             icon: Icon(Icons.add)),
      
          ),
      
      
        ],
      ),
    ));
  }
}
