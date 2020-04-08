import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gankclient/model/article_model.dart';
import 'package:gankclient/model/banner_model.dart';
import 'package:gankclient/page/information/InformationBloc.dart';
import 'package:gankclient/redux/application_state.dart';
import 'package:gankclient/style/style.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:gankclient/widget/article_list_item.dart';
import 'package:gankclient/widget/banner_widget.dart';
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
          return ArticleListItem(model: bloc.dataList[index]);
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
        return <Widget>[
          SliverPersistentHeader(
              pinned: true,
              delegate: GSYSliverHeaderDelegate(
                  minHeight: bannerHeight,
                  maxHeight: bannerHeight,
                  snapConfig: FloatingHeaderSnapConfiguration(
                    vsync: this,
                    curve: Curves.bounceInOut,
                    duration: const Duration(milliseconds: 10),
                  ),
                  builder: (BuildContext context, double shrinkOffset,
                      bool overlapsContent) {
                    return Transform.translate(
                      offset: Offset(0, -shrinkOffset),
                      child: SizedBox.expand(
                        child: Container(child: _banner()),
                      ),
                    );
                  }))
        ];
      },
    );
    return Scaffold(body: Container(child: content));
  }

  /* Column(
  children: <Widget>[
  _banner(),
  StreamBuilder<List<ArticleModel>>(
  stream: bloc.articleList,
  builder: (context, snapShot) {
  if (snapShot != null && snapShot.data != null) {
  var list = snapShot.data;
  return ListView.builder(
  shrinkWrap: true,
  itemExtent: 265.w,
  itemCount: list.length,
  itemBuilder: (context, index) {
  return ArticleListItem(model:list[index]);
  });
  } else {
  return Container();
  }
  },
  ),
  FlatButton(onPressed: _switchThemes, child: Text("切换主题"))
  ],
  )*/

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
}
