import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gankclient/redux/application_state.dart';
import 'package:gankclient/style/style.dart';
import 'package:gankclient/utils/common_utils.dart';

class InformationPage extends StatefulWidget {
  InformationPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage>
    with
        AutomaticKeepAliveClientMixin<InformationPage>,
        WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          _card(),
          FlatButton(onPressed: _switchThemes, child: Text("切换主题"))
        ],
      )),
    );
  }

  var status = 0;

  _switchThemes() {
    var store = StoreProvider.of<ApplicationState>(context);
    CommonUtils.pushTheme(store, status == 0 ? status = 1 : status = 0);
  }

  _card() {
    return Container(
        height: 250.w,
        padding: EdgeInsets.all(15.w),
        child: Card(
            elevation: 1,
            child: Container(margin: EdgeInsets.all(10.w), child: _content())));
  }

  _content() => Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Image.network(
                "https://gank.io/images/ee1749f1a83a497ab433eab0ca89ac90/crop/1/w/100"),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(5.w, 2.w, 2.w, 5.w),
                        color: ThemeColors.label,
                        child: Text("Android",
                            style: TextStyle(color: ThemeColors.white))),
                    Padding(padding: EdgeInsets.only(left: 15.w)),
                    Text(
                      "douyinloadingview",
                      style: GankTextStyle.normalText,
                    )
                  ]),
              Padding(padding: EdgeInsets.only(top: 20.w)),
              Expanded(
                  child: Text(
                "仿 android 安卓抖音 v2.5 加载控件",
                overflow: TextOverflow.ellipsis,
                style: GankTextStyle.middleText,
              )),
              SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.network(
                      "https://gank.io/images/8edfa6bca6c643b3ba3f7cec56780377",
                      width: 32.w,
                      height: 32.w,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Text("李金山", style: GankTextStyle.smallSubText)),
                    Text("—", style: TextStyle(color: ThemeColors.label)),
                    Expanded(
                      child: Text("Android", style: GankTextStyle.smallText),
                    ),
                    Text("1天前更新", style: GankTextStyle.smallSubText)
                  ],
                ),
              )
            ],
          ))
        ],
      );

  @override
  bool get wantKeepAlive => true;
}
