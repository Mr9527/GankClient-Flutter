import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gankclient/localization/default_localizations.dart';
import 'package:provider/provider.dart';

import 'gsy_pull_new_load_widget.dart';
import 'nested_refresh.dart';

///通用下上刷新控件
class GSYNestedPullLoadWidget<T> extends StatefulWidget {
  ///item渲染
  final IndexedWidgetBuilder itemBuilder;

  ///加载更多回调
  final RefreshCallback onLoadMore;

  ///下拉刷新回调
  final RefreshCallback onRefresh;

  ///控制器，比如数据和一些配置
  final GSYPullLoadWidgetControl control;

  final Key refreshKey;
  final NestedScrollViewHeaderSliversBuilder headerSliverBuilder;

  final ScrollController scrollController;

  GSYNestedPullLoadWidget(
      this.control, this.itemBuilder, this.onRefresh, this.onLoadMore,
      {this.refreshKey, this.headerSliverBuilder, this.scrollController});

  @override
  _GSYNestedPullLoadWidgetState createState() =>
      _GSYNestedPullLoadWidgetState();
}

class _GSYNestedPullLoadWidgetState extends State<GSYNestedPullLoadWidget> {
  @override
  void initState() {
    super.initState();
  }

  ///根据配置状态返回实际列表数量
  ///实际上这里可以根据你的需要做更多的处理
  ///比如多个头部，是否需要空页面，是否需要显示加载更多。
  _getListCount(GSYPullLoadWidgetControl control) {
    ///是否需要头部
    if (control.needHeader) {
      ///如果需要头部，用Item 0 的 Widget 作为ListView的头部
      ///列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+1
      return (control.dataList.length > 0)
          ? control.dataList.length + 1
          : control.dataList.length + 1;
    } else {
      ///如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
      if (control.dataList.length == 0) {
        return 1;
      }

      ///如果有数据,因为部加载更多选项，需要对列表数据总数+1
      return (control.dataList.length > 0)
          ? control.dataList.length + 1
          : control.dataList.length;
    }
  }

  _lockToAwait() async {
    ///if loading, lock to await
    doDelayed() async {
      await Future.delayed(Duration(seconds: 1)).then((_) async {
        if (widget.control.isLoading) {
          return await doDelayed();
        } else {
          return null;
        }
      });
    }

    await doDelayed();
  }

  ///根据配置状态返回实际列表渲染Item
  _getItem(GSYPullLoadWidgetControl control, int index) {
    if (!control.needHeader &&
        index == control.dataList.length &&
        control.dataList.length != 0) {
      ///如果不需要头部，并且数据不为0，当index等于数据长度时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (control.needHeader &&
        index == _getListCount(control) - 1 &&
        control.dataList.length != 0) {
      ///如果需要头部，并且数据不为0，当index等于实际渲染长度 - 1时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (!control.needHeader && control.dataList.length == 0) {
      ///如果不需要头部，并且数据为0，渲染空页面
      return _buildEmpty();
    } else {
      ///回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index
      return widget.itemBuilder(context, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new NestedScrollViewRefreshIndicator(
      ///GlobalKey，用户外部获取RefreshIndicator的State，做显示刷新
      key: widget.refreshKey,
      child: NestedScrollView(
        ///滑动监听
        controller: widget.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        headerSliverBuilder: widget.headerSliverBuilder,
        body: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent) {
              if (widget.control.needLoadMore) {
                handleLoadMore();
              }
            }
            return false;
          },
          child: ChangeNotifierProvider<GSYPullLoadWidgetControl>(
              create: (context) => widget.control,
              child: Consumer<GSYPullLoadWidgetControl>(
                  builder: (context, control, _) {
                return ListView.builder(
                  itemBuilder: (_, index) {
                    return _getItem(control, index);
                  },

                  ///根据状态返回数量
                  itemCount: _getListCount(control),
                );
              })),
        ),
      ),

      ///下拉刷新触发，返回的是一个Future
      onRefresh: handleRefresh,
    );
  }

  @protected
  Future<Null> handleRefresh() async {
    if (widget.control.isLoading) {
      if (isRefreshing) {
        return null;
      }

      ///if loading, lock to await
      await _lockToAwait();
    }
    widget.control.isLoading = true;
    isRefreshing = true;
    await widget.onRefresh?.call();
    isRefreshing = false;
    widget.control.isLoading = false;
    return null;
  }

  @protected
  Future<Null> handleLoadMore() async {
    if (widget.control.isLoading) {
      if (isLoadMoring) {
        return null;
      }

      ///if loading, lock to await
      await _lockToAwait();
    }
    isLoadMoring = true;
    widget.control.isLoading = true;
    await widget.onLoadMore?.call();
    isLoadMoring = false;
    widget.control.isLoading = false;
    return null;
  }

  ///空页面
  Widget _buildEmpty() {
    return new Container(
      height: MediaQuery.of(context).size.height - 100,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: new Icon(
              Icons.hourglass_empty,
              size: 70,
            ),
          ),
          Container(
            child: Text(GSYLocalizations.i18n(context).app_empty,
                style: TextStyle(color: Color(0xFF121917), fontSize: 18.0)),
          ),
        ],
      ),
    );
  }

  ///上拉加载更多
  Widget _buildProgressIndicator() {
    ///是否需要显示上拉加载更多的loading
    Widget bottomWidget = (widget.control.needLoadMore)
        ? new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                ///loading框
                new SpinKitRotatingCircle(
                    color: Theme.of(context).primaryColor),
                new Container(
                  width: 5.0,
                ),

                ///加载中文本
                new Text(
                  GSYLocalizations.i18n(context).load_more_text,
                  style: TextStyle(
                    color: Color(0xFF121917),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ])

        /// 不需要加载
        : new Container();
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Center(
        child: bottomWidget,
      ),
    );
  }

  bool isRefreshing = false;

  bool isLoadMoring = false;
}
