import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:gankclient/model/article_model.dart';
import 'package:gankclient/model/refresh_widget_model_delegate.dart';
import 'package:gankclient/net/address.dart';
import 'package:gankclient/net/api.dart';
import 'package:gankclient/widget/article_list_item.dart';
import 'package:gankclient/widget/pull/gsy_pull_new_load_widget.dart';

class CategoryListPage extends StatefulWidget {
  final String categoryKey;
  final String subclassKey;

  CategoryListPage({
    Key key,
    this.subclassKey,
    this.categoryKey,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage>
    with AutomaticKeepAliveClientMixin<CategoryListPage> {
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
    return GSYPullLoadWidget(
        bloc.control(), itemBuilder, onRefresh, onLoadMore);
  }

  Widget itemBuilder(BuildContext context, int index, data) {
    return ArticleListItem(
      index: index,
      model: data,
      onTap: (index, model) {},
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
    delegate = new RefreshWidgetModelDelegate(
        (page) => httpManager.fetch(
            API.categoryList(
                categoryKey ?? "all", subclassKey ?? "all", page, 10),
            {}),
        (data) => getArticleModelList(data));
  }

  bool _requested = false;

  ///是否已经请求过
  bool get requested => _requested;

  GSYPullLoadWidgetControl control() => delegate.pullLoadWidgetControl;

  Future<void> refreshList() => delegate.refreshList();

  Future<void> requestLoadMore() => delegate.requestLoadMore();
}
