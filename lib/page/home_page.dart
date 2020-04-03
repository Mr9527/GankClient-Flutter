import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gankclient/page/information_page.dart';
import 'package:gankclient/style/style.dart';

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
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(GankIcons.home),
            activeIcon: Icon(GankIcons.homeFill),
            title: Text("首页",
                style:
                    TextStyle(fontSize: 14, color: ThemeColors.mainTextColor))),
        BottomNavigationBarItem(
            icon: Icon(GankIcons.news),
            activeIcon: Icon(GankIcons.newsFill),
            title: Text("资讯",
                style:
                    TextStyle(fontSize: 14, color: ThemeColors.mainTextColor)))
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  Widget _pageView() {
    return PageView(
        children: <Widget>[InformationPage(key: informationPageKey)],
        scrollDirection: Axis.horizontal,
        reverse: false,
        controller: _pageController,
        onPageChanged: _pageChanged,
        // 禁止滑动
        physics: new NeverScrollableScrollPhysics());
  }

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
          resizeToAvoidBottomPadding: true,
          body: _pageView(),
          bottomNavigationBar: _tabLayout(),
        ));
  }

  void _onItemTapped(int position) {
    _pageController.jumpTo(MediaQuery.of(context).size.width * position);
    setState(() {
      _selectedIndex = position;
    });
  }

  void _pageChanged(int position) {
    Fluttertoast.showToast(msg: position.toString());
  }
}
