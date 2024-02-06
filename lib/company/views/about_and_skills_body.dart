import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled10/SharedViews/ChatScreen.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/navigator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/company/company_model.dart';
import '../../data/users/education.dart';
import '../../data/users/projects.dart';
import '../../data/users/skills.dart';
import '../../data/users/work_experience.dart';

class AboutAndSkillsBody extends StatefulWidget {
  UserModel? userModel;
  List<SKills>? skills;
   AboutAndSkillsBody({
    super.key,
    this.userModel,
    this.skills,
  });

  @override
  State<AboutAndSkillsBody> createState() => _AboutAndSkillsBodyState();
}

class _AboutAndSkillsBodyState extends State<AboutAndSkillsBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: greenColor,
                width: 2,
              )),
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height/1.5 ,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: greenColor,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "${widget.userModel!.image}",
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                        radius: 50,
                      ),
                      placeholder: (context, url) => LoadingAnimationWidget.twoRotatingArc(
                        color: greenColor,
                        size: 100,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Ionicons.person_outline,
                            color: greenColor,
                            size: 30,
                          ),
                          Text(
                            "${widget.userModel!.name!}",
                            style: TextStyle(
                              color: greenColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Ionicons.mail_outline,
                            color: greenColor,
                            size: 30,
                          ),
                          Text("${widget.userModel!.email!}"),
                        ],
                      ),
                      Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Ionicons.call_outline,
                                    color: greenColor,
                                    size: 30,
                                  ),
                                  Text("${widget.userModel!.phone!}"),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Ionicons.location_outline,
                                    color: greenColor,
                                    size: 30,
                                  ),
                                  Text("${widget.userModel!.address!}"),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Ionicons.globe_outline,
                                    color: greenColor,
                                    size: 30,
                                  ),
                                  Text("${widget.userModel!.country!}"),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Ionicons.calendar_outline,
                                    color: greenColor,
                                    size: 30,
                                  ),
                                  Text("${widget.userModel!.date!}"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border.all(
                              color: greenColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Ionicons.man_outline,
                                color: greenColor,
                                size: 30,
                              ),
                              Text("${widget.userModel!.gender!}"),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "info ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(" ${widget.userModel!.info!}"),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                "Skills",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  for (var skill in widget.skills!)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          border: Border.all(color: greenColor),
                        ),
                        child: Text('${skill.name}'),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
