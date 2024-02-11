import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled10/data/users/skills.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/widget/add_or_edit_skills_bottom_m_odel_sheet.dart';

class AddSkillsContainer extends StatefulWidget {
  Function(List)? onAdd;
   AddSkillsContainer({
    super.key,
    this.onAdd,
  });

  @override
  State<AddSkillsContainer> createState() => _AddSkillsContainerState();
}

class _AddSkillsContainerState extends State<AddSkillsContainer> {
   SKills? skillsModel ;

  List<SKills> skills = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height  ,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Skills', style: TextStyle(
              color: greenColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,

            )),
            Wrap(
              children: skills.map((skill) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: greenColor,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(

                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),

                            color: greenColor,
                          ),
                          child: IconButton(
                              onPressed: (){
                            setState(() {
                              skills.remove(skill);
                            });
                          },
                              icon: Icon(Ionicons.close,color: Colors.red,)),
                        ),
                        SizedBox(width: 10,),

                        Text(' ${skill.name}'),

                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: greenColor,


              child: IconButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  return AddOrEditSkillsBottomModelSheet(
                    onAdd: (value) {
                      setState(() {
                        skills.add(value);
                      });
                    },
                    skillsModel: skillsModel,

                  );
                });


              },
                  color: Colors.white,
                  icon: Icon(Ionicons.add,)),

            ),
          ],
    )
      )

    );
  }
}
