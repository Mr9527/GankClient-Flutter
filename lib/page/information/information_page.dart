import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gankclient/model/article_model.dart';
import 'package:gankclient/model/banner_model.dart';
import 'package:gankclient/page/gank_article_detail/gank_article_detail_page.dart';
import 'package:gankclient/page/information/InformationBloc.dart';
import 'package:gankclient/redux/application_state.dart';
import 'package:gankclient/style/style.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:gankclient/widget/article_list_item.dart';
import 'package:gankclient/widget/banner_widget.dart';
import 'package:gankclient/widget/native_image.dart';
import 'package:gankclient/widget/pull/gsy_nested_pull_load_widget.dart';
import 'package:gankclient/widget/pull/gsy_pull_new_load_widget.dart';
import 'package:gankclient/widget/pull/gsy_sliver_header_delegate.dart';
import 'package:provider/provider.dart';

class InformationPage extends StatefulWidget {
  InformationPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage>
    with
        AutomaticKeepAliveClientMixin<InformationPage>,
        WidgetsBindingObserver,
        SingleTickerProviderStateMixin {
  final InformationBloc bloc = new InformationBloc();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var content = GSYNestedPullLoadWidget(
      bloc.pullLoadWidgetControl,
      (context, index) {
        if (bloc.dataList != null && bloc.dataList.length > 0) {
          return ArticleListItem(
            index: index,
            model: bloc.dataList[index],
            onTap: (index, model) {
              pushPage(context, GankArticleDetailPage(indexModel: model));
            },
          );
        } else {
          return Container();
        }
      },
      requestRefresh,
      requestLoadMore,
      scrollController: new ScrollController(),
      refreshKey: refreshIndicatorKey,
      headerSliverBuilder: (context, _) {
        var bannerHeight = 400.w;
        var commonSnapConfig = FloatingHeaderSnapConfiguration(
            vsync: this,
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10));
        return <Widget>[
          SliverPersistentHeader(
              pinned: false,
              delegate: GSYSliverHeaderDelegate(
                  minHeight: bannerHeight,
                  maxHeight: bannerHeight,
                  child: Container(
                    child: _banner(),
                  ),
                  snapConfig: commonSnapConfig)),
          SliverPadding(padding: EdgeInsets.only(top: 10.w)),
          SliverPersistentHeader(
              pinned: false,
              delegate: GSYSliverHeaderDelegate(
                  minHeight: 180.w,
                  maxHeight: 180.w,
                  child: Container(
                    child: _menu(),
                  ),
                  snapConfig: commonSnapConfig)),
          SliverPersistentHeader(
              pinned: false,
              delegate: GSYSliverHeaderDelegate(
                  minHeight: 80.w,
                  maxHeight: 80.w,
                  child: Container(
                    child: _listTitle(),
                  ),
                  snapConfig: commonSnapConfig)),
        ];
      },
    );
    return Container(child: content);
  }

  Widget _menu() {
    return Container(
        color: Theme.of(context).cardTheme.color,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _menuItem("留言板", "quan", () {}),
            _menuItem("看一看", "shusvg", () {}),
            _menuItem("版本进度", "shujubaobiao", () {}),
          ],
        ));
  }

  _menuItem(title, imageUrl, onPressed) {
    return Expanded(
        child: FlatButton(
            onPressed: onPressed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                NativeImage(
                  imageUrl,
                  width: 64.w,
                  height: 64.w,
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                Text(title),
                Spacer(),
              ],
            )));
  }

  void pushPage(BuildContext context, Widget page, {String pageName}) {
    if (context == null || page == null) return;
    Navigator.push(context, CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  ///上拉更多请求数据
  Future<void> requestLoadMore() async {
    return await bloc.requestLoadMore();
  }

  ///上拉更多请求数据
  Future<void> requestRefresh() async {
    return await bloc.refreshList();
  }

  @override
  void didChangeDependencies() {
    if (!bloc.requested) {
      bloc.requestRefresh();
      bloc.refreshList();
    }
    super.didChangeDependencies();
  }

  _banner() {
    return StreamBuilder<List<BannerModel>>(
        stream: bloc.stream,
        builder: (context, snapShot) {
          if (snapShot != null && snapShot.data != null) {
            return BannerWidget(
                bannerDataList: snapShot.data,
                looperDuration: Duration(seconds: 5),
                listener: (model) {});
          } else {
            return Container();
          }
        });
  }

  @override
  bool get wantKeepAlive => true;

  _listTitle() {
    return Column(children: <Widget>[
      Divider(height: 1.w),
      Expanded(
          child: Container(
        color: Theme.of(context).cardTheme.color,
//      margin: EdgeInsets.symmetric(horizontal: 15.w),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: NativeImage("redian")),
            Text(
              "热门文章",
              style: Theme.of(context).textTheme.display2,
            ),
            Spacer(),
            FlatButton(
              onPressed: () {},
              child: Row(children: <Widget>[
                Icon(
                  GankIcons.settings,
                  size: 32.w,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2.w)),
                Text("配置热门", style: Theme.of(context).textTheme.display3)
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.w),
            )
          ],
        ),
      )),
    ]);
  }
}
