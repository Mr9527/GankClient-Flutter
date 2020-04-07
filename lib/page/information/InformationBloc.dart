import 'dart:convert';

import 'package:gankclient/model/banner_model.dart';
import 'package:gankclient/net/address.dart';
import 'package:gankclient/net/api.dart';
import 'package:rxdart/rxdart.dart';

class InformationBloc {
  bool _requested = false;

  ///是否已经请求过
  bool get requested => _requested;

  var _subject = PublishSubject<List<BannerModel>>();

  Observable<List<BannerModel>> get stream => _subject;

  Future<void> requestRefresh() async {
    var res = await httpManager.fetch(API.banner(), {});
    if(res!=null&&res.success){
      _subject.add(getBannerModelList(res.data));
    }
  }
}
