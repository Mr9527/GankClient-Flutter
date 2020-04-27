import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gankclient/db/category_config_provider.dart';
import 'package:gankclient/model/category_tab_model.dart';
import 'package:gankclient/page/category/category_list_page.dart';
import 'package:gankclient/page/tab_sort/home_tab_sort_page.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:gankclient/widget/main_app_bar.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryPageState();
}

List<CategoryTabModel> _defaultTabList = [
  CategoryTabModel(
      "5e59ec146d359d60b476e621",
      "http://gank.io/images/b9f867a055134a8fa45ef8a321616210",
      "Always deliver more than expected.（Larry Page）",
      "Android",
      "Android",
      0),
  CategoryTabModel(
      "5e59ed0e6e851660b43ec6bb",
      "http://gank.io/images/d435eaad954849a5b28979dd3d2674c7",
      "Innovation distinguishes between a leader and a follower.（Steve Jobs）",
      "苹果",
      "iOS",
      1),
  CategoryTabModel(
      "5e5a25346e851660b43ec6bc",
      "http://gank.io/images/c1ce555daf954961a05a69e64892b2cc",
      "The man who has made up his mind to win will never say “ Impossible”。（ Napoleon ）",
      "Flutter",
      "Flutter",
      2),
  CategoryTabModel(
      "5e5a254b6e851660b43ec6bd",
      "http://gank.io/images/4415653ca3b341be8c61fcbe8cd6c950",
      "Education is a progressive discovery of our own ignorance. （ W. Durant ）",
      "前端",
      "frontend",
      3),
  CategoryTabModel(
      "5e5a25716e851660b43ec6bf",
      "http://gank.io/images/c3c7e64f0c0647e3a6453ccf909e9780",
      "Do not, for one repulse, forgo the purpose that you resolved to effort. （ Shakespeare ）",
      "APP",
      "app",
      4),
];

class CategoryPageState extends State<CategoryPage>
    with
        AutomaticKeepAliveClientMixin<CategoryPage>,
        WidgetsBindingObserver,
        SingleTickerProviderStateMixin {
  var tabList;
  var tabFuture;

  @override
  void initState() {
    super.initState();
    tabFuture = _getTabData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: tabFuture,
        builder: (context, snapshot) {
          var list = snapshot.data;
          if (list == null) {
            return Container();
          }
          return DefaultTabController(
              length: list.length,
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
                  title: TabLayout(tabList: list,),
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          CommonUtils.pushPage(context, HomeTabSortPage());
                        })
                  ],
                ),
                body: TabBarViewLayout(tabList: list,),
              ));
        });
  }

  @override
  bool get wantKeepAlive => true;

  Future _getTabData() async {
    CategoryConfigProvider provider = new CategoryConfigProvider();
    var list = await provider.getData();
    if (list != null) {
      return list;
    } else {
      return _defaultTabList;
    }
  }
}

class TabBarViewLayout extends StatelessWidget {
  final List<CategoryTabModel> tabList;

  const TabBarViewLayout({Key key, this.tabList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        children: tabList.map((CategoryTabModel tab) {
      return CategoryListPage(categoryKey: "GanHuo", subclassKey: tab.type);
    }).toList());
  }
}

class TabLayout extends StatelessWidget {
  final List<CategoryTabModel> tabList;

  const TabLayout({Key key, this.tabList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _tabBar = TabBar(
        isScrollable: true,
        //labelPadding: EdgeInsets.all(12.0),
        labelPadding: EdgeInsets.only(left: 12.0, right: 12.0),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: tabList
            .map((CategoryTabModel page) => Tab(text: page.title))
            .toList(),
        onTap: (index) {});
    return _tabBar;
  }
}
