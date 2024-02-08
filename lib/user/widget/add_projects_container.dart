import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled10/data/users/projects.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/widget/add_or_edit_projects.dart';

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
            Text('Add Projects', style: TextStyle(
              color: greenColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,

            )),
            for(var i = 0; i < projects.length; i++)
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     width: MediaQuery.of(context).size.width*0.79 ,

                     decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(10),
                           bottomRight: Radius.circular(10),
                           bottomLeft: Radius.circular(10),
                         ),
                         border: Border.all(
                           color: greenColor,
                           width: 2,
                         )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text('Project Name :',style: TextStyle(
                              color: greenColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                            Text('${projects[i].name}'),

                            Divider(),
                            Text('Project Link :',style: TextStyle(
                              color: greenColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                            Text('${projects[i].url}'),

                            Divider(),
                            Text('Project Description :',style: TextStyle(
                              color: greenColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                            Text('${projects[i].description}'),

                          ],

                        ),
                      ),

                    ),
                   Container(
                     decoration: BoxDecoration(
                         color: greenColor,
                         borderRadius: BorderRadius.only(
                           topRight: Radius.circular(10),
                           bottomRight: Radius.circular(10),
                         )

                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         IconButton(onPressed: (){
                           setState(() {
                             showDialog(context: context,
                                 barrierColor: Colors.black.withOpacity(0.5),

                                 useSafeArea: true,



                                 barrierLabel: 'edit',builder: (context) {
                                   return AddOrEditProjects(
                                     onEdit: (value) {
                                       setState(() {
                                         projects.add(value);
                                         widget.onAdd!(projects);
                                       });
                                       Navigator.pop(context);
                                     },
                                     projectsModel: projects[i],
                                   );});
                           });
                         }, icon: Icon(Ionicons.create,color: Colors.white,)),
                         IconButton(onPressed: (){
                           setState(() {
                              projects.removeAt(i);
                           });
                         }, icon: Icon(Ionicons.close,color: Colors.red,)),
                       ],
                     ),
                   ),

                 ],
               ),
             ),
            CircleAvatar(
              radius: 20,
              backgroundColor: greenColor,

              child: IconButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  return AddOrEditProjects(
                    onAdd: (value){
                      setState(() {
                        projects.add(value);
                        widget.onAdd!(projects);
                        Navigator.pop(context);
                      });
                    },



                  );
                });
    },
                  color: greenColor,
                  icon: Icon(Ionicons.add, color: Colors.white)),
            ),


          ],
        ),
      ),
    );

  }
}
