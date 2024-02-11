import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled10/SharedWidget/select_date_item.dart';
import 'package:untitled10/data/users/education.dart';
import 'package:untitled10/user/widget/add_or_edit_education_model_bottom_sheet.dart';

import '../../src/app_root.dart';

class AddEducationContainer extends StatefulWidget {
  Function(List)? onAdd;


  AddEducationContainer({

    super.key,
    this.onAdd   ,
  });

  @override
  State<AddEducationContainer> createState() => _AddEducationContainerState();
}

class _AddEducationContainerState extends State<AddEducationContainer> {
   Education? educationModel = Education() ;

List<Education> education = [];




  DateTime? _selectedDate;
  String? formattedDate;
   Future _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final packeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.white,
                onPrimary:greenColor,
                surface: greenColor,

                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },

        lastDate: now);
    setState(() {
      _selectedDate = packeddate;
      formattedDate = '${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}';

    });


  }
  String?startDate;
  String?endDate;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height  ,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Education',style: TextStyle(
              color: greenColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            for(var i = 0; i < education.length; i++)
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,

                 children: [
                 Container(
                   width: MediaQuery.of(context).size.width*0.76,
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

                         Text('School/University Name :',style: TextStyle(
                           color: greenColor,
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),),
                         Text('${education[i].name}',),
                         Divider(),
                         Text('Field : ',style: TextStyle(
                           color: greenColor,
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),),
                         Text('${education[i].field}'),
                         Divider(),


                         Text('Degree : ',style: TextStyle(
                           color: greenColor,
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),),
                         Text('${education[i].degree}'),
                         Divider(),
                         Text('Start Date :',style: TextStyle(
                           color: greenColor,
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),),
                         Text('${education[i].from}'),
                         Divider(),
                         Text('End Date :',style: TextStyle(
                           color: greenColor,
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),),
                         Text('${education[i].to}'),
                         Divider(),
                         Text('Description :',style: TextStyle(
                           color: greenColor,
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),),
                         Text('${education[i].description}'),
                         Divider(),
                         Text('Grede :',style: TextStyle(
                           color: greenColor,
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),),
                         Text('${education[i].grade}'),
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
                                   return AddOrEditEducationModelBottomSheet(
                                     onEdit: (workExperienceOPject) {
                                       setState(() {
                                         education[i] = workExperienceOPject;
                                         widget.onAdd!(education);
                                       });
                                       Navigator.pop(context);
                                     },
                                     educationModel: education[i],
                                   );
                                 });
                           });
                         }, icon: Icon(Ionicons.create,color: Colors.white,)),
                         IconButton(onPressed: (){
                           setState(() {
                             education.removeAt(i);
                             widget.onAdd!(education);
                           });
                         }, icon: Icon(Ionicons.close,color: Colors.red,)),
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
                        return AddOrEditEducationModelBottomSheet(
                          onAddItem: ( educationItem) {
                            setState(() {
                              education.add(educationItem);
                              widget.onAdd!(education);
                            });
                            Navigator.pop(context);
                          },
                        );
                      });

                });


              },
                  color: Colors.white,
                  icon: Icon(Ionicons.add,  color: Colors.white,)),

            ),
          ],
        ),
      )




    );
  }
}
