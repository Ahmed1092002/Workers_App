import 'package:flutter/material.dart';
import 'package:untitled10/data/users/skills.dart';

import '../../src/app_root.dart';

class AddOrEditSkillsBottomModelSheet extends StatefulWidget {
  Function(SKills)? onAdd;
  Function(SKills)? onEdit;
  SKills? skillsModel;
   AddOrEditSkillsBottomModelSheet({Key? key,this.onAdd,this.onEdit,this.skillsModel }) : super(key: key);


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
      content: TextField(
        onChanged: (value){
          skillsModel = SKills(name: value);
        },
      ),
      actions: [
        TextButton(onPressed: (){ Navigator.pop(context);}, child: Text('Cancel',style: TextStyle(color: Colors.red),)),
        TextButton(onPressed: (){
          setState(() {
if (widget.skillsModel!=null) {
  widget.onEdit!(skillsModel!);
}
if (widget.skillsModel == null) {
  widget.onAdd!(skillsModel!);
}



          });



        },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),child:
             Text('Add',style: TextStyle(color: Colors.white),)),
      ],
    );
  }
}
