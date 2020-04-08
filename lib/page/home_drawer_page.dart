import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gankclient/config/config.dart';
import 'package:gankclient/local/local_storage.dart';
import 'package:gankclient/redux/application_state.dart';
import 'package:gankclient/style/style.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:gankclient/widget/native_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDrawerPage extends StatefulWidget {
  static const List<String> items = ["首页", "妹纸", "设置", "API", "留言"];

  @override
  State<StatefulWidget> createState() => _HomeDrawerPageState();
}

class _HomeDrawerPageState extends State<HomeDrawerPage> {
  var status = LocalStorage.get(Config.THEME_COLOR);

  @override
  Widget build(BuildContext context) {
    var head = Stack(children: <Widget>[
      NativeImage("gank_head_persona_background"),
      Positioned(
          top: 25.w,
          right: 0,
          child: IconButton(
              icon: NativeImage(status==0?"light_logo":"dark_logo"), onPressed: _switchThemes)),
      Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 200.w),
          child: SizedBox(width: 540.w, height: 160.w, child: Card())),
      SizedBox(
        width: 550.w,
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 130.w)),
            Container(
                width: 150.w,
                height: 150.w,
                child: ClipOval(
                    child: NativeImage("gank_home_persona_normal_header"))),
            Padding(padding: EdgeInsets.only(top: 10.w)),
            SizedBox(
              width: 140.w,
              height: 50.w,
              child: FlatButton(
                onPressed: () {},

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.w)),
//                borderSide: BorderSide(color: Colors.blue),
                textColor: Colors.blue,
                padding: EdgeInsets.only(top: 0),
                child: Text("立即登录"),
              ),
            )
          ],
        ),
      ),
    ]);
    var textStyle = Theme.of(context).textTheme.display2;
    var list = Container(
        margin: EdgeInsets.only(top: 15.w),
        child: Card(
            child: ListView.builder(
          shrinkWrap: true,
          padding: new EdgeInsets.all(5.0),
          itemExtent: 40,
          itemCount: HomeDrawerPage.items.length,
          itemBuilder: (BuildContext context, int index) {
            return FlatButton(
                onPressed: () => _listClick(index),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: new Text(HomeDrawerPage.items[index],
                        style: textStyle)));
          },
        )));
    return BackdropFilter(
        //高斯模糊
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Theme.of(context).backgroundColor,
          width: 550.w,
          child: Column(
            children: <Widget>[head, list],
          ),
        ));
  }

  _switchThemes() {
    var store = StoreProvider.of<ApplicationState>(context);
    CommonUtils.pushTheme(store, status == 0 ? status = 1 : status = 0);
    setState(() {});
  }

  _listClick(int index) {
    Fluttertoast.showToast(msg: index.toString());
  }
}
