import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gankclient/page/category/category_list_page.dart';
import 'package:gankclient/page/tab_sort/home_tab_sort_page.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:gankclient/widget/main_app_bar.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryPageState();
}

class CategoryTab {
  final String name;
  final String key;

  CategoryTab(this.name, this.key);
}

List<CategoryTab> _defaultTabList = [
  CategoryTab("Flutter", "Flutter"),
  CategoryTab("Android", "Android"),
  CategoryTab("苹果", "iOS"),
  CategoryTab("前端", "frontend"),
  CategoryTab("后端", "backend"),
  CategoryTab("App", "app"),
];

class CategoryPageState extends State<CategoryPage>
    with
        AutomaticKeepAliveClientMixin<CategoryPage>,
        WidgetsBindingObserver,
        SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: _defaultTabList.length,
        child: Scaffold(
          appBar: MyAppBar(
            leading: Container(
                child: ClipOval(
              child: Image.network(
                'https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658',
                scale: 15.0,
              ),
            )),
            centerTitle: true,
            title: TabLayout(),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.menu), onPressed: () {
                CommonUtils.pushPage(context, HomeTabSortPage());
              })
            ],
          ),
          body: TabBarViewLayout(),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class TabBarViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        children: _defaultTabList.map((CategoryTab tab) {
      return CategoryListPage(categoryKey:"GanHuo",subclassKey: tab.key);
    }).toList());
  }
}

class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _tabBar = TabBar(
        isScrollable: true,
        //labelPadding: EdgeInsets.all(12.0),
        labelPadding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: _defaultTabList
            .map((CategoryTab page) => Tab(text: page.name))
            .toList(),
        onTap: (index) {});
    return _tabBar;
  }
}
