import 'package:flutter/material.dart';
import 'package:untitled10/data/users/education.dart';

import '../../src/app_root.dart';

class AddOrEditEducationModelBottomSheet extends StatefulWidget {
  Education? educationModel;
  Function(Education)? onEdit;
  Function(Education)? onAddItem;
   AddOrEditEducationModelBottomSheet({Key? key,this.educationModel,this.onEdit,this.onAddItem}) : super(key: key);

  @override
  State<AddOrEditEducationModelBottomSheet> createState() => _AddOrEditEducationModelBottomSheetState();
}

class _AddOrEditEducationModelBottomSheetState extends State<AddOrEditEducationModelBottomSheet> {
  DateTime? _selectedDate;

  String? formattedDate;
  Education? educationModel = Education() ;


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
      formattedDate = _selectedDate != null ? '${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}' : null;
    });


  }

  String?startDate;

  String?endDate;
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _degreeController = TextEditingController();
  TextEditingController _fieldController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _gradeController = TextEditingController();

  @override
  void initState() {
    if (widget.educationModel != null) {
      educationModel = widget.educationModel;
      _startDateController.text = widget.educationModel!.from!;
      _nameController.text = widget.educationModel!.name!;
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
              decoration: InputDecoration(
                labelText: 'School Name',
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
              decoration: InputDecoration(
                labelText: 'Degree',
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
              controller: _fieldController,
              decoration: InputDecoration(
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
            child: TextFormField(
              controller: _startDateController,
              decoration: InputDecoration(
                labelText: 'Start Date',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                educationModel!.from = value;
                widget.educationModel!.from = value;
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
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                educationModel!.description = value;
                widget.educationModel!.description = value;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
            children: [
              ElevatedButton(onPressed: (){
                setState(() {
                  if (widget.educationModel == null) {
                        widget.onAddItem!(educationModel!);
                      }
if (widget.educationModel != null) {
  widget.onEdit!(widget.educationModel!);
}
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:widget.educationModel == null ? Text('Add') : Text('Edit'),
                  ));
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
