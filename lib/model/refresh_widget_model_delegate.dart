import 'package:gankclient/net/result_data.dart';
import 'package:gankclient/widget/pull/gsy_pull_new_load_widget.dart';

class RefreshWidgetModelDelegate<T> {
  final GSYPullLoadWidgetControl pullLoadWidgetControl =
      new GSYPullLoadWidgetControl();


  int page = 1;

  RefreshWidgetModelDelegate(this.fetchData, this.convert);

  Future<void> refreshList({int methodPage = 1}) async {
    this.page = methodPage;
    var res = await fetchData(this.page);
    if (res != null && res.success) {
      var list = convert(res.data);
      if (page == 1 && list.length > 0) {
        pullLoadWidgetControl.dataList = list;
        pullLoadWidgetControl.needLoadMore = true;
      } else if (list.length > 0) {
        pullLoadWidgetControl.addList(list);
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
    refreshList(methodPage: ++page);
  }

  final Future<ResultData> Function(int page) fetchData;

  final List Function(dynamic data) convert;
}
