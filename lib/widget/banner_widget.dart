import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gankclient/model/banner_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gankclient/style/style.dart';

typedef void TapItemClickListener(BannerModel item);

class BannerWidget extends StatefulWidget {
  final List<BannerModel> bannerDataList;
  final TapItemClickListener listener;
  final Duration looperDuration;

  BannerWidget(
      {Key key, this.bannerDataList, this.listener, this.looperDuration})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new _BannerState();
}

class _BannerState extends State<BannerWidget> {
  PageController controller;
  int realIndex = 1;
  int virtualIndex = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: realIndex);
    timer = Timer.periodic(widget.looperDuration, (timer) {
      controller.animateToPage(realIndex + 1,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    timer.cancel();
  }

  /// pagination 的计数器
  Widget _numberIndicator() {
    return Positioned(
        top: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
          margin: EdgeInsets.only(top: 10.0, right: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          child: Text("${++virtualIndex}/${widget.bannerDataList.length}",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.w,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[_pageView(), _indicators(), _numberIndicator()],
      ),
    );
  }

  Widget _pageView() {
    return PageView(
      controller: controller,
      onPageChanged: _pageChanged,
      children: _buildItems(),
    );
  }

  Widget _indicators() {
    var indicators = new List<Widget>();
    for (int i = 0; i < widget.bannerDataList.length; i++) {
      var item = Container(
        width: i == virtualIndex ? 30.w : 25.w,
        height: 3.0,
        margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 2.w),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: i == virtualIndex ? Colors.white : Colors.grey[400]),
      );
      indicators.add(item);
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: indicators);
  }

  void _pageChanged(int index) {
    realIndex = index;
    int count = widget.bannerDataList.length;
    if (index == 0) {
      virtualIndex = count - 1;
      controller.jumpToPage(count);
    } else if (index == count + 1) {
      virtualIndex = 0;
      controller.jumpToPage(1);
    } else {
      virtualIndex = index - 1;
    }
    setState(() {});
  }

  List<Widget> _buildItems() {
    var items = new List<Widget>();
    if (widget.bannerDataList.length > 0) {
      // 头部添加一个尾部Item，模拟循环
      items.add(
          _buildItem(widget.bannerDataList[widget.bannerDataList.length - 1]));
      /*   // 正常添加Item
      var list = widget.bannerDataList
          .map((story) => _buildItem(story))
      .toList();*/
      for (var i = 0; i < widget.bannerDataList.length; i++) {
        var model = widget.bannerDataList[i];
        items.add(_buildItem(model));
      }
      // 尾部
      items.add(_buildItem(widget.bannerDataList[0]));
    }
    return items;
  }

  _buildItem(BannerModel model) {
    return GestureDetector(
      onTap: () {
        if (widget.listener != null) {
          widget.listener(model);
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(model.image, fit: BoxFit.cover),
          _buildItemTitle(model.title),
        ],
      ),
    );
  }

  _buildItemTitle(String title) {
    return Container(
      /* decoration: BoxDecoration(
        /// 背景的渐变色
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: const Alignment(0.0, -0.8),
          colors: [const Color(0xa0000000), Colors.transparent],
        ),
      ),*/
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
        child: Text(
          title,
          style: TextStyle(color: ThemeColors.white,fontSize: 30.sp,letterSpacing: 2.w),
        ),
      ),
    );
  }
}
