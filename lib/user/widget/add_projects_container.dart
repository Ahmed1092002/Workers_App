import 'package:flutter/material.dart';
import 'package:untitled10/data/users/projects.dart';

class AddProjectsContainer extends StatefulWidget {
  Function(List)? onAdd;
   AddProjectsContainer({
    super.key,
     this.onAdd,
  });

  @override
  State<AddProjectsContainer> createState() => _AddProjectsContainerState();
}

class _AddProjectsContainerState extends State<AddProjectsContainer> {
    Projects? projectsModel= Projects() ;

  List<Projects> projects = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height  ,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Projects'),
            for(var i = 0; i < projects.length; i++)
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

                      Text('Project Name : ${projects[i].name}'),
                      Text('Project Link : ${projects[i].url}'),
                      Text('Project Description : ${projects[i].description}'),

                    ],

                  ),

                ),
             ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green,

              child: IconButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: Text('Add Project'),
                    content: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            decoration: InputDecoration(
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
                            onChanged: (value){
                              if(projectsModel == null){
                                projectsModel = Projects();
                              }
                              projectsModel!.url = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Project Link',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            onChanged: (value){
                              if(projectsModel == null){
                                projectsModel = Projects();
                              }
                              projectsModel!.description = value;
                            },
                            decoration: InputDecoration(
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

                        setState(() {
                          projects.add(projectsModel!);
                          widget.onAdd!(projects);
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
        ),
      ),
    );

  }
}
