import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../src/app_root.dart';
import '../utils/consatants.dart';

class WorkingFeildsDropdownButtonFormField extends StatelessWidget {
  Function (String)? onWorkFeilds;
  Function (String)? onJob;
  Function (String)? onCountry;

  String?screanName;
  String ?countryString;
  String ?job;
  String ?workFeilds;
  String? userType;





   WorkingFeildsDropdownButtonFormField({Key? key,
     this.onWorkFeilds,this.onJob,this.userType,this.onCountry,

     this.countryString,this.job,this.workFeilds,this.screanName}) : super(key: key);





  @override
  Widget build(BuildContext context) {



    return Column(
      children: [

        getDropDownButtonFormField(
          job: WorkingFeilds,
          hint:   'Working Feilds',
          context: context,

          icon: Ionicons.briefcase,
          jobString: workFeilds,
          Function: (  value){
            onWorkFeilds!(value);

        },
        ),
        if (userType=='users')
        getDropDownButtonFormField(
          job: Jobs,
          hint:   'Job Field',
          icon: Ionicons.briefcase,
          jobString: job,
          context: context,
          Function: (  value){
            onJob!(value);

        },

        ),
          getDropDownButtonFormField(
          job: country,
          hint:   'Country',
          icon: Ionicons.earth,
          jobString: countryString,
            context: context,
          Function: (  value){
            onCountry!(value);
        },
        ),

      ],
    );
  }
}
 Widget getDropDownButtonFormField({List<String>? job ,String? jobString,Function(String)? Function,String? hint,IconData? icon,BuildContext? context}) {
  final jobList= job!.toSet().toList();
  int selectedIndex = 0;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DropdownButtonFormField(


      borderRadius: BorderRadius.circular(5),
      isDense: true,

      dropdownColor: backgroundColor,
      menuMaxHeight: 300,
      isExpanded: true,


      items: job
          .map((e) => DropdownMenuItem(

        child:   Text(e,style: TextStyle(
          color: greenColor,
          fontWeight: FontWeight.bold,
        ),),
        value: e,
        onTap: (){
          selectedIndex=jobList.indexOf(e);
          print(selectedIndex);

        },
      ))
          .toList(),

      hint:      Text('$hint',style: TextStyle(
        color: greenColor,

        fontWeight: FontWeight.bold,
      )),


      decoration: InputDecoration(
        prefixIcon: Icon(icon,color: greenColor,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        isDense: true,
        isCollapsed: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: greenColor,
          ),
        ),

        contentPadding: EdgeInsets.all(12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: greenColor,

          ),
        ),
      ),
      style: Theme.of(context!).textTheme.bodySmall,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 30,


      iconEnabledColor: Colors.black,
      onChanged: (value) {
        int index = jobList.indexOf(value.toString()); // Get the index of the selected element
        if (index != -1) {
          selectedIndex = index+1; // Update the selectedIndex variable
        }
        Function!(value.toString());
      },


    ),
  );
}