import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled10/SharedWidget/select_date_item.dart';
import 'package:untitled10/data/users/education.dart';

import '../../src/app_root.dart';

class AddEducationContainer extends StatefulWidget {
  Function(List)? onAdd;
  Education? educationModel;
  Function(Education)? onEdit;
  Function(Education)? onAddItem;

  AddEducationContainer({
this.onAddItem,
    this.educationModel,
    this.onEdit,
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
            Text('Add Education'),
            for(var i = 0; i < education.length; i++)
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

                      Text('School Name : ${education[i].name}'),
                      Text('Degree : ${education[i].degree}'),
                      Text('Field Of Study : ${education[i].field}'),
                      Text('Start Date : ${education[i].from}'),
                      Text('End Date : ${education[i].to}'),
                      Text('Description : ${education[i].description}'),


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


                         Padding(padding: EdgeInsets.all(10),
                         child: TextFormField(
                           decoration: InputDecoration(
                             labelText: 'School Name',
                             border: OutlineInputBorder(),
                           ),
                           onChanged: (value){
                             educationModel!.name = value;
                           },
                         ),
                         ),
                              Padding(padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Degree',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value){
                                    educationModel!.degree = value;
                                  },
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Field Of Study',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value){
                                    educationModel!.field = value;
                                  },
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Start Date',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value){
                                    educationModel!.from = value;
                                  },
                                ),
                              ),
                              // SelectDateItem(
                              //   icon: Icons.timer_outlined,
                              //   date: educationModel!.from==null?'Start Date':educationModel!.from!,
                              //   onTap: () async {
                              //
                              //
                              //
                              //     educationModel!.from = await _presentDatePicker();
                              //
                              //   },
                              // ),
                              // SelectDateItem(
                              //   icon: Icons.timer_off_outlined,
                              //   date: _selectedDate == null ? 'End Date' : formattedDate!,
                              //   onTap: () async {
                              //     await _presentDatePicker();
                              //     setState(() {
                              //       endDate = formattedDate;
                              //       educationModel!.to = formattedDate;
                              //     });
                              //   },
                              // ),

                              Padding(padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value){
                                    educationModel!.description = value;
                                  },
                                ),
                         ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                                children: [
                                  ElevatedButton(onPressed: (){
                                    setState(() {
                                      education.add(educationModel!);
                                      widget.onAdd!(education);
                                      widget.onAddItem!(educationModel!);
                                      widget.onEdit!(educationModel!);
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
      )




    );
  }
}
