import 'package:flutter/material.dart';
import 'package:untitled10/data/users/skills.dart';

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
            Text('Add Skills'),
            Wrap(
              children: skills.map((skill) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text('Skill Name : ${skill.name}'),
                  ),
                );
              }).toList(),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green,


              child: IconButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
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

                          skills.add(skillsModel!);
                          widget.onAdd!(skills);
                          Navigator.pop(context);
                        });



                      },
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),child: Text('Add',style: TextStyle(color: Colors.white),)),
                    ],
                  );
                });


              },
                  color: Colors.white,
                  icon: Icon(Icons.add)),

            ),
          ],
    )
      )

    );
  }
}
