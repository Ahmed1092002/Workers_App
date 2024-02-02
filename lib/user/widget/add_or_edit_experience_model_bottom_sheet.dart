import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/users/work_experience.dart';
import '../../src/app_root.dart';
final formatter =DateFormat.yMd();
class AddOrEditExperienceModelBottomSheet extends StatefulWidget {
  Function(WorkExperience)? onAdd;
  WorkExperience? workExperienceModel;
  Function(WorkExperience)? onEdit;
   AddOrEditExperienceModelBottomSheet({Key? key,this.workExperienceModel,this.onEdit,this.onAdd}) : super(key: key);

  @override
  _AddOrEditExperienceModelBottomSheetState createState() =>
      _AddOrEditExperienceModelBottomSheetState();
}

class _AddOrEditExperienceModelBottomSheetState
    extends State<AddOrEditExperienceModelBottomSheet> {
  WorkExperience? workExperienceModel = WorkExperience() ;
  TextEditingController companyController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController periodController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? formattedDate;
  Future _presentStartDatePicker() async {
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
      startDate = packeddate;
      formattedDate = '${startDate!.year}/${startDate!.month}/${startDate!.day}';

    });


  }
  Future _presentEndDatePicker() async {
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
      endDate = packeddate;
      formattedDate = '${endDate!.year}/${endDate!.month}/${endDate!.day}';

    });


  }
  DateTime?startDate;
  DateTime?endDate;
  @override
  initState(){
    super.initState();
    if(widget.workExperienceModel!=null){
      workExperienceModel=widget.workExperienceModel;
      companyController.text=widget.workExperienceModel!.company!;
      positionController.text=widget.workExperienceModel!.position!;
      periodController.text=widget.workExperienceModel!.period!;
        formattedDate=widget.workExperienceModel!.startDate!;
        startDate=formatter.parse(formattedDate!);
        formattedDate=widget.workExperienceModel!.endDate!;
        endDate=formatter.parse(formattedDate!);
      descriptionController.text=widget.workExperienceModel!.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).viewInsets.bottom==0?MediaQuery.of(context).size.height :MediaQuery.of(context).size.height * 1.5,
      padding: EdgeInsets.all(20),
      color:backgroundColor,

      child: Column(

        children: [


          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              controller: companyController,
              cursorColor: greenColor,


              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),

                labelText: 'Company Name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),

                border: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
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
              controller: positionController,
              cursorColor: greenColor,

              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),                labelText: 'Position',
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
              controller: periodController,
              cursorColor: greenColor,

              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),
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
              cursorColor: greenColor,

              controller: descriptionController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (workExperienceModel == null) {
                  workExperienceModel = WorkExperience();
                }
                workExperienceModel!.description = value;
                widget.workExperienceModel!.description = value;
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Start Date',style: TextStyle(color: greenColor),),
              IconButton(
                onPressed:_presentStartDatePicker,
                icon: Icon(Icons.calendar_today,color: greenColor,),
              ),
              SizedBox(
                width: 10,
              ),
              Text(startDate == null
                  ? 'No Date Chosen'
                  : formatter.format(startDate!),
                  style: startDate == null
                      ? TextStyle(color: Colors.red)
                      : TextStyle(color: greenColor)


              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('End Date',style: TextStyle(color: greenColor),),
              IconButton(
                onPressed:_presentEndDatePicker,
                icon: Icon(Icons.calendar_today,color: greenColor,),
              ),
              SizedBox(
                width: 10,
              ),
              Text(endDate == null
                  ? 'No Date Chosen'
                  : formatter.format(endDate!),
                  style: endDate == null
                      ? TextStyle(color: Colors.red)
                      : TextStyle(color: greenColor)

              ),
            ],
          ),



          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
            children: [
              ElevatedButton(onPressed: (){
                setState(() {
                  workExperienceModel!.startDate = formatter.format(startDate!);
                  workExperienceModel!.endDate = formatter.format(endDate!);

if (widget.workExperienceModel != null) {
  widget.onEdit!(workExperienceModel!);

}
if(widget.workExperienceModel == null){
  widget.onAdd!(workExperienceModel!);

}

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: widget.workExperienceModel == null ? Text('Added') : Text('Edited'),
                  ));
                });
              }, child: widget.workExperienceModel == null ? Text('Add',style: TextStyle(color: Colors.white),) : Text('Edit',style: TextStyle(color: Colors.white),)),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel',style: TextStyle(color: Colors.white),)),
            ],
          )


        ],
      ),
    );
  }
}
