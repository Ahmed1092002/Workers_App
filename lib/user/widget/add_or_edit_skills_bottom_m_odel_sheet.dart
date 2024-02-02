import 'package:flutter/material.dart';
import 'package:untitled10/SharedWidget/working_feilds_dropdown_button_form_field.dart';
import 'package:untitled10/data/users/skills.dart';
import 'package:untitled10/utils/consatants.dart';

import '../../src/app_root.dart';

class AddOrEditSkillsBottomModelSheet extends StatefulWidget {
  Function(SKills)? onAdd;
  SKills? skillsModel;
   AddOrEditSkillsBottomModelSheet({Key? key,this.onAdd,this.skillsModel }) : super(key: key);


  @override
  State<AddOrEditSkillsBottomModelSheet> createState() => _AddOrEditSkillsBottomModelSheetState();
}

class _AddOrEditSkillsBottomModelSheetState extends State<AddOrEditSkillsBottomModelSheet> {
  SKills? skillsModel ;
  TextEditingController nameController = TextEditingController();
@override
  void initState() {
  if (widget.skillsModel!=null) {
    skillsModel = widget.skillsModel;
    nameController.text = skillsModel!.name!;

  }
    super.initState();
}
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: Text('Add Skill'),
      content:getDropDownButtonFormField(
        hint: 'Select Skill',
        job: jobSkills,
        jobString: nameController.text,
        Function: (value) {
          setState(() {
            skillsModel = SKills(name: value);
          });
        },
        context: context,


      ),
      actions: [
        TextButton(onPressed: (){ Navigator.pop(context);}, child: Text('Cancel',style: TextStyle(color: Colors.red),)),
        TextButton(onPressed: (){
          setState(() {


  widget.onAdd!(skillsModel!);


Navigator.pop(context);

          });



        },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),child:
             Text('Add',style: TextStyle(color: Colors.white),)),
      ],
    );
  }
}
