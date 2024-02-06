import 'package:flutter/material.dart';
import 'package:untitled10/src/app_root.dart';

import '../../data/users/projects.dart';

class AddOrEditProjects extends StatefulWidget {
  Function(Projects)? onAdd;
  Function(Projects)? onEdit;
  Projects? projectsModel;


  AddOrEditProjects({Key? key,this.onAdd,this.onEdit,this.projectsModel}) : super(key: key);

  @override
  State<AddOrEditProjects> createState() => _AddOrEditProjectsState();
}

class _AddOrEditProjectsState extends State<AddOrEditProjects> {
  Projects? projectsModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.projectsModel != null) {
      projectsModel = widget.projectsModel;
      nameController.text = projectsModel!.name!;
      urlController.text = projectsModel!.url!;
      descriptionController.text = projectsModel!.description!;

    }

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
backgroundColor: backgroundColor,
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: nameController,
              cursorColor: greenColor,


              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),
                labelText: 'Project Name',
                border: OutlineInputBorder(),
              ),

              onChanged: (value){
                if(projectsModel == null){
                  projectsModel = Projects();
                }
                projectsModel!.name = value;

              },

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              cursorColor: greenColor,

              controller: urlController,

              onChanged: (value){
                if(projectsModel == null){
                  projectsModel = Projects();
                }
                projectsModel!.url = value;
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),
                labelText: 'Project Link',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              cursorColor: greenColor,

              controller: descriptionController,
              onChanged: (value){
                if(projectsModel == null){
                  projectsModel = Projects();
                }
                projectsModel!.description = value;
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                ),
                labelStyle: TextStyle(color: greenColor),
                labelText: 'Project Description',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: (){ Navigator.pop(context);}, child: Text('Cancel',style: TextStyle(color: Colors.red),)),
        TextButton(onPressed: (){

          if (nameController.text.isEmpty || urlController.text.isEmpty || descriptionController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Fill All Fields')));
            return;
          }else {

            setState(() {
              if (widget.projectsModel != null) {
                widget.onEdit!(projectsModel!);
              }
              if (widget.projectsModel == null) {
                widget.onAdd!(projectsModel!);
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added Successfully')));

            });

          }






        },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),child:

            widget.projectsModel == null ? Text('Add',style: TextStyle(color: Colors.white),) : Text('Edit',style: TextStyle(color: Colors.white),)),
      ],
    );
  }
}
