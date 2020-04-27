import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gankclient/model/article_model.dart';
import 'package:gankclient/model/refresh_widget_model_delegate.dart';
import 'package:gankclient/net/address.dart';
import 'package:gankclient/net/api.dart';
import 'package:gankclient/page/gank_article_detail/gank_article_detail_page.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:gankclient/widget/article_list_item.dart';
import 'package:gankclient/widget/pull/gsy_pull_new_load_widget.dart';

class RandomListPage extends StatefulWidget {
  final String categoryKey;
  final String subclassKey;

  RandomListPage({
    Key key,
    this.subclassKey,
    this.categoryKey,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RandomListPageState();
}

class _RandomListPageState extends State<RandomListPage>{
  ArticleBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ArticleBloc(widget.categoryKey, widget.subclassKey);
  }

  @override
  void didChangeDependencies() {
    if (!bloc.requested) {
      bloc.refreshList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GSYPullLoadWidget(
          bloc.control(), itemBuilder, onRefresh, onLoadMore),
    );
  }

  Widget itemBuilder(BuildContext context, int index, data) {
    return ArticleListItem(
      index: index,
      model: data,
      onTap: (index, model) {
        CommonUtils.pushPage(context, GankArticleDetailPage(indexModel: model));
      },
    );
  }

  Future<void> onRefresh() async {
    return await bloc.refreshList();
  }

  Future<void> onLoadMore() async {
    return await bloc.requestLoadMore();
  }

  @override
  bool get wantKeepAlive => true;
}

class ArticleBloc {
  final String categoryKey;
  final String subclassKey;

  RefreshWidgetModelDelegate delegate;

  ArticleBloc(this.categoryKey, this.subclassKey) {
    delegate = new RefreshWidgetModelDelegate((page) {
      var key = randomKey();
      return httpManager.fetch(
          API.randomList(categoryKey ?? key[0], subclassKey ?? key[1], 50), {});
    }, (data) => getArticleModelList(data));
    delegate.pullLoadWidgetControl.needLoadMore = false;
  }

  List<String> randomKey() {
    var categoryList = ["Article", "GanHuo", "Girl"];
    var index = Random.secure().nextInt(2);
    var subclassList = ["Android", "iOS", "Flutter"];
    if (index == 2) {
      return [categoryList[2], categoryList[2]];
    } else {
      return [categoryList[index], subclassList[Random.secure().nextInt(2)]];
    }
  }

  bool _requested = false;

  ///是否已经请求过
  bool get requested => _requested;

  GSYPullLoadWidgetControl control() => delegate.pullLoadWidgetControl;

  Future<void> refreshList() => delegate.refreshList(methodPage: 50);

  Future<void> requestLoadMore() => delegate.requestLoadMore();
}
