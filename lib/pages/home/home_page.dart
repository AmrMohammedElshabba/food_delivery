import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_history_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/profile/profile_page.dart';
import 'package:food_delivery/utlis/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'main_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;



  List<Widget> _buildScreens() {
    return [
      MainHomePage(),
      CartHistory(),
      SignUpPage(),
      ProfilePage()
    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.home,
        ),
        title: "Home",
        activeColorPrimary: KmainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: "history",
        activeColorPrimary: KmainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox),
        title: "Carts",
        activeColorPrimary: KmainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
       PersistentBottomNavBarItem(
         icon: Icon(CupertinoIcons.person),
         title: "me",
         activeColorPrimary: KmainColor,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
    ];
  }

@override
  void initState() {
    // TODO: implement initState
  _controller = PersistentTabController(initialIndex: 0);
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style5, // Choose the nav bar style with this property.
    );
  }
}

