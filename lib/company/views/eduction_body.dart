import 'package:flutter/material.dart';
import 'package:untitled10/SharedViews/ChatScreen.dart';
import 'package:untitled10/company/views/about_and_skills_body.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/navigator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/company/company_model.dart';
import '../../data/users/education.dart';
import '../../data/users/projects.dart';
import '../../data/users/skills.dart';
import '../../data/users/work_experience.dart';

class EductionBody extends StatefulWidget {
  List<Education>? education;
   EductionBody({
    super.key,
    this.education,
  });

  @override
  State<EductionBody> createState() => _EductionBodyState();
}

class _EductionBodyState extends State<EductionBody> {
  @override
  Widget build(BuildContext context) {
    return widget.education!.isNotEmpty ? ListView.builder(
      itemCount: widget.education!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: greenColor,
                  width: 2,
                )),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "academic :",
                    style: TextStyle(
                      fontSize: 20,
                      color: greenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${widget.education![index].name!}"),
                  Divider(
                    endIndent: 10,
                    indent: 10,
                  ),
                  Text(
                    'degree: ',
                    style: TextStyle(
                      fontSize: 20,
                      color: greenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${widget.education![index].degree!}'),
                  Divider(
                    endIndent: 10,
                    indent: 10,
                  ),
                  // Text("from: ${widget.education![index].from!}"),
                  // Text(widget.education![index].to!),
                  Text(
                    " description:",
                    style: TextStyle(
                      fontSize: 20,
                      color: greenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      " description: ${widget.education![index].description!}"),
                  Divider(
                    endIndent: 10,
                    indent: 10,
                  ),
                  // Text("from:",style: TextStyle(
                  //   fontSize: 20,
                  //   color: greenColor,
                  //   fontWeight: FontWeight.bold,
                  // ),),
                  // Text("${widget.education![index].from!}"),
                  //
                  // Divider(
                  //   endIndent: 10,
                  //   indent: 10,
                  // ),
                  // Text("to:",style: TextStyle(
                  //   fontSize: 20,
                  //   color: greenColor,
                  //   fontWeight: FontWeight.bold,
                  // ),),
                  // Text("${widget.education![index].to!}"),
                  // Divider(
                  //   endIndent: 10,
                  //   indent: 10,
                  // ),
                  Text(
                    'Grade: ',
                    style: TextStyle(
                      fontSize: 20,
                      color: greenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${widget.education![index].grade!}'),
                  Divider(
                    endIndent: 10,
                    indent: 10,
                  ),
                  Text(
                    'Field:',
                    style: TextStyle(
                      fontSize: 20,
                      color: greenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${widget.education![index].field!}'),
                ],
              ),
            ),
          ),
        );
      },
    ): Center(
      child: Text('No Education'),
    );
  }
}
