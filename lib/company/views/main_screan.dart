import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:untitled10/SharedViews/chat_bpdy.dart';
import 'package:untitled10/SharedViews/login_screan.dart';
import 'package:untitled10/company/views/add_new_jop_container.dart';
import 'package:untitled10/company/views/edit_profile_company.dart';
import 'package:untitled10/company/views/profilebody.dart';
import 'package:untitled10/main.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/navigator.dart';
import '../../user/views/search_body.dart';
import 'home_body.dart';

class CompanyMainScrean extends StatefulWidget {
  const CompanyMainScrean({Key? key}) : super(key: key);

  @override
  _CompanyMainScreanState createState() => _CompanyMainScreanState();
}

class _CompanyMainScreanState extends State<CompanyMainScrean> {
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);
  final _controller15 = ValueNotifier<bool>(false);
  var box = Hive.box(boxName);
  var storage =FlutterSecureStorage();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectivityStatus = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityStatus = result;
      });
    });
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  List bodies = [
    CompanyHomeBody(),
    Center(
      child: ChatBody(),
    ),
    SearchBody(),
    Center(
      child: CompanyProfilebody(),
    ),
  ];
  var _selectedTab = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
  extendBody: true,

  appBar: AppBar(
    leading: IconButton(
      onPressed: () {
        showMenu(
            context: context,

            position: RelativeRect.fromLTRB(0, 70, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            useRootNavigator: true,
            color: backgroundColor,


            items: [

              // PopupMenuItem(
              //   child: Column(
              //     children: [
              //       Row(
              //
              //         children: [
              //           Text('Switch Mode'),
              //           AdvancedSwitch(
              //             activeChild: Icon(
              //               Icons.terrain,
              //               color: Colors.blue,
              //             ),
              //
              //             inactiveChild: Icon(Icons.cloud),
              //             activeColor: Colors.yellowAccent,
              //             inactiveColor: Colors.deepPurple,
              //             width: 60,
              //             borderRadius: BorderRadius.circular(5),
              //
              //             controller: _controller15,
              //           ),
              //
              //
              //         ],
              //       ),
              //       Divider(
              //         color: grayColor,
              //       )
              //     ],
              //   ),
              // ),
              PopupMenuItem(
                  onTap: ()  {


                    navigateToScreen(context, EditProfileCompany()  );
                  },
                  child: Column(
                    children: [
                      Text('edit profile'),
                      Divider(
                        color: grayColor,
                      )
                    ],
                  )),
              PopupMenuItem(child: Column(
                children: [
                  Text('Change Password'),
                  Divider(
                    color: grayColor,
                  )
                ],
              )),

              PopupMenuItem(
                onTap: () async {
                  final googleSignIn = GoogleSignIn();
                  final signedInAccounts = googleSignIn.currentUser?.email;

                  if (signedInAccounts != null && signedInAccounts.contains(await box.get('email'))) {

                    await googleSignIn.signOut();
                    await googleSignIn.disconnect();
                  }
                  await storage.deleteAll();
                  await  box.clear();
                  await FirebaseAuth.instance.signOut();


                  navigateToScreen(context, LoginScrean());
                },
                child: Column(
                  children: [
                    Text('Log Out'),
                    Divider(
                      color: grayColor,
                    )
                  ],
                ),
              ),

            ]);
      },
      icon: Icon(Icons.menu),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.notifications),
      ),
      IconButton(
        onPressed: () {
          navigateToScreen(context, AddNewJopContainer(
            title: 'Add New Jop',
          ));
        },
        icon: Icon(Icons.add),
      ),
    ],
  ),
  body: bodies[_selectedTab],
  bottomNavigationBar: Padding(
    padding: EdgeInsets.only(
      bottom: 20,
    ),
    child: DotNavigationBar(
      paddingR: EdgeInsets.all(5),
      marginR: EdgeInsets.all(1),
      currentIndex: _selectedTab,
      dotIndicatorColor: grayColor,
      backgroundColor: Color(0xFFD8D8D8),
      unselectedItemColor: grayColor,
      enableFloatingNavBar: true,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      borderRadius: 30,
      selectedItemColor: greenColor,
      onTap: _handleIndexChanged,
      items: [
        /// Home
        DotNavigationBarItem(
          icon: Icon(Icons.home),
        ),

        /// Likes
        DotNavigationBarItem(
          icon: Icon(Icons.chat),
        ),

        /// Search
        DotNavigationBarItem(
          icon: Icon(Icons.search),
        ),

        /// Profile
        DotNavigationBarItem(
          icon: Icon(Icons.person),
        ),
      ],
    ),
  ),
);
    // return StreamBuilder<ConnectivityResult>(
    //     stream: Connectivity().onConnectivityChanged,
    //   builder: (context, snapshot) {
    //       if (snapshot.hasData){
    //         final ConnectivityResult connectivityResult = snapshot.data!;
    //         if (connectivityResult == ConnectivityResult.wifi) {
    //           return Scaffold(
    //             extendBody: true,
    //
    //             appBar: AppBar(
    //               leading: IconButton(
    //                 onPressed: () {
    //                   showMenu(
    //                       context: context,
    //
    //                       position: RelativeRect.fromLTRB(0, 70, 0, 0),
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(10),
    //                       ),
    //                       useRootNavigator: true,
    //                       color: backgroundColor,
    //
    //
    //                       items: [
    //
    //                         // PopupMenuItem(
    //                         //   child: Column(
    //                         //     children: [
    //                         //       Row(
    //                         //
    //                         //         children: [
    //                         //           Text('Switch Mode'),
    //                         //           AdvancedSwitch(
    //                         //             activeChild: Icon(
    //                         //               Icons.terrain,
    //                         //               color: Colors.blue,
    //                         //             ),
    //                         //
    //                         //             inactiveChild: Icon(Icons.cloud),
    //                         //             activeColor: Colors.yellowAccent,
    //                         //             inactiveColor: Colors.deepPurple,
    //                         //             width: 60,
    //                         //             borderRadius: BorderRadius.circular(5),
    //                         //
    //                         //             controller: _controller15,
    //                         //           ),
    //                         //
    //                         //
    //                         //         ],
    //                         //       ),
    //                         //       Divider(
    //                         //         color: grayColor,
    //                         //       )
    //                         //     ],
    //                         //   ),
    //                         // ),
    //                         PopupMenuItem(
    //                             onTap: ()  {
    //
    //
    //                               navigateToScreen(context, EditProfileCompany()  );
    //                             },
    //                             child: Column(
    //                               children: [
    //                                 Text('edit profile'),
    //                                 Divider(
    //                                   color: grayColor,
    //                                 )
    //                               ],
    //                             )),
    //                         PopupMenuItem(child: Column(
    //                           children: [
    //                             Text('Change Password'),
    //                             Divider(
    //                               color: grayColor,
    //                             )
    //                           ],
    //                         )),
    //
    //                         PopupMenuItem(
    //                           onTap: () async {
    //                             final googleSignIn = GoogleSignIn();
    //                             final signedInAccounts = googleSignIn.currentUser?.email;
    //
    //                             if (signedInAccounts != null && signedInAccounts.contains(await box.get('email'))) {
    //
    //                               await googleSignIn.signOut();
    //                               await googleSignIn.disconnect();
    //                             }
    //                             await storage.deleteAll();
    //                             await  box.clear();
    //                             await FirebaseAuth.instance.signOut();
    //
    //
    //                             navigateToScreen(context, LoginScrean());
    //                           },
    //                           child: Column(
    //                             children: [
    //                               Text('Log Out'),
    //                               Divider(
    //                                 color: grayColor,
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //
    //                       ]);
    //                 },
    //                 icon: Icon(Icons.menu),
    //               ),
    //               actions: [
    //                 IconButton(
    //                   onPressed: () {},
    //                   icon: Icon(Icons.notifications),
    //                 ),
    //                 IconButton(
    //                   onPressed: () {
    //                     navigateToScreen(context, AddNewJopContainer(
    //                       title: 'Add New Jop',
    //                     ));
    //                   },
    //                   icon: Icon(Icons.add),
    //                 ),
    //               ],
    //             ),
    //             body: bodies[_selectedTab],
    //             bottomNavigationBar: Padding(
    //               padding: EdgeInsets.only(
    //                 bottom: 20,
    //               ),
    //               child: DotNavigationBar(
    //                 paddingR: EdgeInsets.all(5),
    //                 marginR: EdgeInsets.all(1),
    //                 currentIndex: _selectedTab,
    //                 dotIndicatorColor: grayColor,
    //                 backgroundColor: Color(0xFFD8D8D8),
    //                 unselectedItemColor: grayColor,
    //                 enableFloatingNavBar: true,
    //                 duration: Duration(milliseconds: 500),
    //                 curve: Curves.easeInOutCubic,
    //                 borderRadius: 30,
    //                 selectedItemColor: greenColor,
    //                 onTap: _handleIndexChanged,
    //                 items: [
    //                   /// Home
    //                   DotNavigationBarItem(
    //                     icon: Icon(Icons.home),
    //                   ),
    //
    //                   /// Likes
    //                   DotNavigationBarItem(
    //                     icon: Icon(Icons.chat),
    //                   ),
    //
    //                   /// Search
    //                   DotNavigationBarItem(
    //                     icon: Icon(Icons.search),
    //                   ),
    //
    //                   /// Profile
    //                   DotNavigationBarItem(
    //                     icon: Icon(Icons.person),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //
    //         }else {
    //           return Scaffold(
    //             body: Center(
    //               child: Text('No WiFi connection'),
    //             ),
    //           );
    //         }
    //
    //
    //
    //
    //         }else {
    //           return Scaffold(
    //             body: Center(
    //               child: Text('No Internet connection'),
    //             ),
    //           );
    //         }
    //   }
    // );
  }
}
