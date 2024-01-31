import 'package:flutter/material.dart';

import '../../data/users/work_experience.dart';
import '../../src/app_root.dart';

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
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  initState(){
    super.initState();
    if(widget.workExperienceModel!=null){
      workExperienceModel=widget.workExperienceModel;
      companyController.text=widget.workExperienceModel!.company!;
      positionController.text=widget.workExperienceModel!.position!;
      periodController.text=widget.workExperienceModel!.period!;
      startDateController.text=widget.workExperienceModel!.startDate!;
      endDateController.text=widget.workExperienceModel!.endDate!;
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
              controller: positionController,
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
              controller: periodController,
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
              controller: startDateController,
              decoration: InputDecoration(
                labelText: 'Start Date',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (workExperienceModel == null) {
                  workExperienceModel = WorkExperience();
                }
                workExperienceModel!.startDate = value;
                widget.workExperienceModel!.startDate = value;
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
              controller: endDateController,
              decoration: InputDecoration(
                labelText: 'End Date',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (workExperienceModel == null) {
                  workExperienceModel = WorkExperience();
                }
                workExperienceModel!.endDate = value;
                widget.workExperienceModel!.endDate = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
            children: [
              ElevatedButton(onPressed: (){
                setState(() {
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
