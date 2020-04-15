import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gankclient/page/category/category_page.dart';
import 'package:gankclient/page/girl/girl_page.dart';
import 'package:gankclient/page/home_drawer_page.dart';
import 'package:gankclient/page/information/information_page.dart';
import 'package:gankclient/page/personal/personal_center_page.dart';
import 'package:gankclient/style/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gankclient/widget/draglike/drag_like.dart';

class HomePage extends StatefulWidget {
  static final String sName = "home";

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<InformationPageState> informationPageKey = new GlobalKey();

  final PageController _pageController = PageController();

  var _selectedIndex = 0;

  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
    return Future.value(false);
  }

  Widget _tabLayout() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: navigationItems(),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  List<BottomNavigationBarItem> navigationItems() {
    var textStyle = Theme.of(context).textTheme.display3;
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(GankIcons.home),
          activeIcon: Icon(GankIcons.homeFill),
          title: Text("首页", style: textStyle)),
      BottomNavigationBarItem(
          icon: Icon(GankIcons.search),
          activeIcon: Icon(GankIcons.searchFill),
          title: Text("发现", style: textStyle)),
      BottomNavigationBarItem(
          icon: Icon(GankIcons.girl),
          activeIcon: Icon(GankIcons.girlFill),
          title: Text("妹纸", style: textStyle)),
      BottomNavigationBarItem(
          icon: Icon(GankIcons.my),
          activeIcon: Icon(GankIcons.myFill),
          title: Text("我的", style: textStyle)),
    ];
  }

/*
  Widget _pageView() {
    return PageView(
        children: _pageChildren(),
        scrollDirection: Axis.horizontal,
        reverse: false,
        controller: _pageController,
        onPageChanged: _pageChanged,
        // 禁止滑动
        physics: new NeverScrollableScrollPhysics());
  }
*/

  List<Widget> _pageChildren() => <Widget>[
        CategoryPage(),
        InformationPage(key: informationPageKey),
//        GirlPage(),
        DragLikePage(),
        PersonalCenterPage(),
      ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return _dialogExitApp(context);
        },
        child: Scaffold(
          drawer: HomeDrawerPage(),
          resizeToAvoidBottomPadding: true,
          body: IndexedStack(
            index: _selectedIndex,
            children: _pageChildren(),
          ),
          bottomNavigationBar: _tabLayout(),
        ));
  }

  void _onItemTapped(int position) {
    setState(() {
      _selectedIndex = position;
    });
  }

  void _pageChanged(int position) {
    Fluttertoast.showToast(msg: position.toString());
  }
}
