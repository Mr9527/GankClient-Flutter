import 'dart:convert';

import 'package:gankclient/event/index.dart';
import 'package:gankclient/model/article_model.dart';
import 'package:gankclient/model/banner_model.dart';
import 'package:gankclient/net/address.dart';
import 'package:gankclient/net/api.dart';
import 'package:gankclient/widget/pull/gsy_pull_new_load_widget.dart';
import 'package:rxdart/rxdart.dart';

class InformationBloc {
  bool _requested = false;

  ///是否已经请求过
  bool get requested {
    if (!_requested) {
      _requested = true;
      return false;
    }
    return true;
  }

  final GSYPullLoadWidgetControl pullLoadWidgetControl =
      new GSYPullLoadWidgetControl();

  int page = 1;

  var _subject = PublishSubject<List<BannerModel>>();

  Observable<List<BannerModel>> get stream => _subject;

  Future<void> requestRefresh() async {
    var res = await httpManager.fetch(API.banner(), {});
    if (res != null && res.success) {
      _subject.add(getBannerModelList(res.data));
    }
  }

  var _articleListSubject = PublishSubject<List<ArticleModel>>();

  Observable<List<ArticleModel>> get articleList => _articleListSubject;

  Future<void> refreshList({int page = 1}) async {
    if (page == 1) {
      this.page = 1;
    }
    pullLoadWidgetControl.isLoading = true;
    var res = await httpManager.fetch(API.articleList("Android", page), {});
    if (res != null && res.success) {
      var articleModelList = getArticleModelList(res.data);
      if (page == 1 && articleModelList.length > 0) {
        pullLoadWidgetControl.dataList = articleModelList;
        pullLoadWidgetControl.needLoadMore = true;
      } else if (articleModelList.length > 0) {
        pullLoadWidgetControl.addList(articleModelList);
        pullLoadWidgetControl.needLoadMore = true;
      } else {
        pullLoadWidgetControl.needLoadMore = false;
      }
    } else {
      pullLoadWidgetControl.needLoadMore = false;
    }
  }

  ///列表数据
  get dataList => pullLoadWidgetControl.dataList;

  requestLoadMore() async {
    await refreshList(page: ++page);
  }
}
