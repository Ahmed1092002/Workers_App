import 'package:flutter/material.dart';
import 'package:untitled10/SharedViews/ChatScreen.dart';
import 'package:untitled10/company/views/about_and_skills_body.dart';
import 'package:untitled10/company/views/eduction_body.dart';
import 'package:untitled10/company/views/experienc_body.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/navigator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/company/company_model.dart';
import '../../data/users/education.dart';
import '../../data/users/projects.dart';
import '../../data/users/skills.dart';
import '../../data/users/work_experience.dart';

class ProjectBody extends StatefulWidget {
  List<Projects>? projects;
   ProjectBody({
    super.key,
    this.projects,
  });

  @override
  State<ProjectBody> createState() => _ProjectBodyState();
}

class _ProjectBodyState extends State<ProjectBody> {
  @override
  Widget build(BuildContext context) {
    return widget.projects!.isEmpty ? Center(child: Text('No Projects Yet')) : ListView.builder(
      itemCount: widget.projects!.length,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("project name:",style: TextStyle(
                  fontSize: 20,
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                ),),
                Text("${widget.projects![index].name!}"),
                Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                Text(" project description:",style: TextStyle(
                  fontSize: 20,
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                ),),
                Text("${widget.projects![index].description!}"),
                TextButton(
                    onPressed: () async {
                      final Uri _url = Uri.parse('https://flutter.dev');
                      // _url = Uri.parse(widget.projects![index].url!);
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                    },
                    child: Text('https://google.com')),
                Text(" project url:",style: TextStyle(
                  fontSize: 20,
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                ),),
                Text("${widget.projects![index].url!}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
