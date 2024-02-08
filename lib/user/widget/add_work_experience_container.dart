import 'package:flutter/material.dart';
import 'package:untitled10/data/users/work_experience.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/widget/add_or_edit_experience_model_bottom_sheet.dart';

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
          Text('Add work Experience',style: TextStyle(
            color: greenColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          for(var i = 0; i < workExperience.length; i++)
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,

               children: [
                 Container(
                    width: MediaQuery.of(context).size.width*0.79 ,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        border: Border.all(
                          color: greenColor,
                          width: 2,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text('Company Name :',style: TextStyle(
                            color: greenColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${workExperience[i].company}',),
                          Divider(),
                          Text('Position : ',style: TextStyle(
                            color: greenColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${workExperience[i].position}'),
                          Divider(),

                          Text('Start Date :',style: TextStyle(
                            color: greenColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text(' ${workExperience[i].startDate}'),
                          Divider(),

                          Text('End Date :',style: TextStyle(
                            color: greenColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${workExperience[i].endDate}'),
                          Divider(),

                          Text('Period :',style: TextStyle(
                            color: greenColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${workExperience[i].period}'),
                          Divider(),

                          Text('Description : ',style: TextStyle(
                            color: greenColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${workExperience[i].description}'),


                        ],
                      ),
                    ),
                  ),
                 Container(
                   decoration: BoxDecoration(
                     color: greenColor,
                     borderRadius: BorderRadius.only(
                       topRight: Radius.circular(10),
                       bottomRight: Radius.circular(10),
                     )

                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       IconButton(onPressed: (){
                         setState(() {
                           showModalBottomSheet(context: context,
                               barrierColor: Colors.black.withOpacity(0.5),
                               isScrollControlled: true,
                               showDragHandle: true,
                               useSafeArea: true,

                               barrierLabel: 'edit',builder: (context) {
                                 return AddOrEditExperienceModelBottomSheet(
                                   onEdit: (workExperienceOPject) {
                                     setState(() {
                                       workExperience[i] = workExperienceOPject;
                                       widget.onAdd!(workExperience);
                                     });
                                     Navigator.pop(context);
                                   },
                                   workExperienceModel: workExperience[i],
                                 );
                               });
                         });
                       }, icon: Icon(Icons.edit,color: Colors.white,)),
                       IconButton(onPressed: (){
                         setState(() {
                           workExperience.removeAt(i);
                           widget.onAdd!(workExperience);
                         });
                       }, icon: Icon(Icons.delete,color: Colors.red,)),
                     ],
                   ),
                 ),
               ],
             ),
           ),
      
      
          CircleAvatar(
            radius: 20,
            backgroundColor: greenColor,
      
      
            child: IconButton(onPressed: (){
              setState(() {
                showModalBottomSheet(context: context,
                    barrierColor: Colors.black.withOpacity(0.5),
                    isScrollControlled: true,
                    showDragHandle: true,
                    useSafeArea: true,

                    barrierLabel: 'add',builder: (context) {
                      return AddOrEditExperienceModelBottomSheet(
                        onAdd: (workExperienceOPject) {
                          setState(() {
                            workExperience.add(workExperienceOPject);
                            widget.onAdd!(workExperience);
                          });
                          Navigator.pop(context);
                        },
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
