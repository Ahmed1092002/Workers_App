import 'dart:async';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stylish_bottom_bar/helpers/bottom_bar.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:untitled10/SharedViews/chat_bpdy.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/user/views/applyed_jops.dart';
import 'package:untitled10/user/views/profilebody.dart';
import 'package:untitled10/user/views/search_body.dart';
import 'package:untitled10/user/views/settings_screan.dart';

import '../../SharedViews/login_screan.dart';
import '../../main.dart';
import '../../utils/navigator.dart';
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


class MainScrean extends StatefulWidget {
  const MainScrean({Key? key}) : super(key: key);

  @override
  _MainScreanState createState() => _MainScreanState();
}

class _MainScreanState extends State<MainScrean> {
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
  Center(
    child: HomeBody(),
  ),
  Center(
    child: ChatBody(),
  ),
  SearchBody(),
  Center(
    child: Profilebody(),
  ),
];
  var _selectedTab = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }
  final _controller15 = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
return Scaffold(
  extendBody: true,
  resizeToAvoidBottomInset: false,
  appBar: AppBar(
    backgroundColor: backgroundColor,
    leading: IconButton(
      onPressed: () {

        showMenu(context: context,
            position: RelativeRect.fromLTRB(0, 70, 0, 0),
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),

            ),
            useRootNavigator: true,
            items:[



              PopupMenuItem(
                onTap: (){
                  navigateToScreen(context, SettingsScrean());
                },
                child:  Column(
                  children: [
                    Text('Settings',),
                    Divider(
                      color: grayColor,
                    )
                  ],
                ),),

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

            ] );
      },
      icon: Icon(Ionicons.menu_outline),
    ),

    actions: [
      IconButton(
        onPressed: () {
        },
        color: greenColor,
        icon: Icon(Ionicons.notifications_outline),
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

// floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// bottomNavigationBar: AnimatedBottomNavigationBar(
// icons: [
// Ionicons.home_outline,
//
// Ionicons.person_outline,
// ],
// activeIndex: _selectedTab,
// gapLocation: GapLocation.center,
// backgroundColor: Color(0xFFD8D8D8),
// activeColor: greenColor,
// inactiveColor: grayColor,
// iconSize: 30,
// splashColor: greenColor,
//
//
//
// leftCornerRadius: 32,
// rightCornerRadius: 32,
// onTap: (index) => _handleIndexChanged(index),
//
// //other params
// ),
// floatingActionButton: FloatingActionButton(
// shape: CircleBorder(
//
// eccentricity: 0.5,
//
//
//
// ),
//
//
// onPressed: () {
// navigateToScreen(context, ChatBody());
// },
// child: Icon(Ionicons.search_outline, color: backgroundColor,),
// backgroundColor: greenColor,
// ),
// floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
