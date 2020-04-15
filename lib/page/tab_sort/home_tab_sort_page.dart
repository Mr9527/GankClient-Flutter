import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gankclient/model/category_tab_model.dart';
import 'package:gankclient/net/address.dart';
import 'package:gankclient/net/api.dart';
import 'package:gankclient/style/style.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:gankclient/widget/main_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

class HomeTabSortPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeTabSortPageState();
}

class _HomeTabSortPageState extends State<HomeTabSortPage> {
  HomeTabSortBloc bloc = HomeTabSortBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text("首页展示配置"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () => showTipsDialog(context))
        ],
      ),
      body: Container(
          child: StreamBuilder<List<CategoryTabModel>>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.data != null) {
            return ReorderableListView(
                children: _rendererItems(), onReorder: _onReorder);
          } else {
            return Container();
          }
        },
      )),
    );
  }

  void showTipsDialog(BuildContext context) {
    CommonUtils.showCommonDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text(
              """通过修改本页的列表可以改同步改变首页 Tab 的展示数量和顺序
     1. 侧滑可以删除对应的配置项
     2. 长按可以调整顺序
     3. 这一切的调整在你下次启动应用时生效2
     4. 如果想要重置请前往设置清除首页配置缓存""",
              style: Theme.of(context).textTheme.display3,
            ),
          );
        });
  }

  _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex == bloc.list.length) {
        newIndex = bloc.list.length - 1;
      }
      var item = bloc.list.removeAt(oldIndex);
      bloc.list.insert(newIndex, item);
    });
  }

  Widget _listItemWidget(CategoryTabModel model) {
    return Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (_) {},
        key: ObjectKey(model.id),
        child: Container(
            height: 420.w,
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Card(
              child: Column(children: <Widget>[
                Image.network(model.coverImageUrl, scale: 0.1),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(model.desc,
                            style: Theme.of(context).textTheme.display2)))
              ]),
            )));
  }

  _rendererItems() {
    return bloc.list.map((m) => _listItemWidget(m)).toList();
  }
}

class DecorateCheckBox extends StatefulWidget {
  final bool value;
  final Function(bool value) onChanged;

  const DecorateCheckBox({Key key, this.value, this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DecorateCheckBoxState();
}

class _DecorateCheckBoxState extends State<DecorateCheckBox> {
  bool status;

  @override
  void initState() {
    super.initState();
    status = widget.value ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: status,
      onChanged: (value) {
        setState(() {
          this.status = !status;
        });
        widget.onChanged?.call(this.status);
      },
    );
  }
}

class HomeTabSortBloc {
  List<CategoryTabModel> list = [];
  BehaviorSubject<List<CategoryTabModel>> _subject =
      BehaviorSubject<List<CategoryTabModel>>();

  Stream<List<CategoryTabModel>> get stream => _subject;

  fetchData() async {
    var res = await httpManager.fetch(API.categoryTitleApi("GanHuo"), {});
    if (res != null && res.success) {
      list = getCategoryTabModelList(res.data);
      _subject.add(list);
    }
  }
}
