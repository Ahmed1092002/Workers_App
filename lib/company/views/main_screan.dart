import 'dart:async';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
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


const List<TabItem> items = [
  TabItem(
    icon: Ionicons.home,
    title: 'Home',
  ),
  TabItem(
    icon: Ionicons.chatbox,
    title: 'chat',
  ),
  TabItem(
    icon: Ionicons.search,
    title: 'Search',
  ),
  TabItem(
    icon: Ionicons.person,
    title: 'Profile',
  ),
];


class CompanyMainScrean extends StatefulWidget {
  const CompanyMainScrean({Key? key}) : super(key: key);

  @override
  _CompanyMainScreanState createState() => _CompanyMainScreanState();
}

class _CompanyMainScreanState extends State<CompanyMainScrean> {
  var box = Hive.box(boxName);
  var storage = FlutterSecureStorage();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectivityStatus = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
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

  int visit = 0;
  double height = 30;
  Color colorSelect = const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
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


                  PopupMenuItem(
                      child: Column(
                    children: [
                      Text(
                        'Change Password',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Divider(
                        color: grayColor,
                      )
                    ],
                  )),

                  PopupMenuItem(
                    onTap: () async {
                      final googleSignIn = GoogleSignIn();
                      final signedInAccounts = googleSignIn.currentUser?.email;

                      if (signedInAccounts != null &&
                          signedInAccounts.contains(await box.get('email'))) {
                        await googleSignIn.signOut();
                        await googleSignIn.disconnect();
                      }
                      await storage.deleteAll();
                      await box.clear();
                      await FirebaseAuth.instance.signOut();

                      navigateToScreen(context, LoginScrean());
                    },
                    child: Column(
                      children: [
                        Text(
                          'Log Out',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Divider(
                          color: grayColor,
                        )
                      ],
                    ),
                  ),
                ]);
          },
          icon: Icon(Ionicons.menu_outline),
        ),
        actions: [

          IconButton(
            onPressed: () {
              navigateToScreen(
                  context,
                  AddNewJopContainer(
                    title: 'Add New Jop',
                  ));
            },
            icon: Icon(Ionicons.add_circle_outline, color: greenColor),
          ),
        ],
      ),
      body: bodies[_selectedTab],
      bottomNavigationBar: BottomBarInspiredOutside(
        items: items,
        backgroundColor: Color(0xFFD8D8D8),
        color: grayColor,
        isAnimated: true,
        curve: Curves.easeInOutCubic,
        colorSelected: Colors.white,
        indexSelected: _selectedTab,
        onTap: (int index) => setState(() {
          _selectedTab = index;
        }),
        top: -25,
        chipStyle: ChipStyle(
          color: Colors.white,
          background: greenColor,
        ),
        radius: 30,
        animated: true,
        itemStyle: ItemStyle.circle,
      ),
    );
  }
}

