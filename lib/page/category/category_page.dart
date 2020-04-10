import 'package:flutter/cupertino.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage>
    with
        AutomaticKeepAliveClientMixin<CategoryPage>,
        WidgetsBindingObserver,
        SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}
