import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gankclient/config/config.dart';
import 'package:gankclient/event/http_error_event.dart';
import 'package:gankclient/local/local_storage.dart';
import 'package:gankclient/net/code.dart';
import 'package:gankclient/page/home_page.dart';
import 'package:gankclient/page/welcome_page.dart';
import 'package:gankclient/redux/application_state.dart';
import 'package:gankclient/style/style.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:redux/redux.dart';
import 'package:flutter/cupertino.dart';

import 'event/index.dart';
import 'localization/gsy_localizations_delegate.dart';

class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReduxApplicationState();
}

class _ReduxApplicationState extends State<Application> with HttpErrorListener {
  Store<ApplicationState> store;

  @override
  Widget build(BuildContext context) {
    // 使用 redux 状态共享时，最上层必须为 StoreProvider
    return new StoreProvider(
        store: store = new Store<ApplicationState>(
          appReducer,
          middleware: middleware,
          initialState:
              new ApplicationState(themeData: CommonUtils.getThemeData(0)),
        ),
        child: new StoreBuilder<ApplicationState>(builder: (context, store) {
          return new MaterialApp(theme: store.state.themeData,

              ///多语言实现代理
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GSYLocalizationsDelegate.delegate,
              ], routes: {
            WelcomePage.sName: (context) {
              ScreenUtil.init(context,
                  width: 750, height: 1334, allowFontScaling: false);
              return WelcomePage();
            },
            HomePage.sName: (context) {
              return HomePage();
            }
          });
        }));
  }
}

mixin HttpErrorListener on State<Application> {
  StreamSubscription stream;

  @override
  void initState() {
    super.initState();

    ///Stream演示event bus
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Fluttertoast.showToast(msg: "网络不可用");
        break;
      case 404:
        Fluttertoast.showToast(msg: "请求地址不存在");
        break;
      case Code.NETWORK_TIMEOUT:
        Fluttertoast.showToast(msg: "请求网络超时");
        break;
      default:
        Fluttertoast.showToast(msg: message);
        break;
    }
  }
}
