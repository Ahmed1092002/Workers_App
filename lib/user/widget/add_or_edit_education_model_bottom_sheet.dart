import 'package:flutter/material.dart';
import 'package:untitled10/data/users/education.dart';

import '../../src/app_root.dart';
import 'add_or_edit_experience_model_bottom_sheet.dart';
List<String> grades = [
  'Good',
  'Very Good',
  'Excellent',
  'Very Excellent',
];

class AddOrEditEducationModelBottomSheet extends StatefulWidget {
  Education? educationModel;
  Function(Education)? onEdit;
  Function(Education)? onAddItem;
   AddOrEditEducationModelBottomSheet({Key? key,this.educationModel,this.onEdit,this.onAddItem}) : super(key: key);

  @override
  State<AddOrEditEducationModelBottomSheet> createState() => _AddOrEditEducationModelBottomSheetState();
}

class _AddOrEditEducationModelBottomSheetState extends State<AddOrEditEducationModelBottomSheet> {

  Education? educationModel = Education() ;

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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _degreeController = TextEditingController();
  TextEditingController _fieldController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _gradeController = TextEditingController();

  @override
  void initState() {
    if (widget.educationModel != null) {
      educationModel = widget.educationModel;
      _nameController.text = widget.educationModel!.name!;

      formattedDate = widget.educationModel!.from!;
      startDate = formatter.parse(formattedDate!);
      formattedDate = widget.educationModel!.to!;
      endDate = formatter.parse(formattedDate!);
      _degreeController.text = widget.educationModel!.degree!;
      _fieldController.text = widget.educationModel!.field!;
      _descriptionController.text = widget.educationModel!.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).viewInsets.bottom==0?MediaQuery.of(context).size.height :MediaQuery.of(context).size.height * 1.5,
      padding: EdgeInsets.all(20),
      color: backgroundColor,

      child: Column(
        children: [


          Padding(padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: _nameController,
              cursorColor: greenColor,

              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),

                labelText: 'School / University Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                educationModel!.name = value;
                widget.educationModel!.name = value;

              },
            ),
          ),
          Padding(padding: EdgeInsets.all(10),
            child: TextFormField(
              cursorColor: greenColor,

              decoration: InputDecoration(
                labelText: 'Degree',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),
                border: OutlineInputBorder(),
              ),
              controller: _degreeController,
              onChanged: (value){
                educationModel!.degree = value;
                widget.educationModel!.degree = value;
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(10),
            child: TextFormField(
              cursorColor: greenColor,

              controller: _fieldController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),
                labelText: 'Field Of Study',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                educationModel!.field = value;
                widget.educationModel!.field = value;
              },
            ),
          ),





          Padding(padding: EdgeInsets.all(10),
            child: TextFormField(              cursorColor: greenColor,

              controller: _descriptionController,
              decoration: InputDecoration(  focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greenColor),
              ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                educationModel!.description = value;
                widget.educationModel!.description = value;
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(10),
            child: TextFormField(              cursorColor: greenColor,

              controller: _gradeController,
              decoration: InputDecoration(  focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greenColor),
              ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),
                labelText: 'Grade',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                educationModel!.grade = value;
                widget.educationModel!.description = value;
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
                  educationModel!.from = formatter.format(startDate!);
                  educationModel!.to = formatter.format(endDate!);
                  if (_nameController.text == '' || _degreeController.text == '' || _fieldController.text == '' || _descriptionController.text == '' || _gradeController.text == '' || startDate == null || endDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please fill all fields'),
                    ));
                    return;
                  }else {
                    if (widget.educationModel == null) {
                      widget.onAddItem!(educationModel!);
                    }
                    if (widget.educationModel != null) {
                      widget.onEdit!(widget.educationModel!);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:widget.educationModel == null ? Text('Add') : Text('Edit'),
                    ));
                  }

                });
              }, child:widget.educationModel != null ? Text('Edit',style: TextStyle(color: Colors.white),):  Text('Add',style: TextStyle(color: Colors.white),)),
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
