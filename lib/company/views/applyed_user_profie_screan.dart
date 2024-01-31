import 'package:flutter/material.dart';
import 'package:untitled10/SharedViews/ChatScreen.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/navigator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/company/company_model.dart';
import '../../data/users/education.dart';
import '../../data/users/projects.dart';
import '../../data/users/skills.dart';
import '../../data/users/work_experience.dart';

class ApplyedUserProfieScrean extends StatefulWidget {
  List<WorkExperience>? workExperience ;
  List <Education>?education;
  List<SKills>? skills  ;
  List<Projects>? projects  ;
  UserModel? userModel;

   ApplyedUserProfieScrean({Key? key, this.workExperience, this.education, this.skills, this.projects, this.userModel}) : super(key: key);

  @override
  State<ApplyedUserProfieScrean> createState() => _ApplyedUserProfieScreanState();
}

class _ApplyedUserProfieScreanState extends State<ApplyedUserProfieScrean>  with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5,vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        title: Text('User Profile'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: greenColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              print ('${ widget.userModel!.id}');
              print ('${ widget.userModel!.name}');
navigateToScreen(context, ChatScreen(userModel: widget.userModel,));
            },
            icon: Icon(Icons.chat),
          ),
        ],
        iconTheme: IconThemeData(
          color: greenColor, //
          // change your color here
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: grayColor,
          labelColor: greenColor,
          unselectedLabelColor: grayColor,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          onTap: (index) {
            _tabController.animateTo(index);
          },
          isScrollable: true,
          indicatorPadding: EdgeInsets.all(5),
          splashBorderRadius: BorderRadius.circular(10),
          tabs: [
            Tab(
              child: Text(
                'About',
                style: TextStyle(
                  color: greenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Work Experience',
                style: TextStyle(
                  color: greenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Education',
                style: TextStyle(
                  color: greenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Skills',
                style: TextStyle(
                  color: greenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Projects',
                style: TextStyle(
                  color: greenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: greenColor,
              width: 2,
            )
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(widget.userModel!.image!),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${widget.userModel!.name!}"),
                    Text("email : ${widget.userModel!.email!}"),
                    Text("phone number : ${widget.userModel!.phone!}"),
                    Text("address : ${widget.userModel!.address!}"),
                    Text("country : ${widget.userModel!.country!}"),
                    Text("Birth Date : ${widget.userModel!.date!}"),
                    Text("gender : ${widget.userModel!.gender!}"),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("info "),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: greenColor,
                    width: 2,
                  )
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" ${widget.userModel!.info!}"),
                  ],
                ),
              ),
            )



          ],
        ),

      ),
    )         ,

          ListView.builder(
            itemCount: widget.workExperience!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greenColor,
                      width: 2,
                    )
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("company: ${widget.workExperience![index].company!}"),
                      Text("position: ${widget.workExperience![index].position!}"),
                      Text(" start date: ${widget.workExperience![index].startDate!}"),
                      Text(" end date: ${widget.workExperience![index].endDate!}"),
                      Text(" period: ${widget.workExperience![index].period!}"),
                      Text(" description: ${widget.workExperience![index].description!}"),
                    ],
                  ),

                ),
              );
            },
          ),
          ListView.builder(
            itemCount: widget.education!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greenColor,
                      width: 2,
                    )
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("academic : ${widget.education![index].name!}"),
                      Text('degree: ${widget.education![index].degree!}'),
                      Text("from: ${widget.education![index].from!}"),
                      // Text(widget.education![index].to!),
                      Text(" description: ${widget.education![index].description!}"),

                    ],
                  ),

                ),
              );
            },
          ),
          ListView.builder(
            itemCount: widget.skills!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greenColor,
                      width: 2,
                    )
                  ),

                  height: 50,
                  child: Text(widget.skills![index].name!),

                ),
              );
            },
          ),
          ListView.builder(
            itemCount: widget.projects!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greenColor,
                      width: 2,
                    )
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("project name: ${widget.projects![index].name!}"),
                      Text(" project description: ${widget.projects![index].description!}"),
                      TextButton(onPressed: () async{
                        final Uri _url = Uri.parse('https://flutter.dev');
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }


                      }, child: Text('https://google.com')),

                      Text(" project url: ${widget.projects![index].url!}"),

                    ],
                  ),

                ),
              );
            },
          ),


        ],
      ),



    );
  }
}
