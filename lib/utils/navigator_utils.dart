import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 导航栏
/// Created by guoshuyu
/// Date: 2018-07-16
class NavigatorUtils {

  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
//    if (navigator == null) {
//      try {
//        navigator = Navigator.of(context);
//      } catch (e) {
//        error = true;
//      }
//    }
//
//    if (replace) {
//      ///如果可以返回，清空开始，然后塞入
//      if (!error && navigator.canPop()) {
//        navigator.pushAndRemoveUntil(
//          router,
//          ModalRoute.withName('/'),
//        );
//      } else {
//        ///如果不可返回，直接替换当前
//        navigator.pushReplacement(router);
//      }
//    } else {
//      navigator.push(router);
//    }
  }

  ///主页
  static goHome(BuildContext context) {
//    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  ///登录页
  static goLogin(BuildContext context) {
//    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }


  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }



  ///公共打开方式
  static navigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context,
        new MaterialPageRoute(builder: (context) => pageContainer(widget)));
  }

  ///Page页面的容器，做一次通用自定义
  static Widget pageContainer(widget) {
    return MediaQuery(

        ///不受系统字体缩放影响
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .copyWith(textScaleFactor: 1),
        child: widget);
  }

  ///弹出 dialog
  static Future<T> showDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(

              ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: new SafeArea(child: builder(context)));
        });
  }
}
